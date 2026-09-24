create type public.dhikr_lifecycle_status as enum (
  'draft', 'in_review', 'approved', 'archived'
);

create type public.wird_lifecycle_status as enum (
  'draft', 'scheduled', 'active', 'ended', 'cancelled'
);

create type public.wird_assignment_scope as enum (
  'organization', 'branch', 'class', 'role', 'user'
);

create type public.wird_assignment_status as enum ('active', 'revoked');
create type public.user_wird_instance_status as enum ('assigned', 'cancelled');

create table public.dhikr_definitions (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations(id) on delete restrict,
  owner_branch_id uuid,
  title text not null,
  display_text text not null,
  description text,
  default_target integer not null,
  status public.dhikr_lifecycle_status not null default 'draft',
  source_reference text,
  content_version integer not null default 1,
  content_checksum text generated always as (
    encode(digest(title || E'\n' || display_text || E'\n' ||
      coalesce(description, '') || E'\n' || default_target::text, 'sha256'), 'hex')
  ) stored,
  created_by uuid not null,
  reviewed_by uuid,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint dhikr_owner_branch_tenant_fk foreign key (organization_id, owner_branch_id)
    references public.branches(organization_id, id) on delete restrict,
  constraint dhikr_creator_tenant_fk foreign key (organization_id, created_by)
    references public.profiles(organization_id, id) on delete restrict,
  constraint dhikr_reviewer_tenant_fk foreign key (organization_id, reviewed_by)
    references public.profiles(organization_id, id) on delete restrict,
  constraint dhikr_title_not_blank check (btrim(title) <> ''),
  constraint dhikr_display_text_not_blank check (btrim(display_text) <> ''),
  constraint dhikr_target_positive check (default_target between 1 and 100000),
  constraint dhikr_content_version_positive check (content_version > 0),
  constraint dhikr_approval_evidence check (
    status <> 'approved' or (
      source_reference is not null and btrim(source_reference) <> '' and
      reviewed_by is not null and reviewed_at is not null
    )
  ),
  constraint dhikr_tenant_id_unique unique (organization_id, id)
);

create table public.wirds (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations(id) on delete restrict,
  owner_branch_id uuid,
  dhikr_id uuid not null,
  title text not null,
  description text,
  target_count integer not null,
  start_at timestamptz not null,
  end_at timestamptz not null,
  status public.wird_lifecycle_status not null default 'draft',
  created_by uuid not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint wird_owner_branch_tenant_fk foreign key (organization_id, owner_branch_id)
    references public.branches(organization_id, id) on delete restrict,
  constraint wird_dhikr_tenant_fk foreign key (organization_id, dhikr_id)
    references public.dhikr_definitions(organization_id, id) on delete restrict,
  constraint wird_creator_tenant_fk foreign key (organization_id, created_by)
    references public.profiles(organization_id, id) on delete restrict,
  constraint wird_title_not_blank check (btrim(title) <> ''),
  constraint wird_target_positive check (target_count between 1 and 100000),
  constraint wird_valid_window check (end_at > start_at),
  constraint wird_tenant_id_unique unique (organization_id, id)
);

