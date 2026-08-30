create or replace function public.get_branch_child_rewards(
  p_branch_id uuid
)
returns table (
  child_id uuid,
  child_name text,
  class_name text,
  completed_wirds integer,
  points integer,
  current_streak integer,
  best_streak integer,
  earned_badges jsonb
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
    child.id,
    child.full_name::text,
    class.name::text,
    coalesce(summary.completed_wirds, 0),
    coalesce(summary.points, 0),
    coalesce(summary.current_streak, 0),
    coalesce(summary.best_streak, 0),
    coalesce(badges.items, '[]'::jsonb)
  from public.branch_users child
  left join public.classes class
    on class.id = child.class_id
  left join public.child_reward_summaries summary
    on summary.branch_user_id = child.id
  left join lateral (
    select jsonb_agg(
      jsonb_build_object(
        'code', definition.code,
        'name', definition.name,
        'emoji', definition.emoji,
        'description', definition.description,
        'awarded_at', award.awarded_at
      ) order by definition.display_order, award.awarded_at
    ) as items
    from public.badge_awards award
    join public.badge_definitions definition
      on definition.id = award.badge_id
    where award.branch_user_id = child.id
  ) badges on true
  where child.branch_id = p_branch_id
    and child.user_type = 'child'
    and child.deleted_at is null
  -- Administrative lookup is deterministic but never presents a score rank.
  order by lower(child.full_name), child.id;
end;
$$;

revoke all on function public.get_branch_child_rewards(uuid) from public;
grant execute on function public.get_branch_child_rewards(uuid)
  to authenticated;
