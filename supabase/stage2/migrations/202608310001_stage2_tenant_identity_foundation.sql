create extension if not exists pgcrypto;

create schema if not exists app_private;
revoke all on schema app_private from public;

create table public.organizations (
  id uuid primary key default gen_random_uuid(),
  code text not null,
  normalized_code text generated always as (lower(btrim(code))) stored,
  name text not null,
  timezone text not null default 'Asia/Riyadh',
  status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint organizations_code_not_blank check (btrim(code) <> ''),
  constraint organizations_name_not_blank check (btrim(name) <> ''),
  constraint organizations_status_valid check (status in ('active', 'suspended', 'archived')),
  constraint organizations_normalized_code_unique unique (normalized_code)
);

create table public.branches (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations(id) on delete restrict,
  code text not null,
  normalized_code text generated always as (lower(btrim(code))) stored,
  name text not null,
  governorate text,
  city text,
  status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint branches_code_not_blank check (btrim(code) <> ''),
  constraint branches_name_not_blank check (btrim(name) <> ''),
  constraint branches_status_valid check (status in ('active', 'suspended', 'archived')),
  constraint branches_organization_code_unique unique (organization_id, normalized_code),
  constraint branches_organization_id_unique unique (organization_id, id)
);

create table public.classes (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null,
  branch_id uuid not null,
  code text not null,
  normalized_code text generated always as (lower(btrim(code))) stored,
  name text not null,
  academic_year text not null,
  status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint classes_branch_tenant_fk foreign key (organization_id, branch_id)
    references public.branches(organization_id, id) on delete restrict,
  constraint classes_code_not_blank check (btrim(code) <> ''),
  constraint classes_name_not_blank check (btrim(name) <> ''),
  constraint classes_academic_year_not_blank check (btrim(academic_year) <> ''),
  constraint classes_status_valid check (status in ('active', 'suspended', 'archived')),
  constraint classes_branch_code_year_unique unique (branch_id, normalized_code, academic_year),
  constraint classes_tenant_id_unique unique (organization_id, branch_id, id)
);

create table public.profiles (
  id uuid primary key references auth.users(id) on delete restrict,
  organization_id uuid not null references public.organizations(id) on delete restrict,
  branch_id uuid,
  display_name text not null,
  role text not null,
  status text not null default 'invited',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint profiles_branch_tenant_fk foreign key (organization_id, branch_id)
    references public.branches(organization_id, id) on delete restrict,
  constraint profiles_display_name_not_blank check (btrim(display_name) <> ''),
  constraint profiles_role_valid check (role in (
    'organization_admin', 'branch_manager', 'admin', 'teacher', 'staff', 'student'
  )),
  constraint profiles_status_valid check (status in ('invited', 'active', 'suspended', 'archived')),
  constraint profiles_role_branch_scope check (
    (role = 'organization_admin' and branch_id is null)
    or (role <> 'organization_admin' and branch_id is not null)
  ),
  constraint profiles_organization_id_unique unique (organization_id, id),
  constraint profiles_tenant_branch_id_unique unique (organization_id, branch_id, id)
);

create table public.students (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null unique,
  organization_id uuid not null,
  branch_id uuid not null,
  class_id uuid not null,
  student_code text not null,
  normalized_student_code text generated always as (lower(btrim(student_code))) stored,
  status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint students_profile_tenant_fk foreign key (organization_id, branch_id, profile_id)
    references public.profiles(organization_id, branch_id, id) on delete restrict,
  constraint students_class_tenant_fk foreign key (organization_id, branch_id, class_id)
    references public.classes(organization_id, branch_id, id) on delete restrict,
  constraint students_code_not_blank check (btrim(student_code) <> ''),
  constraint students_status_valid check (status in ('active', 'suspended', 'archived')),
  constraint students_organization_code_unique unique (organization_id, normalized_student_code)
);

