create or replace function public.get_branch_daily_metrics(
  p_branch_id uuid,
  p_day_start timestamptz,
  p_day_end timestamptz
)
returns table (
  participating_users bigint,
  completed_users bigint,
  completion_rate double precision,
  total_recorded_dhikr bigint,
  participating_children bigint,
  participating_staff bigint
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
  if not public.can_manage_branch(p_branch_id) then
    raise exception 'Branch access denied.' using errcode = '42501';
  end if;

  return query
    with daily_mutations as (
      select m.branch_user_id
        from public.managed_wird_mutations m
        join public.managed_wirds w on w.id = m.wird_id
       where w.branch_id = p_branch_id
         and m.created_at >= p_day_start
         and m.created_at < p_day_end
    ),
    participants as (
      select distinct branch_user_id from daily_mutations
    ),
    completions as (
      select distinct w.assigned_user_id as branch_user_id
        from public.managed_wirds w
        join participants p on p.branch_user_id = w.assigned_user_id
       where w.branch_id = p_branch_id
         and w.status = 'completed'
         and w.completed_at >= p_day_start
         and w.completed_at < p_day_end
    ),
    totals as (
      select
        (select count(*) from participants) as participant_count,
        (select count(*) from completions) as completion_count,
        (select count(*) from daily_mutations) as mutation_count,
        (
          select count(*)
            from participants p
            join public.branch_users u on u.id = p.branch_user_id
           where u.user_type = 'child'
        ) as child_count,
        (
          select count(*)
            from participants p
            join public.branch_users u on u.id = p.branch_user_id
           where u.user_type in ('teacher', 'administrator', 'branch_manager')
        ) as staff_count
    )
    select
      participant_count,
      completion_count,
      case
        when participant_count = 0 then 0::double precision
        else round(
          (completion_count::numeric * 100) / participant_count,
          1
        )::double precision
      end,
      mutation_count,
      child_count,
      staff_count
    from totals;
end;
$$;

revoke all on function public.get_branch_daily_metrics(
  uuid, timestamptz, timestamptz
) from public;
grant execute on function public.get_branch_daily_metrics(
  uuid, timestamptz, timestamptz
) to authenticated;
