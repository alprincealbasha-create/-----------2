-- Stage 3 is additive. It must never be applied as a destructive reset.

-- Membership moves update the profile and student extension atomically. These
-- existing tenant FKs keep the same meaning but are checked at transaction end.
alter table public.students drop constraint students_profile_tenant_fk;
alter table public.students add constraint students_profile_tenant_fk
  foreign key (organization_id, branch_id, profile_id)
  references public.profiles(organization_id, branch_id, id)
  on delete restrict deferrable initially immediate;
alter table public.students drop constraint students_class_tenant_fk;
alter table public.students add constraint students_class_tenant_fk
  foreign key (organization_id, branch_id, class_id)
  references public.classes(organization_id, branch_id, id)
  on delete restrict deferrable initially immediate;

create table public.student_auth_credentials (
  profile_id uuid primary key references public.profiles(id) on delete restrict,
  organization_id uuid not null references public.organizations(id) on delete restrict,
  auth_email text not null unique,
  failed_attempts integer not null default 0 check (failed_attempts between 0 and 5),
  locked_until timestamptz,
  pin_changed_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint student_auth_credentials_tenant_profile_fk
    foreign key (organization_id, profile_id)
    references public.profiles(organization_id, id) on delete restrict
);

comment on table public.student_auth_credentials is
  'Server-only student sign-in metadata. PIN verification remains in Supabase Auth.';

create table public.auth_security_events (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid references public.organizations(id) on delete restrict,
  actor_id uuid references public.profiles(id) on delete set null,
  subject_id uuid references public.profiles(id) on delete set null,
  event_type text not null check (event_type in (
    'student_login_failed', 'student_login_succeeded', 'student_login_locked',
    'member_provisioned', 'membership_changed', 'student_pin_reset',
    'sessions_revoked', 'session_revocation_failed'
  )),
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  constraint auth_security_events_metadata_object
    check (jsonb_typeof(metadata) = 'object')
);

create index auth_security_events_tenant_time_idx
  on public.auth_security_events(organization_id, created_at desc);

alter table public.student_auth_credentials enable row level security;
alter table public.auth_security_events enable row level security;
revoke all on public.student_auth_credentials from anon, authenticated;
revoke all on public.auth_security_events from anon, authenticated;

create function public.resolve_my_authorization_context()
returns table (
  id uuid,
  organization_id uuid,
  branch_id uuid,
  class_id uuid,
  role text,
  status text
)
language sql stable security definer set search_path = '' as $$
  select p.id, p.organization_id, p.branch_id, s.class_id, p.role, p.status
  from public.profiles p
  left join public.students s on s.profile_id = p.id
  where p.id = auth.uid();
$$;

revoke all on function public.resolve_my_authorization_context() from public;
grant execute on function public.resolve_my_authorization_context() to authenticated;

create function public.authorize_membership_administration(
  target_organization_id uuid,
  target_branch_id uuid,
  target_role text
)
returns boolean
language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles actor
    where actor.id = auth.uid()
      and actor.status = 'active'
      and actor.organization_id = target_organization_id
      and (
        actor.role = 'organization_admin'
        or (
          actor.role = 'branch_manager'
          and actor.branch_id = target_branch_id
          and target_role in ('admin', 'teacher', 'staff', 'student')
        )
        or (
          actor.role = 'admin'
          and actor.branch_id = target_branch_id
          and target_role in ('teacher', 'staff', 'student')
        )
      )
  );
$$;

revoke all on function public.authorize_membership_administration(uuid, uuid, text) from public;
grant execute on function public.authorize_membership_administration(uuid, uuid, text) to authenticated;

create function public.begin_student_login(
  requested_organization_code text,
  requested_student_code text
)
returns table (profile_id uuid, organization_id uuid, auth_email text)
language plpgsql security definer set search_path = '' as $$
declare
  credential public.student_auth_credentials%rowtype;
begin
  select c.* into credential
  from public.student_auth_credentials c
  join public.organizations o on o.id = c.organization_id
  join public.profiles p on p.id = c.profile_id
  join public.students s on s.profile_id = p.id
  join public.branches b on b.id = p.branch_id
  join public.classes cl on cl.id = s.class_id
  where o.normalized_code = lower(btrim(requested_organization_code))
    and s.normalized_student_code = lower(btrim(requested_student_code))
    and p.role = 'student'
    and p.status = 'active' and s.status = 'active'
    and o.status = 'active' and b.status = 'active' and cl.status = 'active'
  for update of c;

  if not found or (credential.locked_until is not null and credential.locked_until > now()) then
    return;
  end if;

  update public.student_auth_credentials c
  set failed_attempts = least(c.failed_attempts + 1, 5),
      locked_until = case when c.failed_attempts + 1 >= 5
        then now() + interval '15 minutes' else null end,
      updated_at = now()
  where c.profile_id = credential.profile_id;

  profile_id := credential.profile_id;
  organization_id := credential.organization_id;
  auth_email := credential.auth_email;
  return next;