create table public.teacher_classes (
  organization_id uuid not null,
  branch_id uuid not null,
  teacher_id uuid not null,
  class_id uuid not null,
  created_at timestamptz not null default now(),
  primary key (teacher_id, class_id),
  constraint teacher_classes_teacher_tenant_fk foreign key (organization_id, branch_id, teacher_id)
    references public.profiles(organization_id, branch_id, id) on delete restrict,
  constraint teacher_classes_class_tenant_fk foreign key (organization_id, branch_id, class_id)
    references public.classes(organization_id, branch_id, id) on delete restrict
);

create index branches_organization_idx on public.branches(organization_id);
create index classes_tenant_branch_idx on public.classes(organization_id, branch_id);
create index profiles_tenant_branch_role_idx on public.profiles(organization_id, branch_id, role);
create index students_tenant_branch_class_idx on public.students(organization_id, branch_id, class_id);
create index teacher_classes_class_idx on public.teacher_classes(organization_id, branch_id, class_id);

create function app_private.set_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create function app_private.validate_timezone()
returns trigger language plpgsql set search_path = '' as $$
begin
  if not exists (select 1 from pg_catalog.pg_timezone_names where name = new.timezone) then
    raise exception 'invalid IANA timezone: %', new.timezone using errcode = '23514';
  end if;
  return new;
end;
$$;

create function app_private.validate_student_profile_role()
returns trigger language plpgsql set search_path = '' as $$
begin
  if not exists (
    select 1 from public.profiles p
    where p.id = new.profile_id and p.role = 'student'
      and p.organization_id = new.organization_id and p.branch_id = new.branch_id
  ) then
    raise exception 'student profile must have role=student in the same tenant and branch' using errcode = '23514';
  end if;
  return new;
end;
$$;

create function app_private.validate_teacher_profile_role()
returns trigger language plpgsql set search_path = '' as $$
begin
  if not exists (
    select 1 from public.profiles p
    where p.id = new.teacher_id and p.role = 'teacher'
      and p.organization_id = new.organization_id and p.branch_id = new.branch_id
  ) then
    raise exception 'teacher assignment requires role=teacher in the same tenant and branch' using errcode = '23514';
  end if;
  return new;
end;
$$;

create function app_private.prevent_orphaned_role_membership()
returns trigger language plpgsql set search_path = '' as $$
begin
  if old.role = 'student' and new.role <> 'student'
     and exists (select 1 from public.students s where s.profile_id = old.id) then
    raise exception 'remove the student extension before changing the student role' using errcode = '23514';
  end if;
  if old.role = 'teacher' and new.role <> 'teacher'
     and exists (select 1 from public.teacher_classes tc where tc.teacher_id = old.id) then
    raise exception 'remove teacher class assignments before changing the teacher role' using errcode = '23514';
  end if;
  return new;
end;
$$;

create function app_private.ensure_student_profile_extension()
returns trigger language plpgsql set search_path = '' as $$
begin
  if new.role = 'student'
     and not exists (select 1 from public.students s where s.profile_id = new.id) then
    raise exception 'student profile requires exactly one student extension' using errcode = '23514';
  end if;
  return null;
end;
$$;

create function app_private.prevent_orphaned_student_profile()
returns trigger language plpgsql set search_path = '' as $$
begin
  if exists (select 1 from public.profiles p where p.id = old.profile_id and p.role = 'student')
     and not exists (select 1 from public.students s where s.profile_id = old.profile_id) then
    raise exception 'student extension removal would orphan a student profile' using errcode = '23514';
  end if;
  return null;
end;
$$;