create table public.wird_assignments (
  id uuid primary key default gen_random_uuid(),
  wird_id uuid not null,
  organization_id uuid not null,
  scope_type public.wird_assignment_scope not null,
  branch_id uuid,
  class_id uuid,
  role text,
  user_id uuid,
  status public.wird_assignment_status not null default 'active',
  created_by uuid not null,
  revoked_at timestamptz,
  created_at timestamptz not null default now(),
  constraint assignment_wird_tenant_fk foreign key (organization_id, wird_id)
    references public.wirds(organization_id, id) on delete restrict,
  constraint assignment_branch_tenant_fk foreign key (organization_id, branch_id)
    references public.branches(organization_id, id) on delete restrict,
  constraint assignment_class_tenant_fk foreign key (organization_id, branch_id, class_id)
    references public.classes(organization_id, branch_id, id) on delete restrict,
  constraint assignment_user_tenant_fk foreign key (organization_id, user_id)
    references public.profiles(organization_id, id) on delete restrict,
  constraint assignment_creator_tenant_fk foreign key (organization_id, created_by)
    references public.profiles(organization_id, id) on delete restrict,
  constraint assignment_role_valid check (role is null or role in (
    'organization_admin', 'branch_manager', 'admin', 'teacher', 'staff', 'student'
  )),
  constraint assignment_revocation_shape check (
    (status = 'active' and revoked_at is null) or
    (status = 'revoked' and revoked_at is not null)
  ),
  constraint assignment_scope_shape check (
    (scope_type = 'organization' and branch_id is null and class_id is null and role is null and user_id is null) or
    (scope_type = 'branch' and branch_id is not null and class_id is null and role is null and user_id is null) or
    (scope_type = 'class' and branch_id is not null and class_id is not null and role is null and user_id is null) or
    (scope_type = 'role' and class_id is null and role is not null and user_id is null) or
    (scope_type = 'user' and class_id is null and role is null and user_id is not null)
  ),
  constraint assignment_tenant_source_unique unique (
    organization_id, wird_id, id, scope_type
  )
);

create unique index wird_assignments_active_scope_unique
  on public.wird_assignments (
    wird_id, scope_type,
    coalesce(branch_id, '00000000-0000-0000-0000-000000000000'::uuid),
    coalesce(class_id, '00000000-0000-0000-0000-000000000000'::uuid),
    coalesce(role, ''),
    coalesce(user_id, '00000000-0000-0000-0000-000000000000'::uuid)
  ) where status = 'active';

create table public.user_wird_instances (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null,
  branch_id uuid,
  class_id uuid,
  user_id uuid not null,
  wird_id uuid not null,
  assignment_id uuid not null,
  assignment_scope_type public.wird_assignment_scope not null,
  wird_title_snapshot text not null,
  dhikr_title_snapshot text not null,
  dhikr_text_snapshot text not null,
  target_count integer not null,
  start_at timestamptz not null,
  end_at timestamptz not null,
  timezone_name text not null,
  status public.user_wird_instance_status not null default 'assigned',
  created_at timestamptz not null default now(),
  constraint instance_user_tenant_fk foreign key (organization_id, user_id)
    references public.profiles(organization_id, id) on delete restrict,
  constraint instance_user_branch_fk foreign key (organization_id, branch_id, user_id)
    references public.profiles(organization_id, branch_id, id) on delete restrict,
  constraint instance_branch_tenant_fk foreign key (organization_id, branch_id)
    references public.branches(organization_id, id) on delete restrict,
  constraint instance_class_tenant_fk foreign key (organization_id, branch_id, class_id)
    references public.classes(organization_id, branch_id, id) on delete restrict,
  constraint instance_wird_tenant_fk foreign key (organization_id, wird_id)
    references public.wirds(organization_id, id) on delete restrict,
  constraint instance_assignment_source_fk foreign key (
    organization_id, wird_id, assignment_id, assignment_scope_type
  ) references public.wird_assignments(
    organization_id, wird_id, id, scope_type
  ) on delete restrict,
  constraint instance_title_not_blank check (btrim(wird_title_snapshot) <> ''),
  constraint instance_dhikr_title_not_blank check (btrim(dhikr_title_snapshot) <> ''),
  constraint instance_dhikr_text_not_blank check (btrim(dhikr_text_snapshot) <> ''),
  constraint instance_target_positive check (target_count between 1 and 100000),
  constraint instance_valid_window check (end_at > start_at),
  constraint instance_timezone_not_blank check (btrim(timezone_name) <> ''),
  constraint instance_user_wird_unique unique (user_id, wird_id)
);

create index dhikr_definitions_tenant_status_idx
  on public.dhikr_definitions(organization_id, status, title);
create index wirds_tenant_window_idx
  on public.wirds(organization_id, status, start_at, end_at);