end;
$$;

create function public.complete_student_login(login_profile_id uuid)
returns void
language plpgsql security definer set search_path = '' as $$
declare
  tenant_id uuid;
begin
  update public.student_auth_credentials
  set failed_attempts = 0, locked_until = null, updated_at = now()
  where profile_id = login_profile_id
  returning organization_id into tenant_id;
  if tenant_id is not null then
    insert into public.auth_security_events(organization_id, subject_id, event_type)
    values (tenant_id, login_profile_id, 'student_login_succeeded');
  end if;
end;
$$;

create function public.record_auth_security_event(
  event_organization_id uuid,
  event_actor_id uuid,
  event_subject_id uuid,
  requested_event_type text,
  safe_metadata jsonb default '{}'::jsonb
)
returns void
language plpgsql security definer set search_path = '' as $$
begin
  if requested_event_type not in (
    'student_login_failed', 'student_login_locked', 'member_provisioned',
    'membership_changed', 'student_pin_reset', 'sessions_revoked',
    'session_revocation_failed'
  ) then
    raise exception 'unsupported security event';
  end if;
  insert into public.auth_security_events(
    organization_id, actor_id, subject_id, event_type, metadata
  ) values (
    event_organization_id, event_actor_id, event_subject_id,
    requested_event_type, coalesce(safe_metadata, '{}'::jsonb)
  );
end;
$$;

revoke all on function public.begin_student_login(text, text) from public;
revoke all on function public.complete_student_login(uuid) from public;
revoke all on function public.record_auth_security_event(uuid, uuid, uuid, text, jsonb) from public;
grant execute on function public.begin_student_login(text, text) to service_role;
grant execute on function public.complete_student_login(uuid) to service_role;
grant execute on function public.record_auth_security_event(uuid, uuid, uuid, text, jsonb) to service_role;
grant select, insert, update on public.student_auth_credentials to service_role;
grant select, insert on public.auth_security_events to service_role;

create function public.provision_membership_record(
  auth_user_id uuid,
  target_organization_id uuid,
  target_branch_id uuid,
  target_class_id uuid,
  target_display_name text,
  target_role text,
  target_student_code text default null,
  internal_auth_email text default null,
  provisioning_actor_id uuid default null
)
returns void
language plpgsql security definer set search_path = '' as $$
begin
  if target_role not in (
    'organization_admin', 'branch_manager', 'admin', 'teacher', 'staff', 'student'
  ) then
    raise exception 'invalid role';
  end if;
  if target_role = 'student' and (
    target_class_id is null or nullif(btrim(target_student_code), '') is null
    or nullif(btrim(internal_auth_email), '') is null
  ) then
    raise exception 'student provisioning data is incomplete';
  end if;
  if target_role <> 'student' and target_class_id is not null then
    raise exception 'class belongs only to a student extension';
  end if;

  set constraints all deferred;
  insert into public.profiles(
    id, organization_id, branch_id, display_name, role, status
  ) values (
    auth_user_id, target_organization_id, target_branch_id,
    target_display_name, target_role, 'active'
  );

  if target_role = 'student' then
    insert into public.students(
      profile_id, organization_id, branch_id, class_id, student_code, status
    ) values (
      auth_user_id, target_organization_id, target_branch_id,
      target_class_id, target_student_code, 'active'
    );
    insert into public.student_auth_credentials(
      profile_id, organization_id, auth_email
    ) values (auth_user_id, target_organization_id, internal_auth_email);
  end if;

  insert into public.auth_security_events(
    organization_id, actor_id, subject_id, event_type
  ) values (
    target_organization_id, provisioning_actor_id, auth_user_id,
    'member_provisioned'
  );
end;
$$;

revoke all on function public.provision_membership_record(
  uuid, uuid, uuid, uuid, text, text, text, text, uuid
) from public;
grant execute on function public.provision_membership_record(
  uuid, uuid, uuid, uuid, text, text, text, text, uuid
) to service_role;

