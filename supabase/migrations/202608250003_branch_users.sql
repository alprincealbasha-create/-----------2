create type public.managed_user_type as enum (
  'child',
  'teacher',
  'administrator',
  'branch_manager'
);

create table public.branch_users (
  id uuid primary key default gen_random_uuid(),
  branch_id uuid not null references public.branches (id),
  class_id uuid references public.classes (id),
  profile_id uuid references public.profiles (id),
  user_type public.managed_user_type not null,
  full_name varchar(200) not null check (length(btrim(full_name)) > 0),
  birth_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  constraint branch_users_class_assignment check (
    (user_type in ('child', 'teacher') and class_id is not null)
    or
    (user_type in ('administrator', 'branch_manager') and class_id is null)
  )
);

create unique index branch_users_active_profile_unique
  on public.branch_users (profile_id)
  where profile_id is not null and deleted_at is null;

create index branch_users_branch_type_active_idx
  on public.branch_users (branch_id, user_type, full_name)
  where deleted_at is null;

create index branch_users_class_type_active_idx
  on public.branch_users (class_id, user_type, full_name)
  where deleted_at is null and class_id is not null;

create or replace function public.validate_branch_user_assignment()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_branch_id uuid;
begin
  if new.class_id is not null then
    select c.branch_id
      into target_branch_id
      from public.classes c
      join public.branches b on b.id = c.branch_id
     where c.id = new.class_id
       and c.deleted_at is null
       and b.deleted_at is null;

    if target_branch_id is null then
      raise exception 'The selected class is unavailable.' using errcode = '23514';
    end if;

    if new.branch_id is null then
      new.branch_id := target_branch_id;
    elsif new.branch_id <> target_branch_id then
      raise exception 'The class must belong to the selected branch.' using errcode = '23514';
    end if;
  elsif not exists (
    select 1 from public.branches b
     where b.id = new.branch_id and b.deleted_at is null
  ) then
    raise exception 'The selected branch is unavailable.' using errcode = '23514';
  end if;

  return new;
end;
$$;

create trigger branch_users_set_updated_at
before update on public.branch_users
for each row execute function public.set_updated_at();

insert into public.branch_users (
  id,
  branch_id,
  class_id,
  user_type,
  full_name,
  birth_date,
  created_at,
  updated_at,
  deleted_at
)
select
  ch.id,
  c.branch_id,
  ch.class_id,
  'child'::public.managed_user_type,
  ch.full_name,
  ch.birth_date,
  ch.created_at,
  ch.updated_at,
  ch.deleted_at
from public.children ch
join public.classes c on c.id = ch.class_id
on conflict (id) do nothing;

create trigger branch_users_validate_assignment
before insert or update of branch_id, class_id, user_type
on public.branch_users
for each row execute function public.validate_branch_user_assignment();

alter table public.branch_users enable row level security;

create policy branch_users_select_for_managers
on public.branch_users for select
to authenticated
using (public.can_manage_branch(branch_id));

create policy branch_users_insert_for_managers
on public.branch_users for insert
to authenticated
with check (public.can_manage_branch(branch_id));

create policy branch_users_update_for_managers
on public.branch_users for update
to authenticated
using (public.can_manage_branch(branch_id))
with check (public.can_manage_branch(branch_id));

revoke all on public.branch_users from anon, authenticated;
grant select on public.branch_users to authenticated;
grant insert (branch_id, class_id, user_type, full_name, birth_date)
  on public.branch_users to authenticated;
grant update (branch_id, class_id, user_type, full_name, birth_date, deleted_at)
  on public.branch_users to authenticated;

revoke all on function public.validate_branch_user_assignment() from public;

comment on table public.children is
  'Legacy phase-3 table. Existing rows are migrated to branch_users; new application writes use branch_users.';

comment on column public.branch_users.profile_id is
  'Optional Supabase Auth profile link. The Flutter client is intentionally not granted write access to this column.';
