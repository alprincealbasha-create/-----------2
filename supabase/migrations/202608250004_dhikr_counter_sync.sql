create type public.dhikr_completion_status as enum ('in_progress', 'completed');

create table public.dhikr_sessions (
  id uuid primary key,
  user_id uuid not null references public.profiles (id),
  title varchar(160) not null check (length(btrim(title)) > 0),
  target integer not null check (target between 1 and 100000),
  count integer not null default 0 check (count >= 0 and count <= target),
  status public.dhikr_completion_status not null default 'in_progress',
  client_created_at timestamptz not null,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint dhikr_sessions_completion_consistent check (
    (status = 'in_progress' and count < target and completed_at is null)
    or
    (status = 'completed' and count = target and completed_at is not null)
  )
);

create table public.dhikr_mutations (
  operation_id uuid primary key,
  user_id uuid not null references public.profiles (id),
  session_id uuid not null references public.dhikr_sessions (id),
  delta integer not null check (delta > 0 and delta <= 1000),
  client_created_at timestamptz not null,
  created_at timestamptz not null default now()
);

create index dhikr_sessions_user_updated_idx
  on public.dhikr_sessions (user_id, updated_at desc);

create index dhikr_mutations_user_created_idx
  on public.dhikr_mutations (user_id, created_at desc);

create trigger dhikr_sessions_set_updated_at
before update on public.dhikr_sessions
for each row execute function public.set_updated_at();

alter table public.dhikr_sessions enable row level security;
alter table public.dhikr_mutations enable row level security;

create policy dhikr_sessions_select_own
on public.dhikr_sessions for select
to authenticated
using (user_id = (select auth.uid()));

create policy dhikr_mutations_select_own
on public.dhikr_mutations for select
to authenticated
using (user_id = (select auth.uid()));

revoke all on public.dhikr_sessions from anon, authenticated;
revoke all on public.dhikr_mutations from anon, authenticated;
grant select on public.dhikr_sessions to authenticated;

create or replace function public.apply_dhikr_increment(
  p_operation_id uuid,
  p_session_id uuid,
  p_title text,
  p_target integer,
  p_delta integer,
  p_client_created_at timestamptz
)
returns table (
  current_count integer,
  current_status public.dhikr_completion_status,
  current_completed_at timestamptz
)
language plpgsql
security definer
set search_path = ''
as $$
declare
  caller_id uuid := auth.uid();
  existing_operation public.dhikr_mutations%rowtype;
  existing_session public.dhikr_sessions%rowtype;
begin
  if caller_id is null then
    raise exception 'Authentication is required.' using errcode = '42501';
  end if;
  if length(btrim(p_title)) = 0 or length(p_title) > 160 then
    raise exception 'Invalid title.' using errcode = '22023';
  end if;
  if p_target < 1 or p_target > 100000 or p_delta < 1 or p_delta > 1000 then
    raise exception 'Invalid counter values.' using errcode = '22023';
  end if;

  select * into existing_operation
    from public.dhikr_mutations
   where operation_id = p_operation_id;

  if found then
    if existing_operation.user_id <> caller_id
      or existing_operation.session_id <> p_session_id then
      raise exception 'Operation identifier conflict.' using errcode = '42501';
    end if;
    return query
      select s.count, s.status, s.completed_at
        from public.dhikr_sessions s
       where s.id = p_session_id and s.user_id = caller_id;
    return;
  end if;

  select * into existing_session
    from public.dhikr_sessions
   where id = p_session_id;

  if found and existing_session.user_id <> caller_id then
    raise exception 'Session identifier conflict.' using errcode = '42501';
  end if;

  insert into public.dhikr_sessions (
    id, user_id, title, target, count, status, client_created_at,
    completed_at
  ) values (
    p_session_id,
    caller_id,
    btrim(p_title),
    p_target,
    least(p_delta, p_target),
    case when p_delta >= p_target
      then 'completed'::public.dhikr_completion_status
      else 'in_progress'::public.dhikr_completion_status end,
    p_client_created_at,
    case when p_delta >= p_target then now() else null end
  )
  on conflict (id) do update set
    count = least(public.dhikr_sessions.target, public.dhikr_sessions.count + p_delta),
    status = case
      when public.dhikr_sessions.count + p_delta >= public.dhikr_sessions.target
        then 'completed'::public.dhikr_completion_status
      else 'in_progress'::public.dhikr_completion_status end,
    completed_at = case
      when public.dhikr_sessions.count + p_delta >= public.dhikr_sessions.target
        then coalesce(public.dhikr_sessions.completed_at, now())
      else null end;

  insert into public.dhikr_mutations (
    operation_id, user_id, session_id, delta, client_created_at
  ) values (
    p_operation_id, caller_id, p_session_id, p_delta, p_client_created_at
  );

  return query
    select s.count, s.status, s.completed_at
      from public.dhikr_sessions s
     where s.id = p_session_id and s.user_id = caller_id;
end;
$$;

revoke all on function public.apply_dhikr_increment(
  uuid, uuid, text, integer, integer, timestamptz
) from public;
grant execute on function public.apply_dhikr_increment(
  uuid, uuid, text, integer, integer, timestamptz
) to authenticated;
