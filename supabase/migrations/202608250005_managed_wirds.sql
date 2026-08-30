create type public.managed_wird_status as enum ('draft', 'assigned', 'completed');

create table public.managed_wirds (
  id uuid primary key default gen_random_uuid(),
  branch_id uuid not null references public.branches (id),
  assigned_user_id uuid references public.branch_users (id),
  title varchar(160) not null check (length(btrim(title)) > 0),
  details text,
  status public.managed_wird_status not null default 'draft',
  created_by uuid not null default auth.uid() references public.profiles (id),
  assigned_at timestamptz,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  constraint managed_wirds_state_consistent check (
    (status = 'draft' and assigned_user_id is null
      and assigned_at is null and completed_at is null)
    or
    (status = 'assigned' and assigned_user_id is not null
      and assigned_at is not null and completed_at is null)
    or
    (status = 'completed' and assigned_user_id is not null
      and assigned_at is not null and completed_at is not null)
  )
);

create index managed_wirds_branch_status_idx
  on public.managed_wirds (branch_id, status, updated_at desc)
  where deleted_at is null;

create index managed_wirds_assignee_status_idx
  on public.managed_wirds (assigned_user_id, status, updated_at desc)
  where deleted_at is null and assigned_user_id is not null;

create or replace function public.prepare_managed_wird()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if not exists (
    select 1 from public.branches b
     where b.id = new.branch_id and b.deleted_at is null
  ) then
    raise exception 'The selected branch is unavailable.' using errcode = '23514';
  end if;

  if tg_op = 'UPDATE' and old.status = 'completed' and (
    new.branch_id is distinct from old.branch_id
    or new.assigned_user_id is distinct from old.assigned_user_id
    or new.title is distinct from old.title
    or new.details is distinct from old.details
    or new.status is distinct from old.status
  ) then
    raise exception 'A completed wird cannot be changed.' using errcode = '23514';
  end if;

  if new.status = 'draft' then
    new.assigned_user_id := null;
    new.assigned_at := null;
    new.completed_at := null;
  else
    if new.assigned_user_id is null or not exists (
      select 1 from public.branch_users u
       where u.id = new.assigned_user_id
         and u.branch_id = new.branch_id
         and u.deleted_at is null
    ) then
      raise exception 'The assignee must be active in the selected branch.'
        using errcode = '23514';
    end if;

    if tg_op = 'INSERT'
      or old.status = 'draft'
      or new.assigned_user_id is distinct from old.assigned_user_id then
      new.assigned_at := now();
    end if;

    if new.status = 'assigned' then
      new.completed_at := null;
    elsif new.status = 'completed' and (
      tg_op = 'INSERT' or old.status <> 'completed'
    ) then
      new.completed_at := now();
    end if;
  end if;

  return new;
end;
$$;

create trigger managed_wirds_prepare
before insert or update on public.managed_wirds
for each row execute function public.prepare_managed_wird();

create trigger managed_wirds_set_updated_at
before update on public.managed_wirds
for each row execute function public.set_updated_at();

alter table public.managed_wirds enable row level security;

create policy managed_wirds_select_for_managers
on public.managed_wirds for select
to authenticated
using (public.can_manage_branch(branch_id));

create policy managed_wirds_insert_for_managers
on public.managed_wirds for insert
to authenticated
with check (
  created_by = (select auth.uid())
  and public.can_manage_branch(branch_id)
);

create policy managed_wirds_update_for_managers
on public.managed_wirds for update
to authenticated
using (public.can_manage_branch(branch_id))
with check (public.can_manage_branch(branch_id));

revoke all on public.managed_wirds from anon, authenticated;
grant select on public.managed_wirds to authenticated;
grant insert (branch_id, title, details) on public.managed_wirds to authenticated;
grant update (branch_id, assigned_user_id, title, details, status, deleted_at)
  on public.managed_wirds to authenticated;

revoke all on function public.prepare_managed_wird() from public;