create index wird_assignments_wird_active_idx
  on public.wird_assignments(wird_id, status);
create index wird_assignments_branch_idx
  on public.wird_assignments(organization_id, branch_id, status);
create index user_wird_instances_today_idx
  on public.user_wird_instances(user_id, status, start_at, end_at);
create index user_wird_instances_manager_idx
  on public.user_wird_instances(organization_id, branch_id, created_at desc);

create function app_private.actor_can_manage_stage4(
  target_organization_id uuid, target_owner_branch_id uuid
) returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    join public.organizations o on o.id = p.organization_id and o.status = 'active'
    left join public.branches b on b.id = p.branch_id and b.organization_id = p.organization_id
    where p.id = auth.uid() and p.status = 'active'
      and p.organization_id = target_organization_id
      and (
        p.role = 'organization_admin'
        or (p.role in ('branch_manager', 'admin') and p.branch_id = target_owner_branch_id and b.status = 'active')
      )
  );
$$;

create function app_private.actor_can_read_stage4_instance(
  target_organization_id uuid, target_branch_id uuid, target_class_id uuid,
  target_user_id uuid, target_wird_id uuid,
  target_status public.user_wird_instance_status,
  target_start_at timestamptz, target_end_at timestamptz
) returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    join public.organizations o on o.id = p.organization_id and o.status = 'active'
    left join public.branches actor_branch on actor_branch.id = p.branch_id
      and actor_branch.organization_id = p.organization_id
    where p.id = auth.uid() and p.status = 'active'
      and p.organization_id = target_organization_id
      and (
        p.role = 'organization_admin'
        or (p.role in ('branch_manager', 'admin') and p.branch_id = target_branch_id)
        or (
          p.id = target_user_id
          and (p.branch_id is null or actor_branch.status = 'active')
          and target_status = 'assigned'
          and now() >= target_start_at and now() < target_end_at
          and exists (
            select 1 from public.wirds w
            where w.id = target_wird_id
              and w.organization_id = target_organization_id
              and w.status = 'active'
          )
          and (
            p.role <> 'student'
            or exists (
              select 1 from public.students s
              join public.classes c on c.id = s.class_id
                and c.organization_id = s.organization_id
                and c.branch_id = s.branch_id
              where s.profile_id = p.id and s.status = 'active'
                and s.class_id = target_class_id and c.status = 'active'
            )
          )
        )
      )
  );
$$;

create function app_private.actor_is_stage4_manager(target_organization_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    join public.organizations o on o.id = p.organization_id and o.status = 'active'
    left join public.branches b on b.id = p.branch_id
      and b.organization_id = p.organization_id
    where p.id = auth.uid() and p.status = 'active'
      and p.organization_id = target_organization_id
      and p.role in ('organization_admin', 'branch_manager', 'admin')
      and (p.role = 'organization_admin' or b.status = 'active')
  );
$$;

create function app_private.validate_dhikr_lifecycle()
returns trigger language plpgsql set search_path = '' as $$
begin
  if tg_op = 'UPDATE' and old.status <> new.status and not (
    (old.status = 'draft' and new.status in ('in_review', 'archived')) or
    (old.status = 'in_review' and new.status in ('draft', 'approved', 'archived')) or
    (old.status = 'approved' and new.status = 'archived') or
    (old.status = 'archived' and new.status = 'draft')
  ) then raise exception 'Invalid dhikr lifecycle transition.' using errcode = '23514'; end if;
  if tg_op = 'UPDATE' and (
    old.title, old.display_text, old.description, old.default_target
  ) is distinct from (
    new.title, new.display_text, new.description, new.default_target
  ) then new.content_version := old.content_version + 1; end if;
  new.updated_at := now();
  return new;
end;
$$;

