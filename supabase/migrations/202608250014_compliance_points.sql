create type public.point_rule_event as enum (
  'wird_completed',
  'all_daily_wirds_completed',
  'streak_milestone'
);

create table public.point_rules (
  id uuid primary key default gen_random_uuid(),
  code varchar(64) not null unique,
  display_name varchar(160) not null,
  event_type public.point_rule_event not null,
  points integer not null check (points between 0 and 100000),
  threshold_days integer check (
    (event_type = 'streak_milestone' and threshold_days between 2 and 3650)
    or (event_type <> 'streak_milestone' and threshold_days is null)
  ),
  is_enabled boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

insert into public.point_rules (
  id, code, display_name, event_type, points, threshold_days
) values
  ('10000000-0000-4000-8000-000000000001', 'complete_wird',
   'إتمام ورد واحد', 'wird_completed', 10, null),
  ('10000000-0000-4000-8000-000000000002', 'complete_daily_wirds',
   'إتمام أوراد اليوم', 'all_daily_wirds_completed', 10, null),
  ('10000000-0000-4000-8000-000000000003', 'streak_3',
   '3 أيام متتالية', 'streak_milestone', 10, 3),
  ('10000000-0000-4000-8000-000000000004', 'streak_7',
   '7 أيام متتالية', 'streak_milestone', 30, 7),
  ('10000000-0000-4000-8000-000000000005', 'streak_30',
   '30 يومًا متتاليًا', 'streak_milestone', 100, 30);

create table public.user_compliance_days (
  branch_user_id uuid not null references public.branch_users (id),
  compliance_day date not null,
  completed_wirds integer not null check (completed_wirds > 0),
  streak_length integer not null check (streak_length > 0),
  timezone_name varchar(64) not null,
  created_at timestamptz not null default now(),
  primary key (branch_user_id, compliance_day)
);

create table public.point_awards (
  id uuid primary key default gen_random_uuid(),
  branch_user_id uuid not null references public.branch_users (id),
  rule_id uuid not null references public.point_rules (id),
  source_wird_id uuid references public.managed_wirds (id),
  compliance_day date,
  award_key varchar(200) not null,
  points_snapshot integer not null check (points_snapshot >= 0),
  created_at timestamptz not null default now(),
  unique (branch_user_id, rule_id, award_key)
);

create index point_awards_user_created_idx
  on public.point_awards (branch_user_id, created_at desc);

alter table public.child_reward_summaries
  add column current_streak integer not null default 0 check (current_streak >= 0),
  add column best_streak integer not null default 0 check (best_streak >= 0),
  add column last_compliance_day date;

create trigger point_rules_set_updated_at
before update on public.point_rules
for each row execute function public.set_updated_at();

alter table public.point_rules enable row level security;
alter table public.user_compliance_days enable row level security;
alter table public.point_awards enable row level security;

create policy point_rules_select_authenticated
on public.point_rules for select
to authenticated
using (true);

create policy compliance_days_select_own_child
on public.user_compliance_days for select
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

create policy point_awards_select_own_child
on public.point_awards for select
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

revoke all on public.point_rules from anon, authenticated;
revoke all on public.user_compliance_days from anon, authenticated;
revoke all on public.point_awards from anon, authenticated;
grant select on public.point_rules to authenticated;
grant select on public.user_compliance_days to authenticated;
grant select on public.point_awards to authenticated;

-- Preserve historical completions while replacing the former one-point rule.
insert into public.point_awards (
  branch_user_id, rule_id, source_wird_id, compliance_day,
  award_key, points_snapshot, created_at
)
select
  p.branch_user_id,
  '10000000-0000-4000-8000-000000000001',
  p.wird_id,
  (p.completed_at at time zone coalesce(w.availability_timezone, 'Asia/Damascus'))::date,
  'wird:' || p.wird_id::text,
  10,
  p.completed_at
from public.managed_wird_progress p
join public.managed_wirds w on w.id = p.wird_id
join public.branch_users u on u.id = p.branch_user_id
where p.completed_at is not null
  and u.user_type = 'child'
on conflict (branch_user_id, rule_id, award_key) do nothing;

update public.child_reward_summaries summary
set points = totals.points,
    completed_wirds = totals.completed_wirds
from (
  select
    a.branch_user_id,
    coalesce(sum(a.points_snapshot), 0)::integer as points,
    count(*) filter (where r.event_type = 'wird_completed')::integer
      as completed_wirds
  from public.point_awards a
  join public.point_rules r on r.id = a.rule_id
  group by a.branch_user_id
) totals
where summary.branch_user_id = totals.branch_user_id;

create or replace function public.award_child_compliance_points(
  p_branch_user_id uuid,
  p_wird_id uuid,
  p_completed_at timestamptz
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  zone_name text;
  local_day date;
  due_count integer;
  incomplete_count integer;
  previous_streak integer;
  calculated_streak integer;
  completion_rule public.point_rules%rowtype;
  daily_rule public.point_rules%rowtype;
  milestone_rule public.point_rules%rowtype;
begin
  if not exists (
    select 1 from public.branch_users u
     where u.id = p_branch_user_id
       and u.user_type = 'child'
       and u.deleted_at is null
  ) then
    return;
  end if;

  -- Serialize daily-completion evaluation for concurrent wird completions.
  perform 1
    from public.branch_users u
   where u.id = p_branch_user_id
   for update;

  select coalesce(w.availability_timezone, 'Asia/Damascus')
    into zone_name
    from public.managed_wirds w
   where w.id = p_wird_id
     and w.assigned_user_id = p_branch_user_id;
  if zone_name is null then
    raise exception 'The completed wird is unavailable.' using errcode = '23514';
  end if;
  local_day := (p_completed_at at time zone zone_name)::date;

  select * into completion_rule
    from public.point_rules r
   where r.code = 'complete_wird' and r.is_enabled;
  if completion_rule.id is not null then
    insert into public.point_awards (
      branch_user_id, rule_id, source_wird_id, compliance_day,
      award_key, points_snapshot
    ) values (
      p_branch_user_id, completion_rule.id, p_wird_id, local_day,
      'wird:' || p_wird_id::text, completion_rule.points
    ) on conflict (branch_user_id, rule_id, award_key) do nothing;
  end if;

  select count(*), count(*) filter (where w.status <> 'completed')
    into due_count, incomplete_count
    from public.managed_wirds w
   where w.assigned_user_id = p_branch_user_id
     and w.deleted_at is null
     and (w.available_from is null or w.available_from <= local_day)
     and (w.available_until is null or w.available_until >= local_day)
     and (
       w.status = 'assigned'
       or (
         w.status = 'completed'
         and (w.completed_at at time zone
           coalesce(w.availability_timezone, zone_name))::date = local_day
       )
     );

  if due_count > 0 and incomplete_count = 0 then
    select d.streak_length into previous_streak
      from public.user_compliance_days d
     where d.branch_user_id = p_branch_user_id
       and d.compliance_day = local_day - 1;
    calculated_streak := coalesce(previous_streak, 0) + 1;

    insert into public.user_compliance_days (
      branch_user_id, compliance_day, completed_wirds,
      streak_length, timezone_name
    ) values (
      p_branch_user_id, local_day, due_count,
      calculated_streak, zone_name
    ) on conflict (branch_user_id, compliance_day) do nothing;

    select d.streak_length into calculated_streak
      from public.user_compliance_days d
     where d.branch_user_id = p_branch_user_id
       and d.compliance_day = local_day;

    select * into daily_rule
      from public.point_rules r
     where r.code = 'complete_daily_wirds' and r.is_enabled;
    if daily_rule.id is not null then
      insert into public.point_awards (
        branch_user_id, rule_id, compliance_day, award_key, points_snapshot
      ) values (
        p_branch_user_id, daily_rule.id, local_day,
        'day:' || local_day::text, daily_rule.points
      ) on conflict (branch_user_id, rule_id, award_key) do nothing;
    end if;

    for milestone_rule in
      select * from public.point_rules r
       where r.event_type = 'streak_milestone'
         and r.is_enabled
         and r.threshold_days <= calculated_streak
    loop
      insert into public.point_awards (
        branch_user_id, rule_id, compliance_day, award_key, points_snapshot
      ) values (
        p_branch_user_id, milestone_rule.id, local_day,
        'streak:' || (local_day - calculated_streak + 1)::text
          || ':' || milestone_rule.threshold_days::text,
        milestone_rule.points
      ) on conflict (branch_user_id, rule_id, award_key) do nothing;
    end loop;
  end if;

  insert into public.child_reward_summaries (
    branch_user_id, points, completed_wirds, badge,
    current_streak, best_streak, last_compliance_day
  )
  select
    p_branch_user_id,
    coalesce(sum(a.points_snapshot), 0)::integer,
    count(*) filter (where r.event_type = 'wird_completed')::integer,
    case when count(*) filter (where r.event_type = 'wird_completed') > 0
      then 'first_wird' else null end,
    coalesce(day_summary.current_streak, 0),
    coalesce(day_summary.best_streak, 0),
    day_summary.last_day
  from (select 1) seed
  left join public.point_awards a on a.branch_user_id = p_branch_user_id
  left join public.point_rules r on r.id = a.rule_id
  left join lateral (
    select
      max(d.streak_length) filter (where d.compliance_day = local_day)
        as current_streak,
      max(d.streak_length) as best_streak,
      max(d.compliance_day) as last_day
    from public.user_compliance_days d
    where d.branch_user_id = p_branch_user_id
  ) day_summary on true
  group by day_summary.current_streak, day_summary.best_streak,
    day_summary.last_day
  on conflict (branch_user_id) do update set
    points = excluded.points,
    completed_wirds = excluded.completed_wirds,
    badge = coalesce(public.child_reward_summaries.badge, excluded.badge),
    current_streak = excluded.current_streak,
    best_streak = excluded.best_streak,
    last_compliance_day = excluded.last_compliance_day;
end;
$$;

revoke all on function public.award_child_compliance_points(
  uuid, uuid, timestamptz
) from public;

create or replace function public.apply_assigned_wird_increment(
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
  assignee_type public.managed_user_type;
  target_value integer;
  progress_value integer;
  inserted_count integer;
  completed_count integer;
  completion_time timestamptz;
begin
  if caller_id is null then
    raise exception 'Authentication is required.' using errcode = '42501';
  end if;

  select w.assigned_user_id, w.target_count, u.user_type
    into assignee_id, target_value, assignee_type
    from public.managed_wirds w
    join public.branch_users u on u.id = w.assigned_user_id
   where w.id = p_wird_id
     and w.status in ('assigned', 'completed')
     and w.deleted_at is null
     and u.profile_id = caller_id
     and u.deleted_at is null
   for update of w;

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
      completion_time := now();
      update public.managed_wirds
         set status = 'completed', completed_at = completion_time
       where id = p_wird_id and status = 'assigned';
      get diagnostics completed_count = row_count;

      update public.managed_wird_progress
         set completed_at = coalesce(completed_at, completion_time)
       where wird_id = p_wird_id;

      if completed_count = 1 and assignee_type = 'child' then
        perform public.award_child_compliance_points(
          assignee_id, p_wird_id, completion_time
        );
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
      case when assignee_type = 'child' then coalesce(r.points, 0) else 0 end,
      case when assignee_type = 'child' then r.badge::text else null end
    from (select 1) seed
    left join public.child_reward_summaries r
      on r.branch_user_id = assignee_id;
end;
$$;

revoke all on function public.apply_assigned_wird_increment(uuid, uuid)
  from public;
grant execute on function public.apply_assigned_wird_increment(uuid, uuid)
  to authenticated;
