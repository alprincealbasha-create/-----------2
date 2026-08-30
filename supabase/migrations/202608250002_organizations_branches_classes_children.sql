create type public.organization_role as enum ('owner', 'admin');

create table public.organizations (
  id uuid primary key default gen_random_uuid(),
  name varchar(160) not null check (length(btrim(name)) between 1 and 160),
  created_by uuid not null default auth.uid() references public.profiles (id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.organization_members (
  organization_id uuid not null references public.organizations (id) on delete cascade,
  user_id uuid not null references public.profiles (id) on delete cascade,
  role public.organization_role not null,
  created_at timestamptz not null default now(),
  primary key (organization_id, user_id)
);

create table public.branches (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations (id),
  name varchar(160) not null check (length(btrim(name)) between 1 and 160),
  city varchar(120),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.classes (
  id uuid primary key default gen_random_uuid(),
  branch_id uuid not null references public.branches (id),
  name varchar(160) not null check (length(btrim(name)) between 1 and 160),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.children (
  id uuid primary key default gen_random_uuid(),
  class_id uuid not null references public.classes (id),
  full_name varchar(200) not null check (
    length(btrim(full_name)) between 1 and 200
  ),
  birth_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create index organizations_active_name_idx
on public.organizations (name)
where deleted_at is null;

create unique index branches_active_name_key
on public.branches (organization_id, lower(name))
where deleted_at is null;

create unique index classes_active_name_key
on public.classes (branch_id, lower(name))
where deleted_at is null;

create index organization_members_user_idx
on public.organization_members (user_id, organization_id);

create index branches_organization_idx
on public.branches (organization_id, name)
where deleted_at is null;

create index classes_branch_idx
on public.classes (branch_id, name)
where deleted_at is null;

create index children_class_idx
on public.children (class_id, full_name)
where deleted_at is null;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger organizations_set_updated_at
before update on public.organizations
for each row execute procedure public.set_updated_at();

create trigger branches_set_updated_at
before update on public.branches
for each row execute procedure public.set_updated_at();

create trigger classes_set_updated_at
before update on public.classes
for each row execute procedure public.set_updated_at();

create trigger children_set_updated_at
before update on public.children
for each row execute procedure public.set_updated_at();

create or replace function public.add_organization_owner()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.organization_members (organization_id, user_id, role)
  values (new.id, new.created_by, 'owner');
  return new;
end;
$$;

revoke all on function public.add_organization_owner() from public;

create trigger on_organization_created
after insert on public.organizations
for each row execute procedure public.add_organization_owner();

create or replace function public.can_manage_organization(target_id uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select public.is_admin() and exists (
    select 1
    from public.organization_members
    where organization_id = target_id
      and user_id = (select auth.uid())
      and role in ('owner', 'admin')
  );
$$;

create or replace function public.can_manage_branch(target_id uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.branches
    where id = target_id
      and public.can_manage_organization(organization_id)
  );
$$;

create or replace function public.can_manage_class(target_id uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.classes
    where id = target_id
      and public.can_manage_branch(branch_id)
  );
$$;

revoke all on function public.can_manage_organization(uuid) from public;
revoke all on function public.can_manage_branch(uuid) from public;
revoke all on function public.can_manage_class(uuid) from public;
grant execute on function public.can_manage_organization(uuid) to authenticated;
grant execute on function public.can_manage_branch(uuid) to authenticated;
grant execute on function public.can_manage_class(uuid) to authenticated;

alter table public.organizations enable row level security;
alter table public.organization_members enable row level security;
alter table public.branches enable row level security;
alter table public.classes enable row level security;
alter table public.children enable row level security;

create policy "Admins can create organizations"
on public.organizations
for insert
to authenticated
with check (
  public.is_admin()
  and created_by = (select auth.uid())
  and deleted_at is null
);

create policy "Organization managers can read organizations"
on public.organizations
for select
to authenticated
using (public.can_manage_organization(id));

create policy "Organization managers can update organizations"
on public.organizations
for update
to authenticated
using (public.can_manage_organization(id))
with check (public.can_manage_organization(id));

create policy "Users can read their organization memberships"
on public.organization_members
for select
to authenticated
using (user_id = (select auth.uid()));

create policy "Organization managers can read branches"
on public.branches
for select
to authenticated
using (public.can_manage_organization(organization_id));

create policy "Organization managers can create branches"
on public.branches
for insert
to authenticated
with check (
  public.can_manage_organization(organization_id)
  and deleted_at is null
);

create policy "Organization managers can update branches"
on public.branches
for update
to authenticated
using (public.can_manage_organization(organization_id))
with check (public.can_manage_organization(organization_id));

create policy "Organization managers can read classes"
on public.classes
for select
to authenticated
using (public.can_manage_branch(branch_id));

create policy "Organization managers can create classes"
on public.classes
for insert
to authenticated
with check (public.can_manage_branch(branch_id) and deleted_at is null);

create policy "Organization managers can update classes"
on public.classes
for update
to authenticated
using (public.can_manage_branch(branch_id))
with check (public.can_manage_branch(branch_id));

create policy "Organization managers can read children"
on public.children
for select
to authenticated
using (public.can_manage_class(class_id));

create policy "Organization managers can create children"
on public.children
for insert
to authenticated
with check (public.can_manage_class(class_id) and deleted_at is null);

create policy "Organization managers can update children"
on public.children
for update
to authenticated
using (public.can_manage_class(class_id))
with check (public.can_manage_class(class_id));

revoke all on table public.organizations from anon, authenticated;
revoke all on table public.organization_members from anon, authenticated;
revoke all on table public.branches from anon, authenticated;
revoke all on table public.classes from anon, authenticated;
revoke all on table public.children from anon, authenticated;

grant select on table public.organizations to authenticated;
grant insert (name) on table public.organizations to authenticated;
grant update (name, deleted_at) on table public.organizations to authenticated;

grant select on table public.organization_members to authenticated;

grant select on table public.branches to authenticated;
grant insert (organization_id, name, city) on table public.branches to authenticated;
grant update (name, city, deleted_at) on table public.branches to authenticated;

grant select on table public.classes to authenticated;
grant insert (branch_id, name) on table public.classes to authenticated;
grant update (name, deleted_at) on table public.classes to authenticated;

grant select on table public.children to authenticated;
grant insert (class_id, full_name, birth_date) on table public.children
to authenticated;
grant update (class_id, full_name, birth_date, deleted_at)
on table public.children to authenticated;
