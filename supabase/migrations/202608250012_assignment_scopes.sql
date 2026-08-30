create type public.wird_assignment_scope as enum (
  'organization',
  'branch',
  'multiple_branches',
  'class',
  'role',
  'user'
);

alter table public.wird_programs
  add column scope_type public.wird_assignment_scope
    not null default 'multiple_branches';

create table public.wird_program_users (
  program_id uuid not null references public.wird_programs (id) on delete cascade,
  branch_user_id uuid not null references public.branch_users (id),
  primary key (program_id, branch_user_id)
);

alter table public.wird_program_users enable row level security;

create policy wird_program_users_select_for_managers
on public.wird_program_users for select
to authenticated
using (
  exists (
    select 1 from public.wird_programs p
     where p.id = program_id
       and public.can_manage_organization(p.organization_id)
  )
);

revoke all on public.wird_program_users from anon, authenticated;
grant select on public.wird_program_users to authenticated;

update public.wird_programs p
set scope_type = case
  when exists (
    select 1 from public.wird_program_classes c where c.program_id = p.id
  ) then 'class'::public.wird_assignment_scope
  when (
    select count(*) from public.wird_program_roles r where r.program_id = p.id
  ) between 1 and 3 then 'role'::public.wird_assignment_scope
  when (
    select count(*) from public.wird_program_branches b where b.program_id = p.id
  ) = 1 then 'branch'::public.wird_assignment_scope
  else 'multiple_branches'::public.wird_assignment_scope
end;

create or replace function public.create_wird_program_v2(
  p_organization_id uuid,
  p_name text,
  p_dhikr_definition_id uuid,
  p_target_count integer,
  p_starts_on date,
  p_ends_on date,
  p_audience_name text,
  p_scope_type text,
  p_branch_ids uuid[],
  p_class_ids uuid[],
  p_role_values text[],
  p_user_ids uuid[]
)
returns table (program_id uuid, assigned_count bigint)
language plpgsql
security definer
set search_path = ''
as $$
declare
  created_program_id uuid;
  selected_dhikr public.dhikr_definitions%rowtype;
  selected_scope public.wird_assignment_scope;
  created_assignments bigint;
