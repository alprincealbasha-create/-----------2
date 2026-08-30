create type public.integrity_flag_type as enum (
  'unusually_fast_activity',
  'excessive_activity',
  'sync_anomaly'
);

create type public.integrity_flag_status as enum (
  'open',
  'reviewed',
  'dismissed'
);

create table public.integrity_rules (
  flag_type public.integrity_flag_type primary key,
  window_seconds integer not null check (window_seconds between 1 and 604800),
  threshold_count integer not null check (threshold_count between 2 and 1000000),
  is_enabled boolean not null default true,
  updated_at timestamptz not null default now()
);

insert into public.integrity_rules (
  flag_type, window_seconds, threshold_count
) values
  ('unusually_fast_activity', 5, 20),
  ('excessive_activity', 86400, 5000),
  ('sync_anomaly', 86400, 10);

create table public.integrity_flags (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations (id),
  branch_id uuid not null references public.branches (id),
  branch_user_id uuid not null references public.branch_users (id),
  flag_type public.integrity_flag_type not null,
  status public.integrity_flag_status not null default 'open',
  window_started_at timestamptz not null,
  window_ended_at timestamptz not null,
  observed_count integer not null check (observed_count >= 0),
  threshold_count_snapshot integer not null check (threshold_count_snapshot > 0),
  evidence jsonb not null default '{}'::jsonb,
  deduplication_key text not null unique,
  detected_at timestamptz not null default now(),
  reviewed_by uuid references public.profiles (id),
  reviewed_at timestamptz,
  constraint integrity_flag_valid_window check (
    window_ended_at >= window_started_at
  ),
  constraint integrity_flag_review_consistency check (
    (status = 'open' and reviewed_by is null and reviewed_at is null)
    or (status <> 'open' and reviewed_by is not null and reviewed_at is not null)
  )
);

create table public.managed_wird_sync_attempts (
  operation_id uuid primary key,
  branch_user_id uuid not null references public.branch_users (id),
  attempt_count integer not null default 1 check (attempt_count > 0),
  first_attempt_at timestamptz not null default now(),
  last_attempt_at timestamptz not null default now()
);

create index integrity_flags_branch_status_detected_idx
  on public.integrity_flags (branch_id, status, detected_at desc);
create index integrity_flags_user_detected_idx
  on public.integrity_flags (branch_user_id, detected_at desc);

create trigger integrity_rules_set_updated_at
before update on public.integrity_rules
for each row execute function public.set_updated_at();

alter table public.integrity_rules enable row level security;
alter table public.integrity_flags enable row level security;
alter table public.managed_wird_sync_attempts enable row level security;

create policy integrity_rules_select_for_managers
on public.integrity_rules for select
to authenticated
using (
  exists (
    select 1 from public.organization_members member
     where member.user_id = (select auth.uid())
       and member.role in ('owner', 'admin')
  )
);

create policy integrity_flags_select_for_branch_managers
on public.integrity_flags for select
to authenticated
using (public.can_manage_branch(branch_id));

revoke all on public.integrity_rules from anon, authenticated;
revoke all on public.integrity_flags from anon, authenticated;
revoke all on public.managed_wird_sync_attempts from anon, authenticated;
grant select on public.integrity_rules to authenticated;
grant select on public.integrity_flags to authenticated;

create or replace function public.track_managed_wird_sync_attempt()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  attempt_total integer;
  sync_rule public.integrity_rules%rowtype;
  target_branch public.branches%rowtype;
begin
  begin
    insert into public.managed_wird_sync_attempts (
      operation_id, branch_user_id
    ) values (
      new.operation_id, new.branch_user_id
    )
    on conflict (operation_id) do update set
      attempt_count = public.managed_wird_sync_attempts.attempt_count + 1,
      last_attempt_at = now()
    returning attempt_count into attempt_total;

    select * into sync_rule
      from public.integrity_rules rule
     where rule.flag_type = 'sync_anomaly'
       and rule.is_enabled;

    if sync_rule.flag_type is not null
      and attempt_total >= sync_rule.threshold_count then
      select branch.* into target_branch
        from public.branch_users branch_user
        join public.branches branch on branch.id = branch_user.branch_id
       where branch_user.id = new.branch_user_id;

      if target_branch.id is not null then
        insert into public.integrity_flags (
          organization_id, branch_id, branch_user_id, flag_type,
          window_started_at, window_ended_at, observed_count,
          threshold_count_snapshot, evidence, deduplication_key
        ) values (
          target_branch.organization_id, target_branch.id,
          new.branch_user_id, 'sync_anomaly',
          now() - make_interval(secs => sync_rule.window_seconds), now(),
          attempt_total, sync_rule.threshold_count,
          jsonb_build_object('retry_count', attempt_total),
          'sync:' || new.operation_id::text
        ) on conflict (deduplication_key) do update set
          observed_count = excluded.observed_count,
          window_ended_at = excluded.window_ended_at,
          evidence = excluded.evidence;
      end if;
    end if;
  exception when others then
    -- Integrity observations must never block or alter a valid user mutation.
    return new;
  end;
  return new;