create function public.authorize_existing_membership_administration(
  target_profile_id uuid,
  desired_branch_id uuid,
  desired_role text
)
returns boolean
language sql stable security definer set search_path = '' as $$
  select exists (
    select 1
    from public.profiles actor
    join public.profiles target on target.id = target_profile_id
    where actor.id = auth.uid() and actor.status = 'active'
      and actor.organization_id = target.organization_id
      and actor.id <> target.id
      and (
        actor.role = 'organization_admin'
        or (
          actor.role = 'branch_manager'
          and actor.branch_id = target.branch_id
          and desired_branch_id = actor.branch_id
          and target.role in ('admin', 'teacher', 'staff', 'student')
          and desired_role in ('admin', 'teacher', 'staff', 'student')
        )
        or (
          actor.role = 'admin'
          and actor.branch_id = target.branch_id
          and desired_branch_id = actor.branch_id
          and target.role in ('teacher', 'staff', 'student')
          and desired_role in ('teacher', 'staff', 'student')
        )
      )
  );
$$;

revoke all on function public.authorize_existing_membership_administration(uuid, uuid, text) from public;
grant execute on function public.authorize_existing_membership_administration(uuid, uuid, text) to authenticated;

create function public.change_membership_record(
  target_profile_id uuid,
  desired_branch_id uuid,
  desired_class_id uuid,
  desired_role text,
  desired_status text,
  change_actor_id uuid
)
returns void
language plpgsql security definer set search_path = '' as $$
declare
  current_profile public.profiles%rowtype;
  tenant_id uuid;
begin
  select * into current_profile from public.profiles
  where id = target_profile_id for update;
  if not found then raise exception 'profile not found'; end if;
  tenant_id := current_profile.organization_id;
  set constraints all deferred;

  if desired_role not in (
    'organization_admin', 'branch_manager', 'admin', 'teacher', 'staff', 'student'
  ) or desired_status not in ('active', 'suspended', 'archived') then
    raise exception 'invalid membership state';
  end if;
  if (current_profile.role = 'student') <> (desired_role = 'student') then
    raise exception 'adult/student identity category changes require reprovisioning';
  end if;
  if current_profile.role = 'organization_admin'
     and (desired_role <> 'organization_admin' or desired_status <> 'active')
     and not exists (
       select 1 from public.profiles p
       where p.organization_id = current_profile.organization_id
         and p.role = 'organization_admin' and p.status = 'active'
         and p.id <> target_profile_id
     ) then
    raise exception 'cannot remove the last active organization administrator';
  end if;
  if current_profile.role = 'teacher' and (
    desired_role <> 'teacher' or desired_branch_id is distinct from current_profile.branch_id
  ) and exists (
    select 1 from public.teacher_classes tc where tc.teacher_id = target_profile_id
  ) then
    raise exception 'remove teacher class grants before changing role or branch';
  end if;

  if desired_role = 'organization_admin' then
    desired_branch_id := null;
  elsif desired_branch_id is null then
    raise exception 'branch-scoped role requires branch';
  end if;

  update public.profiles
  set branch_id = desired_branch_id, role = desired_role, status = desired_status
  where id = target_profile_id;

  if desired_role = 'student' then
    if desired_class_id is null then raise exception 'student class is required'; end if;
    update public.students
    set branch_id = desired_branch_id, class_id = desired_class_id,
        status = case desired_status
          when 'active' then 'active'
          when 'archived' then 'archived'
          else 'suspended'
        end
    where profile_id = target_profile_id;
  elsif desired_class_id is not null then
    raise exception 'class is valid only for students';
  end if;

  insert into public.auth_security_events(
    organization_id, actor_id, subject_id, event_type,
    metadata
  ) values (
    tenant_id, change_actor_id, target_profile_id, 'membership_changed',
    jsonb_build_object('role', desired_role, 'status', desired_status)
  );
end;
$$;

revoke all on function public.change_membership_record(uuid, uuid, uuid, text, text, uuid) from public;
grant execute on function public.change_membership_record(uuid, uuid, uuid, text, text, uuid) to service_role;

create function public.complete_student_pin_reset(
  target_profile_id uuid,
  reset_actor_id uuid
)
returns void
language plpgsql security definer set search_path = '' as $$
declare
  tenant_id uuid;
begin
  update public.student_auth_credentials
  set failed_attempts = 0, locked_until = null,
      pin_changed_at = now(), updated_at = now()
  where profile_id = target_profile_id
  returning organization_id into tenant_id;
  if tenant_id is null then raise exception 'student credential not found'; end if;
  insert into public.auth_security_events(
    organization_id, actor_id, subject_id, event_type
  ) values (tenant_id, reset_actor_id, target_profile_id, 'student_pin_reset');
end;
$$;

revoke all on function public.complete_student_pin_reset(uuid, uuid) from public;
grant execute on function public.complete_student_pin_reset(uuid, uuid) to service_role;