begin
  if not public.can_manage_organization(p_organization_id) then
    raise exception 'Organization access denied.' using errcode = '42501';
  end if;
  begin
    selected_scope := p_scope_type::public.wird_assignment_scope;
  exception when invalid_text_representation then
    raise exception 'Invalid assignment scope.' using errcode = '22023';
  end;
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

  p_branch_ids := coalesce(p_branch_ids, '{}'::uuid[]);
  p_class_ids := coalesce(p_class_ids, '{}'::uuid[]);
  p_role_values := coalesce(p_role_values, '{}'::text[]);
  p_user_ids := coalesce(p_user_ids, '{}'::uuid[]);

  if selected_scope = 'organization' and (
    cardinality(p_branch_ids) <> 0 or cardinality(p_class_ids) <> 0
    or cardinality(p_role_values) <> 0 or cardinality(p_user_ids) <> 0
  ) then
    raise exception 'Organization scope cannot have filters.' using errcode = '22023';
  elsif selected_scope = 'branch' and (
    cardinality(p_branch_ids) <> 1 or cardinality(p_class_ids) <> 0
    or cardinality(p_role_values) <> 0 or cardinality(p_user_ids) <> 0
  ) then
    raise exception 'Branch scope requires exactly one branch.' using errcode = '22023';
  elsif selected_scope = 'multiple_branches' and (
    cardinality(p_branch_ids) < 2 or cardinality(p_class_ids) <> 0
    or cardinality(p_role_values) <> 0 or cardinality(p_user_ids) <> 0
  ) then
    raise exception 'Multiple branch scope requires at least two branches.' using errcode = '22023';
  elsif selected_scope = 'class' and (
    cardinality(p_class_ids) <> 1 or cardinality(p_branch_ids) <> 0
    or cardinality(p_role_values) <> 0 or cardinality(p_user_ids) <> 0
  ) then
    raise exception 'Class scope requires exactly one class.' using errcode = '22023';
  elsif selected_scope = 'role' and (
    cardinality(p_role_values) = 0 or cardinality(p_branch_ids) <> 0
    or cardinality(p_class_ids) <> 0 or cardinality(p_user_ids) <> 0
  ) then
    raise exception 'Role scope requires at least one role.' using errcode = '22023';
  elsif selected_scope = 'user' and (
    cardinality(p_user_ids) <> 1 or cardinality(p_branch_ids) <> 0
    or cardinality(p_class_ids) <> 0 or cardinality(p_role_values) <> 0
  ) then
    raise exception 'User scope requires exactly one user.' using errcode = '22023';
  end if;

  if exists (
    select 1 from unnest(p_role_values) role_value
     where role_value not in (
       'child', 'teacher', 'administrator', 'branch_manager'
     )
  ) then
    raise exception 'Invalid audience role.' using errcode = '22023';
  end if;
  if cardinality(p_branch_ids) > 0 and (
    select count(*) from public.branches b
     where b.id = any(p_branch_ids)
       and b.organization_id = p_organization_id
       and b.deleted_at is null
  ) <> cardinality(p_branch_ids) then
    raise exception 'A selected branch is unavailable.' using errcode = '23514';
  end if;
  if cardinality(p_class_ids) > 0 and (
    select count(*) from public.classes c
      join public.branches b on b.id = c.branch_id
     where c.id = any(p_class_ids)
       and c.deleted_at is null and b.deleted_at is null
       and b.organization_id = p_organization_id
  ) <> cardinality(p_class_ids) then
    raise exception 'A selected class is unavailable.' using errcode = '23514';
  end if;
  if cardinality(p_user_ids) > 0 and (
    select count(*) from public.branch_users u
      join public.branches b on b.id = u.branch_id
     where u.id = any(p_user_ids)
       and u.deleted_at is null and b.deleted_at is null
       and b.organization_id = p_organization_id
  ) <> cardinality(p_user_ids) then
    raise exception 'A selected user is unavailable.' using errcode = '23514';
  end if;

  select * into selected_dhikr from public.dhikr_definitions d
   where d.id = p_dhikr_definition_id and d.status = 'approved';
  if selected_dhikr.id is null then
    raise exception 'Only an approved dhikr can be used.' using errcode = '23514';
  end if;

  insert into public.wird_programs (
    organization_id, name, dhikr_definition_id,
    dhikr_title_snapshot, dhikr_text_snapshot, target_count,
    starts_on, ends_on, audience_name, scope_type
  ) values (
    p_organization_id, btrim(p_name), selected_dhikr.id,
    selected_dhikr.title, selected_dhikr.display_text, p_target_count,
    p_starts_on, p_ends_on, btrim(p_audience_name), selected_scope
  ) returning id into created_program_id;

  insert into public.wird_program_branches (program_id, branch_id)
    select created_program_id, branch_id from unnest(p_branch_ids) branch_id;
  insert into public.wird_program_classes (program_id, class_id)
    select created_program_id, class_id from unnest(p_class_ids) class_id;
  insert into public.wird_program_roles (program_id, user_type)
    select created_program_id, role_value::public.managed_user_type
      from unnest(p_role_values) role_value;
  insert into public.wird_program_users (program_id, branch_user_id)
    select created_program_id, user_id from unnest(p_user_ids) user_id;

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
  join public.branches b on b.id = u.branch_id
  where b.organization_id = p_organization_id
    and b.deleted_at is null and u.deleted_at is null
    and case selected_scope
      when 'organization' then true
      when 'branch' then u.branch_id = any(p_branch_ids)
      when 'multiple_branches' then u.branch_id = any(p_branch_ids)
      when 'class' then u.class_id = any(p_class_ids)
      when 'role' then u.user_type::text = any(p_role_values)
      when 'user' then u.id = any(p_user_ids)
    end;
  get diagnostics created_assignments = row_count;

  return query select created_program_id, created_assignments;
end;
$$;

revoke all on function public.create_wird_program_v2(
  uuid, text, uuid, integer, date, date, text, text,
  uuid[], uuid[], text[], uuid[]
) from public;
grant execute on function public.create_wird_program_v2(
  uuid, text, uuid, integer, date, date, text, text,
  uuid[], uuid[], text[], uuid[]
) to authenticated;

revoke execute on function public.create_wird_program(
  uuid, text, uuid, integer, date, date, text, uuid[], uuid[], text[]
) from authenticated;