create trigger organizations_validate_timezone before insert or update of timezone on public.organizations
for each row execute function app_private.validate_timezone();
create trigger organizations_set_updated_at before update on public.organizations
for each row execute function app_private.set_updated_at();
create trigger branches_set_updated_at before update on public.branches
for each row execute function app_private.set_updated_at();
create trigger classes_set_updated_at before update on public.classes
for each row execute function app_private.set_updated_at();
create trigger profiles_set_updated_at before update on public.profiles
for each row execute function app_private.set_updated_at();
create trigger profiles_prevent_orphaned_role before update of role on public.profiles
for each row execute function app_private.prevent_orphaned_role_membership();
create trigger students_set_updated_at before update on public.students
for each row execute function app_private.set_updated_at();
create trigger students_validate_profile before insert or update of profile_id, organization_id, branch_id on public.students
for each row execute function app_private.validate_student_profile_role();
create trigger teacher_classes_validate_teacher before insert or update of teacher_id, organization_id, branch_id on public.teacher_classes
for each row execute function app_private.validate_teacher_profile_role();
create constraint trigger profiles_require_student_extension
after insert or update on public.profiles deferrable initially deferred
for each row execute function app_private.ensure_student_profile_extension();
create constraint trigger students_prevent_orphaned_profile
after delete or update on public.students deferrable initially deferred
for each row execute function app_private.prevent_orphaned_student_profile();

create function app_private.actor_can_access_organization(target_organization_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.status = 'active'
      and p.organization_id = target_organization_id
  );
$$;

create function app_private.actor_can_manage_organization(target_organization_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.status = 'active'
      and p.role = 'organization_admin' and p.organization_id = target_organization_id
  );
$$;

create function app_private.actor_can_access_branch(target_organization_id uuid, target_branch_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.status = 'active'
      and p.organization_id = target_organization_id
      and (p.role = 'organization_admin' or p.branch_id = target_branch_id)
  );
$$;

create function app_private.actor_can_manage_branch(target_organization_id uuid, target_branch_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.status = 'active'
      and p.organization_id = target_organization_id
      and (
        p.role = 'organization_admin'
        or (p.role in ('branch_manager', 'admin') and p.branch_id = target_branch_id)
      )
  );
$$;

create function app_private.actor_can_access_class(target_organization_id uuid, target_branch_id uuid, target_class_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.status = 'active'
      and p.organization_id = target_organization_id
      and (
        p.role = 'organization_admin'
        or (p.role in ('branch_manager', 'admin', 'staff') and p.branch_id = target_branch_id)
        or (p.role = 'teacher' and exists (
          select 1 from public.teacher_classes tc
          where tc.teacher_id = p.id and tc.class_id = target_class_id
            and tc.organization_id = target_organization_id and tc.branch_id = target_branch_id
        ))
        or (p.role = 'student' and exists (
          select 1 from public.students s
          where s.profile_id = p.id and s.class_id = target_class_id
            and s.organization_id = target_organization_id and s.branch_id = target_branch_id
        ))
      )
  );
$$;

create function app_private.actor_can_read_profile(target_profile_id uuid, target_organization_id uuid, target_branch_id uuid, target_role text)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles actor
    where actor.id = auth.uid() and actor.status = 'active'
      and (
        actor.id = target_profile_id
        or (actor.organization_id = target_organization_id and actor.role = 'organization_admin')
        or (actor.organization_id = target_organization_id and actor.branch_id = target_branch_id
            and actor.role in ('branch_manager', 'admin'))
        or (actor.role = 'teacher' and target_role = 'student' and exists (
          select 1 from public.students s
          join public.teacher_classes tc on tc.class_id = s.class_id and tc.teacher_id = actor.id
          where s.profile_id = target_profile_id
        ))
      )
  );
$$;

create function app_private.actor_can_read_student(target_profile_id uuid, target_organization_id uuid, target_branch_id uuid, target_class_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles actor
    where actor.id = auth.uid() and actor.status = 'active'
      and (
        actor.id = target_profile_id
        or (actor.organization_id = target_organization_id and actor.role = 'organization_admin')
        or (actor.organization_id = target_organization_id and actor.branch_id = target_branch_id
            and actor.role in ('branch_manager', 'admin'))
        or (actor.role = 'teacher' and exists (
          select 1 from public.teacher_classes tc
          where tc.teacher_id = actor.id and tc.class_id = target_class_id
            and tc.organization_id = target_organization_id and tc.branch_id = target_branch_id
        ))
      )
  );