create function app_private.validate_wird_lifecycle()
returns trigger language plpgsql set search_path = '' as $$
begin
  if tg_op = 'UPDATE' and old.status <> new.status and not (
    (old.status = 'draft' and new.status in ('scheduled', 'cancelled')) or
    (old.status = 'scheduled' and new.status in ('active', 'cancelled')) or
    (old.status = 'active' and new.status in ('ended', 'cancelled'))
  ) then raise exception 'Invalid wird lifecycle transition.' using errcode = '23514'; end if;
  new.updated_at := now();
  return new;
end;
$$;

create function app_private.prevent_instance_mutation()
returns trigger language plpgsql set search_path = '' as $$
begin raise exception 'User wird instances are immutable.' using errcode = '42501'; end;
$$;

create trigger dhikr_validate_lifecycle before update on public.dhikr_definitions
for each row execute function app_private.validate_dhikr_lifecycle();
create trigger wird_validate_lifecycle before update on public.wirds
for each row execute function app_private.validate_wird_lifecycle();
create trigger user_wird_instances_immutable before update or delete on public.user_wird_instances
for each row execute function app_private.prevent_instance_mutation();

create function app_private.validate_assignment_target()
returns trigger language plpgsql security definer set search_path = '' as $$
declare target_profile public.profiles%rowtype;
begin
  if new.scope_type = 'user' then
    select * into target_profile from public.profiles p
      where p.id = new.user_id and p.organization_id = new.organization_id;
    if target_profile.id is null or target_profile.status <> 'active' then
      raise exception 'Invalid target user.' using errcode = '23503';
    end if;
    if new.branch_id is distinct from target_profile.branch_id then
      raise exception 'User branch scope mismatch.' using errcode = '23514';
    end if;
  end if;
  return new;
end;
$$;
create trigger assignment_validate_target before insert on public.wird_assignments
for each row execute function app_private.validate_assignment_target();

create function app_private.materialize_wird_assignment(target_assignment_id uuid)
returns bigint language plpgsql security definer set search_path = '' as $$
declare inserted_count bigint;
begin
  insert into public.user_wird_instances (
    organization_id, branch_id, class_id, user_id, wird_id, assignment_id,
    assignment_scope_type, wird_title_snapshot, dhikr_title_snapshot,
    dhikr_text_snapshot, target_count, start_at, end_at, timezone_name
  )
  select a.organization_id, p.branch_id, s.class_id, p.id, w.id, a.id,
    a.scope_type, w.title, d.title, d.display_text, w.target_count,
    w.start_at, w.end_at, o.timezone
  from public.wird_assignments a
  join public.wirds w on w.id = a.wird_id and w.organization_id = a.organization_id
  join public.dhikr_definitions d on d.id = w.dhikr_id and d.organization_id = w.organization_id
  join public.organizations o on o.id = a.organization_id
  join public.profiles p on p.organization_id = a.organization_id and p.status = 'active'
  left join public.students s on s.profile_id = p.id and s.status = 'active'
  left join public.branches b on b.id = p.branch_id and b.organization_id = p.organization_id
  left join public.classes c on c.id = s.class_id and c.branch_id = p.branch_id and c.organization_id = p.organization_id
  where a.id = target_assignment_id and a.status = 'active'
    and o.status = 'active'
    and (p.branch_id is null or b.status = 'active')
    and (p.role <> 'student' or (s.id is not null and c.status = 'active'))
    and case a.scope_type
      when 'organization' then true
      when 'branch' then p.branch_id = a.branch_id
      when 'class' then s.class_id = a.class_id and p.branch_id = a.branch_id
      when 'role' then p.role = a.role and (a.branch_id is null or p.branch_id = a.branch_id)
      when 'user' then p.id = a.user_id
    end
  on conflict (user_id, wird_id) do nothing;
  get diagnostics inserted_count = row_count;
  return inserted_count;
end;
$$;

