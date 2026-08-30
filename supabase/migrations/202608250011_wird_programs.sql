create table public.wird_programs (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations (id),
  name varchar(160) not null check (length(btrim(name)) between 1 and 160),
  dhikr_definition_id uuid not null references public.dhikr_definitions (id),
  dhikr_title_snapshot varchar(160) not null,
  dhikr_text_snapshot text not null,
  target_count integer not null check (target_count between 1 and 100000),
  starts_on date not null,
  ends_on date not null,
  timezone_name varchar(64) not null default 'Asia/Damascus',
  audience_name varchar(200) not null check (
    length(btrim(audience_name)) between 1 and 200
  ),
  created_by uuid not null default auth.uid() references public.profiles (id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint wird_program_valid_dates check (ends_on >= starts_on)
);

create table public.wird_program_branches (
  program_id uuid not null references public.wird_programs (id) on delete cascade,
  branch_id uuid not null references public.branches (id),
  primary key (program_id, branch_id)
);

create table public.wird_program_classes (
  program_id uuid not null references public.wird_programs (id) on delete cascade,
  class_id uuid not null references public.classes (id),
  primary key (program_id, class_id)
);

create table public.wird_program_roles (
  program_id uuid not null references public.wird_programs (id) on delete cascade,
  user_type public.managed_user_type not null,
  primary key (program_id, user_type)
);

alter table public.managed_wirds
  add column wird_program_id uuid references public.wird_programs (id),
  add column dhikr_definition_id uuid references public.dhikr_definitions (id),
  add column dhikr_title_snapshot varchar(160),
  add column dhikr_text_snapshot text,
  add column available_from date,
  add column available_until date,
  add column availability_timezone varchar(64),
  add constraint managed_wird_valid_availability check (
    available_from is null
    or available_until is null
    or available_until >= available_from
  );

create unique index managed_wirds_program_user_unique
  on public.managed_wirds (wird_program_id, assigned_user_id)
  where wird_program_id is not null;

create index wird_programs_organization_dates_idx
  on public.wird_programs (organization_id, starts_on desc, ends_on desc);

create trigger wird_programs_set_updated_at
before update on public.wird_programs
for each row execute function public.set_updated_at();

alter table public.wird_programs enable row level security;
alter table public.wird_program_branches enable row level security;
alter table public.wird_program_classes enable row level security;
alter table public.wird_program_roles enable row level security;

create policy wird_programs_select_for_managers
on public.wird_programs for select
to authenticated
using (public.can_manage_organization(organization_id));

create policy wird_program_branches_select_for_managers
on public.wird_program_branches for select
to authenticated
using (
  exists (
    select 1 from public.wird_programs p
     where p.id = program_id
       and public.can_manage_organization(p.organization_id)
  )
);

create policy wird_program_classes_select_for_managers
on public.wird_program_classes for select
to authenticated
using (
  exists (
    select 1 from public.wird_programs p
     where p.id = program_id
       and public.can_manage_organization(p.organization_id)
  )
);

create policy wird_program_roles_select_for_managers
on public.wird_program_roles for select
to authenticated
using (
  exists (
    select 1 from public.wird_programs p
     where p.id = program_id
       and public.can_manage_organization(p.organization_id)
  )
);

revoke all on public.wird_programs from anon, authenticated;
revoke all on public.wird_program_branches from anon, authenticated;
revoke all on public.wird_program_classes from anon, authenticated;
revoke all on public.wird_program_roles from anon, authenticated;
grant select on public.wird_programs to authenticated;
grant select on public.wird_program_branches to authenticated;
grant select on public.wird_program_classes to authenticated;
grant select on public.wird_program_roles to authenticated;

create or replace function public.create_wird_program(
  p_organization_id uuid,
  p_name text,
  p_dhikr_definition_id uuid,
  p_target_count integer,
  p_starts_on date,
  p_ends_on date,
  p_audience_name text,
  p_branch_ids uuid[],
  p_class_ids uuid[],
  p_role_values text[]
)
returns table (program_id uuid, assigned_count bigint)
language plpgsql
security definer
set search_path = ''
as $$
declare
  created_program_id uuid;
  selected_dhikr public.dhikr_definitions%rowtype;
  created_assignments bigint;
begin
  if not public.can_manage_organization(p_organization_id) then
    raise exception 'Organization access denied.' using errcode = '42501';
  end if;
  if p_name is null or length(btrim(p_name)) = 0 then
    raise exception 'A wird name is required.' using errcode = '22023';
  end if;
  if p_audience_name is null or length(btrim(p_audience_name)) = 0 then
    raise exception 'An audience name is required.' using errcode = '22023';
  end if;
  if p_target_count not between 1 and 100000 then
    raise exception 'Invalid target.' using errcode = '22023';
  end if;
  if p_starts_on is null or p_ends_on is null or p_ends_on < p_starts_on then
    raise exception 'Invalid date range.' using errcode = '22023';
  end if;
  if coalesce(cardinality(p_branch_ids), 0) = 0 then
    raise exception 'At least one branch is required.' using errcode = '22023';
  end if;
  if coalesce(cardinality(p_role_values), 0) = 0 then
    raise exception 'At least one role is required.' using errcode = '22023';
  end if;
  if exists (
    select 1 from unnest(p_role_values) role_value
     where role_value not in (
       'child', 'teacher', 'administrator', 'branch_manager'
     )
  ) then
    raise exception 'Invalid audience role.' using errcode = '22023';
  end if;
  if (
    select count(*)
      from public.branches b
     where b.id = any(p_branch_ids)
       and b.organization_id = p_organization_id
       and b.deleted_at is null
  ) <> cardinality(p_branch_ids) then
    raise exception 'A selected branch is unavailable.' using errcode = '23514';
  end if;
  if coalesce(cardinality(p_class_ids), 0) > 0 and (
    select count(*)
      from public.classes c
      join public.branches b on b.id = c.branch_id
     where c.id = any(p_class_ids)
       and c.branch_id = any(p_branch_ids)
       and c.deleted_at is null
       and b.organization_id = p_organization_id
       and b.deleted_at is null
  ) <> cardinality(p_class_ids) then
    raise exception 'A selected class is unavailable.' using errcode = '23514';
  end if;

  select * into selected_dhikr
    from public.dhikr_definitions d
   where d.id = p_dhikr_definition_id
     and d.status = 'approved';
  if selected_dhikr.id is null then
    raise exception 'Only an approved dhikr can be used.' using errcode = '23514';
  end if;

  insert into public.wird_programs (
    organization_id, name, dhikr_definition_id,
    dhikr_title_snapshot, dhikr_text_snapshot, target_count,
    starts_on, ends_on, audience_name
  ) values (
    p_organization_id, btrim(p_name), selected_dhikr.id,
    selected_dhikr.title, selected_dhikr.display_text, p_target_count,
    p_starts_on, p_ends_on, btrim(p_audience_name)
  ) returning id into created_program_id;

  insert into public.wird_program_branches (program_id, branch_id)
    select created_program_id, branch_id from unnest(p_branch_ids) branch_id;
  insert into public.wird_program_classes (program_id, class_id)
    select created_program_id, class_id from unnest(p_class_ids) class_id;
  insert into public.wird_program_roles (program_id, user_type)
    select created_program_id, role_value::public.managed_user_type
      from unnest(p_role_values) role_value;

  insert into public.managed_wirds (
    branch_id, assigned_user_id, title, details, target_count,
    status, assigned_at, created_by, wird_program_id,
    dhikr_definition_id, dhikr_title_snapshot, dhikr_text_snapshot,
    available_from, available_until, availability_timezone
  )
  select
    u.branch_id, u.id, btrim(p_name), selected_dhikr.title,
    p_target_count, 'assigned', now(), auth.uid(), created_program_id,
    selected_dhikr.id, selected_dhikr.title, selected_dhikr.display_text,
    p_starts_on, p_ends_on, 'Asia/Damascus'
  from public.branch_users u
  where u.branch_id = any(p_branch_ids)
    and u.user_type::text = any(p_role_values)
    and u.deleted_at is null
    and (
      coalesce(cardinality(p_class_ids), 0) = 0
      or u.class_id = any(p_class_ids)
    );
  get diagnostics created_assignments = row_count;

  return query select created_program_id, created_assignments;
end;
$$;

revoke all on function public.create_wird_program(
  uuid, text, uuid, integer, date, date, text, uuid[], uuid[], text[]
) from public;
grant execute on function public.create_wird_program(
  uuid, text, uuid, integer, date, date, text, uuid[], uuid[], text[]
) to authenticated;

create or replace function public.validate_wird_availability_for_mutation()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  starts_on date;
  ends_on date;
  zone_name text;
  local_day date;
begin
  if exists (
    select 1 from public.managed_wird_mutations m
     where m.operation_id = new.operation_id
  ) then
    return new;
  end if;
  select w.available_from, w.available_until, w.availability_timezone
    into starts_on, ends_on, zone_name
    from public.managed_wirds w
   where w.id = new.wird_id;
  local_day := (now() at time zone coalesce(zone_name, 'UTC'))::date;
  if starts_on is not null and local_day < starts_on then
    raise exception 'The wird has not started yet.' using errcode = '22023';
  end if;
  if ends_on is not null and local_day > ends_on then
    raise exception 'The wird has ended.' using errcode = '22023';
  end if;
  return new;
end;
$$;

create trigger managed_wird_mutations_validate_availability
before insert on public.managed_wird_mutations
for each row execute function public.validate_wird_availability_for_mutation();

revoke all on function public.validate_wird_availability_for_mutation()
  from public;
