create type public.badge_award_type as enum (
  'first_wird',
  'streak_milestone',
  'manual'
);

create table public.badge_definitions (
  id uuid primary key default gen_random_uuid(),
  code varchar(64) not null unique,
  name varchar(120) not null,
  emoji varchar(16) not null,
  description varchar(240) not null,
  award_type public.badge_award_type not null,
  threshold_days integer check (
    (award_type = 'streak_milestone' and threshold_days between 2 and 3650)
    or (award_type <> 'streak_milestone' and threshold_days is null)
  ),
  is_enabled boolean not null default true,
  display_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

insert into public.badge_definitions (
  id, code, name, emoji, description, award_type,
  threshold_days, display_order
) values
  ('20000000-0000-4000-8000-000000000001', 'good_start',
   'البداية الطيبة', '🌱', 'إتمام أول ورد.', 'first_wird', null, 10),
  ('20000000-0000-4000-8000-000000000002', 'consistent',
   'المواظب', '⭐', 'إتمام الأوراد 7 أيام متتالية.',
   'streak_milestone', 7, 20),
  ('20000000-0000-4000-8000-000000000003', 'outstanding',
   'المتميز', '🌟', '30 يومًا من الالتزام.',
   'streak_milestone', 30, 30),
  ('20000000-0000-4000-8000-000000000004', 'continuity',
   'الاستمرار', '🏆', 'مرحلة متقدمة تمنحها الإدارة.',
   'manual', null, 40);

create table public.badge_awards (
  id uuid primary key default gen_random_uuid(),
  branch_user_id uuid not null references public.branch_users (id),
  badge_id uuid not null references public.badge_definitions (id),
  awarded_by uuid references public.profiles (id),
  awarded_at timestamptz not null default now(),
  unique (branch_user_id, badge_id)
);

create index badge_awards_user_awarded_idx
  on public.badge_awards (branch_user_id, awarded_at desc);

create trigger badge_definitions_set_updated_at
before update on public.badge_definitions
for each row execute function public.set_updated_at();

alter table public.badge_definitions enable row level security;
alter table public.badge_awards enable row level security;

create policy badge_definitions_select_authenticated
on public.badge_definitions for select
to authenticated
using (true);

create policy badge_awards_select_own_or_manager
on public.badge_awards for select
to authenticated
using (
  exists (
    select 1 from public.branch_users u
     where u.id = branch_user_id
       and u.deleted_at is null
       and (
         u.profile_id = (select auth.uid())
         or public.can_manage_branch(u.branch_id)
       )
  )
);

revoke all on public.badge_definitions from anon, authenticated;
revoke all on public.badge_awards from anon, authenticated;
grant select on public.badge_definitions to authenticated;
grant select on public.badge_awards to authenticated;

create or replace function public.grant_automatic_child_badges()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.badge_awards (branch_user_id, badge_id)
  select new.branch_user_id, badge.id
    from public.badge_definitions badge
   where badge.is_enabled
     and (
       (badge.award_type = 'first_wird' and new.completed_wirds >= 1)
       or (
         badge.award_type = 'streak_milestone'
         and new.best_streak >= badge.threshold_days
       )
     )
  on conflict (branch_user_id, badge_id) do nothing;
  return new;
end;
$$;

create trigger child_reward_summaries_grant_badges
after insert or update of completed_wirds, best_streak
on public.child_reward_summaries
for each row execute function public.grant_automatic_child_badges();

revoke all on function public.grant_automatic_child_badges() from public;

-- Grant automatic badges for summaries that existed before this migration.
insert into public.badge_awards (branch_user_id, badge_id)
select summary.branch_user_id, badge.id
  from public.child_reward_summaries summary
  join public.badge_definitions badge on badge.is_enabled
 where (
   badge.award_type = 'first_wird' and summary.completed_wirds >= 1
 ) or (
   badge.award_type = 'streak_milestone'
   and summary.best_streak >= badge.threshold_days
 )
on conflict (branch_user_id, badge_id) do nothing;

create or replace function public.award_manual_badge(
  p_badge_id uuid,
  p_branch_user_id uuid
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_branch_id uuid;
begin
  select u.branch_id into target_branch_id
    from public.branch_users u
   where u.id = p_branch_user_id
     and u.user_type = 'child'
     and u.deleted_at is null;
  if target_branch_id is null or not public.can_manage_branch(target_branch_id) then
    raise exception 'Branch access denied.' using errcode = '42501';
  end if;
  if not exists (
    select 1 from public.badge_definitions badge
     where badge.id = p_badge_id
       and badge.award_type = 'manual'
       and badge.is_enabled
  ) then
    raise exception 'The manual badge is unavailable.' using errcode = '23514';
  end if;

  insert into public.badge_awards (
    branch_user_id, badge_id, awarded_by
  ) values (
    p_branch_user_id, p_badge_id, auth.uid()
  ) on conflict (branch_user_id, badge_id) do nothing;
end;
$$;

revoke all on function public.award_manual_badge(uuid, uuid) from public;
grant execute on function public.award_manual_badge(uuid, uuid)
  to authenticated;
