create or replace function public.get_central_daily_metrics(
  p_organization_id uuid,
  p_day_start timestamptz,
  p_day_end timestamptz
)
returns table (
  branch_id uuid,
  branch_name text,
  branch_city text,
  eligible_users bigint,
  participating_users bigint,
  completed_users bigint,
  participation_rate double precision,
  completion_rate double precision,
  total_recorded_dhikr bigint
)
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  if p_day_end <= p_day_start then
    raise exception 'Invalid day range.' using errcode = '22023';
  end if;
  if not public.can_manage_organization(p_organization_id) then
    raise exception 'Organization access denied.' using errcode = '42501';
  end if;

  return query
    with branch_scope as (
      select b.id, b.name, b.city
        from public.branches b
       where b.organization_id = p_organization_id
         and b.deleted_at is null
    ),
    active_users as (
      select u.branch_id, count(*) as user_count
        from public.branch_users u
        join branch_scope b on b.id = u.branch_id
       where u.deleted_at is null
       group by u.branch_id
    ),
    daily_mutations as (
      select w.branch_id, m.branch_user_id
        from public.managed_wird_mutations m
        join public.managed_wirds w on w.id = m.wird_id
        join public.branch_users u
          on u.id = m.branch_user_id
         and u.branch_id = w.branch_id
         and u.deleted_at is null
        join branch_scope b on b.id = w.branch_id
       where m.created_at >= p_day_start
         and m.created_at < p_day_end
    ),
    activity as (
      select
        m.branch_id,
        count(distinct m.branch_user_id) as participant_count,
        count(*) as mutation_count
      from daily_mutations m
      group by m.branch_id
    ),
    participants as (
      select distinct m.branch_id, m.branch_user_id
        from daily_mutations m
    ),
    completions as (
      select w.branch_id, count(distinct w.assigned_user_id) as completion_count
        from public.managed_wirds w
        join participants p
          on p.branch_id = w.branch_id
         and p.branch_user_id = w.assigned_user_id
       where w.status = 'completed'
         and w.completed_at >= p_day_start
         and w.completed_at < p_day_end
       group by w.branch_id
    )
    select
      b.id,
      b.name::text,
      b.city::text,
      coalesce(u.user_count, 0),
      coalesce(a.participant_count, 0),
      coalesce(c.completion_count, 0),
      case
        when coalesce(u.user_count, 0) = 0 then 0::double precision
        else round(
          (coalesce(a.participant_count, 0)::numeric * 100) / u.user_count,
          1
        )::double precision
      end,
      case
        when coalesce(a.participant_count, 0) = 0 then 0::double precision
        else round(
          (coalesce(c.completion_count, 0)::numeric * 100)
            / a.participant_count,
          1
        )::double precision
      end,
      coalesce(a.mutation_count, 0)
    from branch_scope b
    left join active_users u on u.branch_id = b.id
    left join activity a on a.branch_id = b.id
    left join completions c on c.branch_id = b.id
    order by
      case
        when coalesce(a.participant_count, 0) = 0 then 0
        else coalesce(c.completion_count, 0)::numeric / a.participant_count
      end desc,
      case
        when coalesce(u.user_count, 0) = 0 then 0
        else coalesce(a.participant_count, 0)::numeric / u.user_count
      end desc,
      b.name;
end;
$$;

revoke all on function public.get_central_daily_metrics(
  uuid, timestamptz, timestamptz
) from public;
grant execute on function public.get_central_daily_metrics(
  uuid, timestamptz, timestamptz
) to authenticated;

