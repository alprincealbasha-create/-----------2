create policy branch_users_select_own_profile
on public.branch_users for select
to authenticated
using (profile_id = (select auth.uid()) and deleted_at is null);

create or replace function public.can_view_linked_class(target_class_id uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
      from public.branch_users teacher
     where teacher.profile_id = auth.uid()
       and teacher.user_type = 'teacher'
       and teacher.class_id = target_class_id
       and teacher.deleted_at is null
  );
$$;

revoke all on function public.can_view_linked_class(uuid) from public;
grant execute on function public.can_view_linked_class(uuid) to authenticated;

create policy classes_select_linked_teacher
on public.classes for select
to authenticated
using (public.can_view_linked_class(id) and deleted_at is null);

create policy branch_users_select_linked_class_children
on public.branch_users for select
to authenticated
using (
  user_type = 'child'
  and class_id is not null
  and public.can_view_linked_class(class_id)
  and deleted_at is null
);

create policy managed_wirds_select_assigned_staff
on public.managed_wirds for select
to authenticated
using (
  exists (
    select 1 from public.branch_users staff
     where staff.id = assigned_user_id
       and staff.profile_id = (select auth.uid())
       and staff.user_type in ('teacher', 'administrator', 'branch_manager')
       and staff.deleted_at is null
  )
);

create policy managed_wird_progress_select_staff_own
on public.managed_wird_progress for select
to authenticated
using (
  exists (
    select 1 from public.branch_users staff
     where staff.id = branch_user_id
       and staff.profile_id = (select auth.uid())
       and staff.user_type in ('teacher', 'administrator', 'branch_manager')
       and staff.deleted_at is null
  )
);

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
  awarded_count integer;
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

      if awarded_count = 1 and assignee_type = 'child' then
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
