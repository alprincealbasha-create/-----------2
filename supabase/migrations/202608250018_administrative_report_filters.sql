create index managed_wirds_administrative_report_idx
  on public.managed_wirds (branch_id, assigned_at, assigned_user_id)
  where deleted_at is null and status in ('assigned', 'completed');

create or replace function public.get_administrative_report_filter_options(
  p_organization_id uuid
)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  if not public.can_manage_organization(p_organization_id) then
    raise exception 'Organization access denied.' using errcode = '42501';
  end if;

  return jsonb_build_object(
    'branches', coalesce((
      select jsonb_agg(jsonb_build_object('id', b.id, 'label', b.name) order by b.name)
      from public.branches b
      where b.organization_id = p_organization_id and b.deleted_at is null
    ), '[]'::jsonb),
    'classes', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', c.id, 'label', c.name, 'branch_id', c.branch_id
      ) order by c.name)
      from public.classes c
      join public.branches b on b.id = c.branch_id
      where b.organization_id = p_organization_id
        and b.deleted_at is null and c.deleted_at is null
    ), '[]'::jsonb),
    'users', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', u.id, 'label', u.full_name, 'branch_id', u.branch_id,
        'class_id', u.class_id, 'role', u.user_type
      ) order by u.full_name)
      from public.branch_users u
      join public.branches b on b.id = u.branch_id
      where b.organization_id = p_organization_id
        and b.deleted_at is null and u.deleted_at is null
    ), '[]'::jsonb),
    'wirds', coalesce((
      select jsonb_agg(jsonb_build_object('id', p.id, 'label', p.name) order by p.name)
      from public.wird_programs p
      where p.organization_id = p_organization_id
    ), '[]'::jsonb),
    'dhikrs', coalesce((
      select jsonb_agg(jsonb_build_object('id', d.id, 'label', d.title) order by d.title)
      from public.dhikr_definitions d
      where exists (
        select 1 from public.wird_programs p
        where p.organization_id = p_organization_id
          and p.dhikr_definition_id = d.id
      )
    ), '[]'::jsonb)
  );
end;
$$;

create or replace function public.get_administrative_completion_report(
  p_organization_id uuid,
  p_start_date date,
  p_end_date date,
  p_branch_id uuid default null,
  p_class_id uuid default null,
  p_role text default null,
  p_user_id uuid default null,
  p_wird_id uuid default null,
  p_dhikr_id uuid default null,
  p_completion_status text default null
)
returns table (
  assignment_id uuid,
  activity_date date,
  branch_id uuid,
  branch_name text,
  class_id uuid,
  class_name text,
  user_id uuid,
  user_name text,
  user_role text,
  wird_id uuid,
  wird_name text,
  dhikr_id uuid,
  dhikr_title text,
  current_count integer,
  target_count integer,
  completion_status text,
  completed_at timestamptz
)
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  if not public.can_manage_organization(p_organization_id) then
    raise exception 'Organization access denied.' using errcode = '42501';
  end if;
  if p_start_date is null or p_end_date is null or p_end_date < p_start_date
    or p_end_date - p_start_date > 366 then
    raise exception 'Invalid report date range.' using errcode = '22023';
  end if;
  if p_role is not null and p_role not in (
    'child', 'teacher', 'administrator', 'branch_manager'
  ) then
    raise exception 'Invalid report role.' using errcode = '22023';
  end if;
  if p_completion_status is not null and p_completion_status not in (
    'not_started', 'in_progress', 'completed'
  ) then
    raise exception 'Invalid completion status.' using errcode = '22023';
  end if;

  return query
    select
      w.id,
      (coalesce(w.assigned_at, w.created_at) at time zone
        coalesce(w.availability_timezone, 'Asia/Damascus'))::date,
      b.id,
      b.name::text,
      c.id,
      c.name::text,
      u.id,
      u.full_name::text,
      u.user_type::text,
      p.id,
      coalesce(p.name, w.title)::text,
      w.dhikr_definition_id,
      coalesce(w.dhikr_title_snapshot, w.details, w.title)::text,
      coalesce(progress.count, 0),
      coalesce(w.target_count, 0),
      case
        when w.status = 'completed' then 'completed'
        when coalesce(progress.count, 0) > 0 then 'in_progress'
        else 'not_started'
      end,
      w.completed_at
    from public.managed_wirds w
    join public.branches b on b.id = w.branch_id
    join public.branch_users u on u.id = w.assigned_user_id
    left join public.classes c on c.id = u.class_id
    left join public.wird_programs p on p.id = w.wird_program_id
    left join public.managed_wird_progress progress on progress.wird_id = w.id
    where b.organization_id = p_organization_id
      and w.deleted_at is null
      and w.status in ('assigned', 'completed')
      and (coalesce(w.assigned_at, w.created_at) at time zone
        coalesce(w.availability_timezone, 'Asia/Damascus'))::date
          between p_start_date and p_end_date
      and (p_branch_id is null or b.id = p_branch_id)
      and (p_class_id is null or c.id = p_class_id)
      and (p_role is null or u.user_type::text = p_role)
      and (p_user_id is null or u.id = p_user_id)
      and (p_wird_id is null or p.id = p_wird_id)
      and (p_dhikr_id is null or w.dhikr_definition_id = p_dhikr_id)
      and (
        p_completion_status is null
        or case
          when w.status = 'completed' then 'completed'
          when coalesce(progress.count, 0) > 0 then 'in_progress'
          else 'not_started'
        end = p_completion_status
      )
    order by activity_date desc, b.name, u.full_name, wird_name;
end;
$$;

revoke all on function public.get_administrative_report_filter_options(uuid)
  from public;
revoke all on function public.get_administrative_completion_report(
  uuid, date, date, uuid, uuid, text, uuid, uuid, uuid, text
) from public;

grant execute on function public.get_administrative_report_filter_options(uuid)
  to authenticated;
grant execute on function public.get_administrative_completion_report(
  uuid, date, date, uuid, uuid, text, uuid, uuid, uuid, text
) to authenticated;

comment on function public.get_administrative_completion_report(
  uuid, date, date, uuid, uuid, text, uuid, uuid, uuid, text
) is 'Manager-only completion report with server-side date, branch, class, role, user, wird, dhikr, and completion filters.';