create function public.save_dhikr_definition(
  p_id uuid, p_organization_id uuid, p_title text, p_display_text text,
  p_description text, p_default_target integer, p_status text,
  p_source_reference text
) returns public.dhikr_definitions
language plpgsql security definer set search_path = '' as $$
declare actor public.profiles%rowtype; current_row public.dhikr_definitions%rowtype; result public.dhikr_definitions%rowtype;
begin
  select * into actor from public.profiles where id = auth.uid() and status = 'active';
  if actor.id is null or actor.organization_id <> p_organization_id or actor.role not in ('organization_admin','branch_manager','admin') then
    raise exception 'Stage 4 management denied.' using errcode = '42501'; end if;
  if not app_private.actor_can_manage_stage4(
    p_organization_id, case when actor.role = 'organization_admin' then null else actor.branch_id end
  ) then raise exception 'Inactive organization or branch.' using errcode = '42501'; end if;
  if p_title is null or btrim(p_title) = '' or p_display_text is null or btrim(p_display_text) = '' or p_default_target not between 1 and 100000 then
    raise exception 'Invalid dhikr content.' using errcode = '22023'; end if;
  if p_status not in ('draft','in_review','approved','archived') then raise exception 'Invalid dhikr status.' using errcode = '22023'; end if;
  if actor.role <> 'organization_admin' and p_status in ('approved','archived') then
    raise exception 'Only organization administrators may approve or archive dhikr.' using errcode = '42501'; end if;
  if p_id is null then
    if p_status not in ('draft','in_review') then
      raise exception 'New dhikr must begin as draft or in review.' using errcode = '23514'; end if;
    insert into public.dhikr_definitions (
      organization_id, owner_branch_id, title, display_text, description,
      default_target, status, source_reference, created_by, reviewed_by, reviewed_at
    ) values (
      p_organization_id, case when actor.role = 'organization_admin' then null else actor.branch_id end,
      btrim(p_title), btrim(p_display_text), nullif(btrim(p_description), ''), p_default_target,
      p_status::public.dhikr_lifecycle_status, nullif(btrim(p_source_reference), ''), actor.id,
      case when p_status = 'approved' then actor.id end,
      case when p_status = 'approved' then now() end
    ) returning * into result;
  else
    select * into current_row from public.dhikr_definitions where id = p_id and organization_id = p_organization_id;
    if current_row.id is null or not app_private.actor_can_manage_stage4(current_row.organization_id, current_row.owner_branch_id) then
      raise exception 'Dhikr access denied.' using errcode = '42501'; end if;
    update public.dhikr_definitions set
      title = btrim(p_title), display_text = btrim(p_display_text), description = nullif(btrim(p_description), ''),
      default_target = p_default_target, status = p_status::public.dhikr_lifecycle_status,
      source_reference = nullif(btrim(p_source_reference), ''),
      reviewed_by = case when p_status = 'approved' then actor.id else reviewed_by end,
      reviewed_at = case when p_status = 'approved' then now() else reviewed_at end
    where id = p_id returning * into result;
  end if;
  return result;
end;
$$;

