alter table public.managed_wirds
  add column target_count integer check (
    target_count is null or target_count between 1 and 100000
  );

grant insert (target_count) on public.managed_wirds to authenticated;
grant update (target_count) on public.managed_wirds to authenticated;

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
    or new.target_count is distinct from old.target_count
    or new.status is distinct from old.status
  ) then
    raise exception 'A completed wird cannot be changed.' using errcode = '23514';
  end if;

  if new.status = 'draft' then
    new.assigned_user_id := null;
    new.assigned_at := null;
    new.completed_at := null;
  else
    if new.target_count is null then
      raise exception 'A target is required before assignment.' using errcode = '23514';
    end if;
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

create table public.managed_wird_progress (
  wird_id uuid primary key references public.managed_wirds (id),
  branch_user_id uuid not null references public.branch_users (id),
  count integer not null default 0 check (count >= 0),
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.managed_wird_mutations (
  operation_id uuid primary key,
  wird_id uuid not null references public.managed_wirds (id),
  branch_user_id uuid not null references public.branch_users (id),
  created_at timestamptz not null default now()
);

create table public.child_reward_summaries (
  branch_user_id uuid primary key references public.branch_users (id),
  points integer not null default 0 check (points >= 0),
  completed_wirds integer not null default 0 check (completed_wirds >= 0),
  badge varchar(40) check (badge is null or badge = 'first_wird'),
  updated_at timestamptz not null default now()
);

create index managed_wird_mutations_user_created_idx
  on public.managed_wird_mutations (branch_user_id, created_at desc);

create trigger managed_wird_progress_set_updated_at
before update on public.managed_wird_progress
for each row execute function public.set_updated_at();

create trigger child_reward_summaries_set_updated_at
before update on public.child_reward_summaries
for each row execute function public.set_updated_at();

alter table public.managed_wird_progress enable row level security;
alter table public.managed_wird_mutations enable row level security;
alter table public.child_reward_summaries enable row level security;

create policy managed_wirds_select_assigned_child
on public.managed_wirds for select
to authenticated
using (
  exists (
    select 1 from public.branch_users u
     where u.id = assigned_user_id
       and u.profile_id = (select auth.uid())
       and u.user_type = 'child'
       and u.deleted_at is null
  )
);

create policy managed_wird_progress_select_own
on public.managed_wird_progress for select
to authenticated
using (
  exists (
    select 1 from public.branch_users u
     where u.id = branch_user_id
       and u.profile_id = (select auth.uid())
       and u.user_type = 'child'
       and u.deleted_at is null
  )
);

create policy child_rewards_select_own
on public.child_reward_summaries for select
to authenticated
using (
  exists (
    select 1 from public.branch_users u
     where u.id = branch_user_id
       and u.profile_id = (select auth.uid())
       and u.user_type = 'child'
       and u.deleted_at is null
  )
);

revoke all on public.managed_wird_progress from anon, authenticated;
revoke all on public.managed_wird_mutations from anon, authenticated;
revoke all on public.child_reward_summaries from anon, authenticated;
grant select on public.managed_wird_progress to authenticated;
grant select on public.child_reward_summaries to authenticated;

create or replace function public.apply_managed_wird_increment(
  p_operation_id uuid,
  p_wird_id uuid
)
returns table (
  current_count integer,
  target_count integer,
  is_completed boolean,
  total_points integer,
  current_badge text
)
language plpgsql
security definer
set search_path = ''
as $$
declare
  caller_id uuid := auth.uid();
  assignee_id uuid;
  target_value integer;
  progress_value integer;
  inserted_count integer;
  awarded_count integer;
begin
  if caller_id is null then
    raise exception 'Authentication is required.' using errcode = '42501';
  end if;

  select w.assigned_user_id, w.target_count
    into assignee_id, target_value
    from public.managed_wirds w
    join public.branch_users u on u.id = w.assigned_user_id
   where w.id = p_wird_id
     and w.status in ('assigned', 'completed')
     and w.deleted_at is null
     and u.profile_id = caller_id
     and u.user_type = 'child'
     and u.deleted_at is null;

  if assignee_id is null or target_value is null then
    raise exception 'The assigned wird is unavailable.' using errcode = '42501';
  end if;

  insert into public.managed_wird_mutations (
    operation_id, wird_id, branch_user_id
  ) values (
    p_operation_id, p_wird_id, assignee_id
  ) on conflict (operation_id) do nothing;
  get diagnostics inserted_count = row_count;

  if inserted_count = 0 then
    if not exists (
      select 1 from public.managed_wird_mutations m
       where m.operation_id = p_operation_id
         and m.wird_id = p_wird_id
         and m.branch_user_id = assignee_id
    ) then
      raise exception 'Operation identifier conflict.' using errcode = '42501';
    end if;
  else
    insert into public.managed_wird_progress (
      wird_id, branch_user_id, count
    ) values (
      p_wird_id, assignee_id, 1
    ) on conflict (wird_id) do update set
      count = least(target_value, public.managed_wird_progress.count + 1)
    returning count into progress_value;

    if progress_value >= target_value then
      update public.managed_wirds
         set status = 'completed'
       where id = p_wird_id and status = 'assigned';
      get diagnostics awarded_count = row_count;

      update public.managed_wird_progress
         set completed_at = coalesce(completed_at, now())
       where wird_id = p_wird_id;

      if awarded_count = 1 then
        insert into public.child_reward_summaries (
          branch_user_id, points, completed_wirds, badge
        ) values (
          assignee_id, 1, 1, 'first_wird'
        ) on conflict (branch_user_id) do update set
          points = public.child_reward_summaries.points + 1,
          completed_wirds = public.child_reward_summaries.completed_wirds + 1,
          badge = coalesce(public.child_reward_summaries.badge, 'first_wird');
      end if;
    end if;
  end if;

  select coalesce(p.count, 0)
    into progress_value
    from public.managed_wirds w
    left join public.managed_wird_progress p on p.wird_id = w.id
   where w.id = p_wird_id;

  return query
    select
      progress_value,
      target_value,
      progress_value >= target_value,
      coalesce(r.points, 0),
      r.badge::text
    from (select 1) seed
    left join public.child_reward_summaries r
      on r.branch_user_id = assignee_id;
end;
$$;

revoke all on function public.apply_managed_wird_increment(uuid, uuid)
  from public;
grant execute on function public.apply_managed_wird_increment(uuid, uuid)
  to authenticated;