end;
$$;

create trigger managed_wird_mutations_track_sync_attempt
before insert on public.managed_wird_mutations
for each row execute function public.track_managed_wird_sync_attempt();

create or replace function public.detect_managed_wird_activity_flags()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  activity_rule public.integrity_rules%rowtype;
  target_branch public.branches%rowtype;
  activity_count integer;
  window_start timestamptz;
  bucket_key text;
begin
  begin
    select branch.* into target_branch
      from public.branch_users branch_user
      join public.branches branch on branch.id = branch_user.branch_id
     where branch_user.id = new.branch_user_id;
    if target_branch.id is null then
      return new;
    end if;

    for activity_rule in
      select * from public.integrity_rules rule
       where rule.flag_type in (
         'unusually_fast_activity', 'excessive_activity'
       ) and rule.is_enabled
    loop
      window_start := now() - make_interval(secs => activity_rule.window_seconds);
      select count(*) into activity_count
        from public.managed_wird_mutations mutation
       where mutation.branch_user_id = new.branch_user_id
         and mutation.created_at >= window_start;

      if activity_count >= activity_rule.threshold_count then
        bucket_key := case activity_rule.flag_type
          when 'unusually_fast_activity' then
            to_char(date_trunc('minute', now()), 'YYYYMMDDHH24MI')
          else to_char(now() at time zone 'UTC', 'YYYYMMDD')
        end;
        insert into public.integrity_flags (
          organization_id, branch_id, branch_user_id, flag_type,
          window_started_at, window_ended_at, observed_count,
          threshold_count_snapshot, evidence, deduplication_key
        ) values (
          target_branch.organization_id, target_branch.id,
          new.branch_user_id, activity_rule.flag_type,
          window_start, now(), activity_count,
          activity_rule.threshold_count,
          jsonb_build_object(
            'operation_count', activity_count,
            'window_seconds', activity_rule.window_seconds
          ),
          activity_rule.flag_type::text || ':'
            || new.branch_user_id::text || ':' || bucket_key
        ) on conflict (deduplication_key) do update set
          observed_count = greatest(
            public.integrity_flags.observed_count,
            excluded.observed_count
          ),
          window_ended_at = excluded.window_ended_at,
          evidence = excluded.evidence;
      end if;
    end loop;
  exception when others then
    -- A detector failure is intentionally non-blocking and non-destructive.
    return new;
  end;
  return new;
end;
$$;

create trigger managed_wird_mutations_detect_activity
after insert on public.managed_wird_mutations
for each row execute function public.detect_managed_wird_activity_flags();

revoke all on function public.track_managed_wird_sync_attempt() from public;
revoke all on function public.detect_managed_wird_activity_flags() from public;

create or replace function public.get_branch_integrity_flags(
  p_branch_id uuid
)
returns table (
  flag_id uuid,
  branch_user_id uuid,
  user_name text,
  flag_type public.integrity_flag_type,
  flag_status public.integrity_flag_status,
  observed_count integer,
  threshold_count integer,
  window_started_at timestamptz,
  window_ended_at timestamptz,
  evidence jsonb,
  detected_at timestamptz
)
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  if not public.can_manage_branch(p_branch_id) then
    raise exception 'Branch access denied.' using errcode = '42501';
  end if;

  return query
  select
    flag.id, flag.branch_user_id, branch_user.full_name::text,
    flag.flag_type, flag.status, flag.observed_count,
    flag.threshold_count_snapshot, flag.window_started_at,
    flag.window_ended_at, flag.evidence, flag.detected_at
  from public.integrity_flags flag
  join public.branch_users branch_user on branch_user.id = flag.branch_user_id
  where flag.branch_id = p_branch_id
  order by
    case flag.status when 'open' then 0 else 1 end,
    flag.detected_at desc;
end;
$$;

create or replace function public.review_integrity_flag(
  p_flag_id uuid,
  p_status text
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_branch_id uuid;
  selected_status public.integrity_flag_status;
begin
  if p_status not in ('reviewed', 'dismissed') then
    raise exception 'Invalid review status.' using errcode = '22023';
  end if;
  selected_status := p_status::public.integrity_flag_status;

  select flag.branch_id into target_branch_id
    from public.integrity_flags flag
   where flag.id = p_flag_id;
  if target_branch_id is null or not public.can_manage_branch(target_branch_id) then
    raise exception 'Branch access denied.' using errcode = '42501';
  end if;

  update public.integrity_flags
     set status = selected_status,
         reviewed_by = auth.uid(),
         reviewed_at = now()
   where id = p_flag_id;
end;
$$;

revoke all on function public.get_branch_integrity_flags(uuid) from public;
revoke all on function public.review_integrity_flag(uuid, text) from public;
grant execute on function public.get_branch_integrity_flags(uuid)
  to authenticated;
grant execute on function public.review_integrity_flag(uuid, text)
  to authenticated;