create function public.save_wird(
  p_id uuid, p_organization_id uuid, p_dhikr_id uuid, p_title text,
  p_description text, p_target_count integer, p_start_at timestamptz,
  p_end_at timestamptz, p_status text
) returns public.wirds
language plpgsql security definer set search_path = '' as $$
declare actor public.profiles%rowtype; current_row public.wirds%rowtype; result public.wirds%rowtype;
begin
  select * into actor from public.profiles where id = auth.uid() and status = 'active';
  if actor.id is null or actor.organization_id <> p_organization_id or actor.role not in ('organization_admin','branch_manager','admin') then
    raise exception 'Stage 4 management denied.' using errcode = '42501'; end if;
  if not app_private.actor_can_manage_stage4(
    p_organization_id, case when actor.role = 'organization_admin' then null else actor.branch_id end
  ) then raise exception 'Inactive organization or branch.' using errcode = '42501'; end if;
  if p_title is null or btrim(p_title) = '' or p_target_count not between 1 and 100000 or p_end_at <= p_start_at then
    raise exception 'Invalid wird.' using errcode = '22023'; end if;
  if p_status not in ('draft','scheduled','active','ended','cancelled') then raise exception 'Invalid wird status.' using errcode = '22023'; end if;
  if not exists (select 1 from public.dhikr_definitions d where d.id = p_dhikr_id and d.organization_id = p_organization_id and d.status = 'approved') then
    raise exception 'An approved same-organization dhikr is required.' using errcode = '23514'; end if;
  if p_id is null then
    if p_status not in ('draft','scheduled') then
      raise exception 'New wird must begin as draft or scheduled.' using errcode = '23514'; end if;
    insert into public.wirds (organization_id, owner_branch_id, dhikr_id, title, description, target_count, start_at, end_at, status, created_by)
    values (p_organization_id, case when actor.role = 'organization_admin' then null else actor.branch_id end,
      p_dhikr_id, btrim(p_title), nullif(btrim(p_description), ''), p_target_count, p_start_at, p_end_at,
      p_status::public.wird_lifecycle_status, actor.id) returning * into result;
  else
    select * into current_row from public.wirds where id = p_id and organization_id = p_organization_id;
    if current_row.id is null or not app_private.actor_can_manage_stage4(current_row.organization_id, current_row.owner_branch_id) then
      raise exception 'Wird access denied.' using errcode = '42501'; end if;
    update public.wirds set dhikr_id = p_dhikr_id, title = btrim(p_title), description = nullif(btrim(p_description), ''),
      target_count = p_target_count, start_at = p_start_at, end_at = p_end_at,
      status = p_status::public.wird_lifecycle_status where id = p_id returning * into result;
  end if;
  return result;
end;
$$;

create function public.create_wird_assignment(
  p_wird_id uuid, p_scope_type text, p_branch_id uuid,
  p_class_id uuid, p_role text, p_user_id uuid
) returns table (assignment_id uuid, materialized_count bigint)
language plpgsql security definer set search_path = '' as $$
declare actor public.profiles%rowtype; selected_wird public.wirds%rowtype; created_id uuid; count_created bigint;
begin
  select * into actor from public.profiles where id = auth.uid() and status = 'active';
  select * into selected_wird from public.wirds where id = p_wird_id;
  if selected_wird.id is null or actor.id is null or actor.organization_id <> selected_wird.organization_id or actor.role not in ('organization_admin','branch_manager','admin') then
    raise exception 'Assignment access denied.' using errcode = '42501'; end if;
  if not app_private.actor_can_manage_stage4(selected_wird.organization_id, selected_wird.owner_branch_id) then
    raise exception 'Wird access denied.' using errcode = '42501'; end if;
  if selected_wird.status in ('ended', 'cancelled') then
    raise exception 'Assignments cannot be added to a closed wird.' using errcode = '23514'; end if;
  if p_scope_type not in ('organization','branch','class','role','user') then raise exception 'Invalid assignment scope.' using errcode = '22023'; end if;
  if actor.role <> 'organization_admin' and (
    p_scope_type = 'organization' or p_branch_id is distinct from actor.branch_id or
    (p_scope_type = 'role' and p_branch_id is null)
  ) then raise exception 'Branch actors may assign only inside their branch.' using errcode = '42501'; end if;
  if p_branch_id is not null and not exists (
    select 1 from public.branches b where b.id = p_branch_id and b.organization_id = selected_wird.organization_id and b.status = 'active'
  ) then raise exception 'Invalid branch target.' using errcode = '23514'; end if;
  if p_class_id is not null and not exists (
    select 1 from public.classes c where c.id = p_class_id and c.organization_id = selected_wird.organization_id and c.branch_id = p_branch_id and c.status = 'active'
  ) then raise exception 'Invalid class target.' using errcode = '23514'; end if;
  insert into public.wird_assignments (
    wird_id, organization_id, scope_type, branch_id, class_id, role, user_id, created_by
  ) values (
    selected_wird.id, selected_wird.organization_id, p_scope_type::public.wird_assignment_scope,
    p_branch_id, p_class_id, p_role, p_user_id, actor.id
  ) returning id into created_id;
  count_created := app_private.materialize_wird_assignment(created_id);
  return query select created_id, count_created;