$$;

revoke all on all functions in schema app_private from public;
grant usage on schema app_private to authenticated;
grant execute on function app_private.actor_can_access_organization(uuid) to authenticated;
grant execute on function app_private.actor_can_manage_organization(uuid) to authenticated;
grant execute on function app_private.actor_can_access_branch(uuid, uuid) to authenticated;
grant execute on function app_private.actor_can_manage_branch(uuid, uuid) to authenticated;
grant execute on function app_private.actor_can_access_class(uuid, uuid, uuid) to authenticated;
grant execute on function app_private.actor_can_read_profile(uuid, uuid, uuid, text) to authenticated;
grant execute on function app_private.actor_can_read_student(uuid, uuid, uuid, uuid) to authenticated;

alter table public.organizations enable row level security;
alter table public.branches enable row level security;
alter table public.classes enable row level security;
alter table public.profiles enable row level security;
alter table public.students enable row level security;
alter table public.teacher_classes enable row level security;

create policy organizations_select on public.organizations for select to authenticated
using (app_private.actor_can_access_organization(id));
create policy organizations_update on public.organizations for update to authenticated
using (app_private.actor_can_manage_organization(id))
with check (app_private.actor_can_manage_organization(id));

create policy branches_select on public.branches for select to authenticated
using (app_private.actor_can_access_branch(organization_id, id));
create policy branches_insert on public.branches for insert to authenticated
with check (app_private.actor_can_manage_organization(organization_id));
create policy branches_update on public.branches for update to authenticated
using (app_private.actor_can_manage_branch(organization_id, id))
with check (app_private.actor_can_manage_branch(organization_id, id));

create policy classes_select on public.classes for select to authenticated
using (app_private.actor_can_access_class(organization_id, branch_id, id));
create policy classes_insert on public.classes for insert to authenticated
with check (app_private.actor_can_manage_branch(organization_id, branch_id));
create policy classes_update on public.classes for update to authenticated
using (app_private.actor_can_manage_branch(organization_id, branch_id))
with check (app_private.actor_can_manage_branch(organization_id, branch_id));

create policy profiles_select on public.profiles for select to authenticated
using (app_private.actor_can_read_profile(id, organization_id, branch_id, role));

create policy students_select on public.students for select to authenticated
using (app_private.actor_can_read_student(profile_id, organization_id, branch_id, class_id));
create policy students_insert on public.students for insert to authenticated
with check (app_private.actor_can_manage_branch(organization_id, branch_id));
create policy students_update on public.students for update to authenticated
using (app_private.actor_can_manage_branch(organization_id, branch_id))
with check (app_private.actor_can_manage_branch(organization_id, branch_id));

create policy teacher_classes_select on public.teacher_classes for select to authenticated
using (
  (teacher_id = auth.uid() and app_private.actor_can_access_branch(organization_id, branch_id))
  or app_private.actor_can_manage_branch(organization_id, branch_id)
);
create policy teacher_classes_insert on public.teacher_classes for insert to authenticated
with check (app_private.actor_can_manage_branch(organization_id, branch_id));
create policy teacher_classes_delete on public.teacher_classes for delete to authenticated
using (app_private.actor_can_manage_branch(organization_id, branch_id));

grant select, insert, update, delete on public.organizations to authenticated;
grant select, insert, update, delete on public.branches to authenticated;
grant select, insert, update, delete on public.classes to authenticated;
grant select, insert, update, delete on public.profiles to authenticated;
grant select, insert, update, delete on public.students to authenticated;
grant select, insert, update, delete on public.teacher_classes to authenticated;