end;
$$;

create function public.revoke_wird_assignment(p_assignment_id uuid)
returns void language plpgsql security definer set search_path = '' as $$
declare selected_assignment public.wird_assignments%rowtype; selected_wird public.wirds%rowtype;
begin
  select * into selected_assignment from public.wird_assignments where id = p_assignment_id;
  select * into selected_wird from public.wirds where id = selected_assignment.wird_id;
  if selected_assignment.id is null or not app_private.actor_can_manage_stage4(selected_assignment.organization_id, selected_wird.owner_branch_id) then
    raise exception 'Assignment access denied.' using errcode = '42501'; end if;
  update public.wird_assignments set status = 'revoked', revoked_at = now() where id = p_assignment_id and status = 'active';
end;
$$;

create function public.create_wird_with_assignments(
  p_organization_id uuid, p_dhikr_id uuid, p_title text, p_description text,
  p_target_count integer, p_start_on date, p_end_on date,
  p_assignments jsonb
) returns table (wird_id uuid, materialized_count bigint)
language plpgsql security definer set search_path = '' as $$
declare created_wird public.wirds%rowtype; item jsonb; total_count bigint := 0; result_count bigint;
  organization_timezone text; start_instant timestamptz; end_instant timestamptz;
begin
  if jsonb_typeof(p_assignments) <> 'array' or jsonb_array_length(p_assignments) = 0 or jsonb_array_length(p_assignments) > 100 then
    raise exception 'One to one hundred assignment scopes are required.' using errcode = '22023';
  end if;
  if p_start_on is null or p_end_on is null or p_end_on < p_start_on then
    raise exception 'Invalid organization-local date window.' using errcode = '22023';
  end if;
  select o.timezone into organization_timezone from public.organizations o where o.id = p_organization_id;
  if organization_timezone is null then raise exception 'Invalid organization.' using errcode = '23503'; end if;
  start_instant := p_start_on::timestamp at time zone organization_timezone;
  end_instant := (p_end_on + 1)::timestamp at time zone organization_timezone;
  created_wird := public.save_wird(null, p_organization_id, p_dhikr_id, p_title,
    p_description, p_target_count, start_instant, end_instant, 'scheduled');
  for item in select value from jsonb_array_elements(p_assignments) loop
    select c.materialized_count into result_count from public.create_wird_assignment(
      created_wird.id, item->>'scope_type', nullif(item->>'branch_id','')::uuid,
      nullif(item->>'class_id','')::uuid, nullif(item->>'role',''),
      nullif(item->>'user_id','')::uuid
    ) c;
    total_count := total_count + coalesce(result_count, 0);
  end loop;
  return query select created_wird.id, total_count;
end;
$$;

create function public.materialize_wird_assignment(p_assignment_id uuid)
returns bigint language plpgsql security definer set search_path = '' as $$
declare a public.wird_assignments%rowtype; w public.wirds%rowtype;
begin
  select * into a from public.wird_assignments where id = p_assignment_id;
  select * into w from public.wirds where id = a.wird_id;
  if a.id is null or not app_private.actor_can_manage_stage4(a.organization_id, w.owner_branch_id) then
    raise exception 'Assignment access denied.' using errcode = '42501'; end if;
  return app_private.materialize_wird_assignment(p_assignment_id);
end;
$$;

create function public.list_todays_wirds()
returns table (
  id uuid, wird_id uuid, title text, dhikr_title text, dhikr_text text,
  target_count integer, start_at timestamptz, end_at timestamptz,
  timezone_name text, assignment_scope text
) language sql stable security definer set search_path = '' as $$
  select i.id, i.wird_id, i.wird_title_snapshot, i.dhikr_title_snapshot,
    i.dhikr_text_snapshot, i.target_count, i.start_at, i.end_at,
    i.timezone_name, i.assignment_scope_type::text
  from public.user_wird_instances i
  join public.profiles p on p.id = i.user_id and p.organization_id = i.organization_id
  join public.organizations o on o.id = i.organization_id
  left join public.branches b on b.id = p.branch_id and b.organization_id = p.organization_id
  left join public.students s on s.profile_id = p.id
  left join public.classes c on c.id = s.class_id and c.branch_id = p.branch_id and c.organization_id = p.organization_id
  join public.wirds w on w.id = i.wird_id and w.organization_id = i.organization_id
  where i.user_id = auth.uid() and p.status = 'active' and o.status = 'active'
    and (p.branch_id is null or b.status = 'active')
    and (p.role <> 'student' or (s.status = 'active' and c.status = 'active'))
    and i.status = 'assigned' and w.status = 'active'
    and now() >= i.start_at and now() < i.end_at
  order by i.start_at, i.id;
$$;

alter table public.dhikr_definitions enable row level security;
alter table public.wirds enable row level security;
alter table public.wird_assignments enable row level security;
alter table public.user_wird_instances enable row level security;

create policy dhikr_select_managers on public.dhikr_definitions for select to authenticated using (
  app_private.actor_can_manage_stage4(organization_id, owner_branch_id) or
  (status = 'approved' and app_private.actor_is_stage4_manager(organization_id))
);
create policy wirds_select_managers on public.wirds for select to authenticated using (
  app_private.actor_can_manage_stage4(organization_id, owner_branch_id)
);
create policy assignments_select_managers on public.wird_assignments for select to authenticated using (
  exists (select 1 from public.wirds w where w.id = wird_id and app_private.actor_can_manage_stage4(organization_id, w.owner_branch_id))
);
create policy instances_select_authorized on public.user_wird_instances for select to authenticated using (
  app_private.actor_can_read_stage4_instance(
    organization_id, branch_id, class_id, user_id, wird_id,
    status, start_at, end_at
  )
);

revoke all on public.dhikr_definitions, public.wirds, public.wird_assignments, public.user_wird_instances from anon, authenticated;
grant select on public.dhikr_definitions, public.wirds, public.wird_assignments, public.user_wird_instances to authenticated;

revoke all on function public.save_dhikr_definition(uuid,uuid,text,text,text,integer,text,text) from public;
revoke all on function public.save_wird(uuid,uuid,uuid,text,text,integer,timestamptz,timestamptz,text) from public;
revoke all on function public.create_wird_assignment(uuid,text,uuid,uuid,text,uuid) from public;
revoke all on function public.revoke_wird_assignment(uuid) from public;
revoke all on function public.create_wird_with_assignments(uuid,uuid,text,text,integer,date,date,jsonb) from public;
revoke all on function public.materialize_wird_assignment(uuid) from public;
revoke all on function public.list_todays_wirds() from public;
grant execute on function public.save_dhikr_definition(uuid,uuid,text,text,text,integer,text,text) to authenticated;
grant execute on function public.save_wird(uuid,uuid,uuid,text,text,integer,timestamptz,timestamptz,text) to authenticated;
grant execute on function public.create_wird_assignment(uuid,text,uuid,uuid,text,uuid) to authenticated;
grant execute on function public.revoke_wird_assignment(uuid) to authenticated;
grant execute on function public.create_wird_with_assignments(uuid,uuid,text,text,integer,date,date,jsonb) to authenticated;
grant execute on function public.materialize_wird_assignment(uuid) to authenticated;
grant execute on function public.list_todays_wirds() to authenticated;

revoke all on all functions in schema app_private from public;
grant usage on schema app_private to authenticated;
grant execute on function app_private.actor_can_manage_stage4(uuid,uuid) to authenticated;
grant execute on function app_private.actor_can_read_stage4_instance(
  uuid,uuid,uuid,uuid,uuid,public.user_wird_instance_status,timestamptz,timestamptz
) to authenticated;
grant execute on function app_private.actor_is_stage4_manager(uuid) to authenticated;
