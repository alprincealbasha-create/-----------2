create type public.campaign_status as enum ('active', 'completed', 'archived');

create table public.campaigns (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations (id),
  name varchar(200) not null check (length(btrim(name)) between 1 and 200),
  dhikr_definition_id uuid not null references public.dhikr_definitions (id),
  dhikr_title_snapshot varchar(160) not null,
  dhikr_text_snapshot text not null,
  target_count bigint not null check (target_count between 1 and 1000000000),
  current_count bigint not null default 0 check (
    current_count >= 0 and current_count <= target_count
  ),
  status public.campaign_status not null default 'active',
  created_by uuid not null default auth.uid() references public.profiles (id),
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.campaign_mutations (
  operation_id uuid primary key,
  campaign_id uuid not null references public.campaigns (id),
  branch_user_id uuid not null references public.branch_users (id),
  branch_id uuid not null references public.branches (id),
  user_type public.managed_user_type not null,
  created_at timestamptz not null default now()
);

create index campaigns_organization_status_idx
  on public.campaigns (organization_id, status, created_at desc);
create index campaign_mutations_campaign_branch_idx
  on public.campaign_mutations (campaign_id, branch_id);
create index campaign_mutations_campaign_type_idx
  on public.campaign_mutations (campaign_id, user_type);

create trigger campaigns_set_updated_at
before update on public.campaigns
for each row execute function public.set_updated_at();

alter table public.campaigns enable row level security;
alter table public.campaign_mutations enable row level security;

create policy campaigns_select_for_managers_or_members
on public.campaigns for select
to authenticated
using (
  public.can_manage_organization(organization_id)
  or (
    status in ('active', 'completed')
    and exists (
      select 1
        from public.branch_users u
        join public.branches b on b.id = u.branch_id
       where u.profile_id = (select auth.uid())
         and u.deleted_at is null
         and b.deleted_at is null
         and b.organization_id = campaigns.organization_id
    )
  )
);

revoke all on public.campaigns from anon, authenticated;
revoke all on public.campaign_mutations from anon, authenticated;
grant select on public.campaigns to authenticated;

create or replace function public.create_campaign(
  p_organization_id uuid,
  p_name text,
  p_dhikr_definition_id uuid,
  p_target_count bigint
)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  selected_dhikr public.dhikr_definitions%rowtype;
  created_id uuid;
begin
  if not public.can_manage_organization(p_organization_id) then
    raise exception 'Organization access denied.' using errcode = '42501';
  end if;
  if p_name is null or length(btrim(p_name)) = 0 then
    raise exception 'A campaign name is required.' using errcode = '22023';
  end if;
  if p_target_count not between 1 and 1000000000 then
    raise exception 'Invalid campaign target.' using errcode = '22023';
  end if;
  select * into selected_dhikr
    from public.dhikr_definitions d
   where d.id = p_dhikr_definition_id and d.status = 'approved';
  if selected_dhikr.id is null then
    raise exception 'Only an approved dhikr can be used.' using errcode = '23514';
  end if;

  insert into public.campaigns (
    organization_id, name, dhikr_definition_id,
    dhikr_title_snapshot, dhikr_text_snapshot, target_count
  ) values (
    p_organization_id, btrim(p_name), selected_dhikr.id,
    selected_dhikr.title, selected_dhikr.display_text, p_target_count
  ) returning id into created_id;
  return created_id;
end;
$$;

create or replace function public.apply_campaign_increment(
  p_operation_id uuid,
  p_campaign_id uuid
)
returns table (
  current_count bigint,
  target_count bigint,
  is_completed boolean
)
language plpgsql
security definer
set search_path = ''
as $$
declare
  caller_id uuid := auth.uid();
  participant public.branch_users%rowtype;
  campaign_row public.campaigns%rowtype;
  inserted_count integer;
begin
  if caller_id is null then
    raise exception 'Authentication is required.' using errcode = '42501';
  end if;
  select * into participant from public.branch_users u
   where u.profile_id = caller_id and u.deleted_at is null;
  if participant.id is null then
    raise exception 'An active branch user is required.' using errcode = '42501';
  end if;

  select * into campaign_row from public.campaigns c
   where c.id = p_campaign_id
   for update;
  if campaign_row.id is null or not exists (
    select 1 from public.branches b
     where b.id = participant.branch_id
       and b.organization_id = campaign_row.organization_id
       and b.deleted_at is null
  ) then
    raise exception 'Campaign access denied.' using errcode = '42501';
  end if;

  insert into public.campaign_mutations (
    operation_id, campaign_id, branch_user_id, branch_id, user_type
  ) values (
    p_operation_id, p_campaign_id, participant.id,
    participant.branch_id, participant.user_type
  ) on conflict (operation_id) do nothing;
  get diagnostics inserted_count = row_count;

  if inserted_count = 0 then
    if not exists (
      select 1 from public.campaign_mutations m
       where m.operation_id = p_operation_id
         and m.campaign_id = p_campaign_id
         and m.branch_user_id = participant.id
    ) then
      raise exception 'Operation identifier conflict.' using errcode = '42501';
    end if;
  else
    if campaign_row.status <> 'active' then
      raise exception 'The campaign is not active.' using errcode = '22023';
    end if;
    update public.campaigns c set
      current_count = least(c.target_count, c.current_count + 1),
      status = case
        when c.current_count + 1 >= c.target_count then 'completed'
        else c.status
      end,
      completed_at = case
        when c.current_count + 1 >= c.target_count
          then coalesce(c.completed_at, now())
        else c.completed_at
      end
    where c.id = p_campaign_id
    returning * into campaign_row;
  end if;

  select * into campaign_row from public.campaigns c
   where c.id = p_campaign_id;
  return query select
    campaign_row.current_count,
    campaign_row.target_count,
    campaign_row.status = 'completed';
end;
$$;

create or replace function public.get_campaign_dashboard(
  p_organization_id uuid
)
returns table (
  campaign_id uuid,
  campaign_name text,
  dhikr_title text,
  target_count bigint,
  current_count bigint,
  campaign_status text,
  branch_contributions jsonb,
  category_contributions jsonb
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
  return query
    select
      c.id,
      c.name::text,
      c.dhikr_title_snapshot::text,
      c.target_count,
      c.current_count,
      c.status::text,
      (
        select coalesce(
          jsonb_agg(
            jsonb_build_object(
              'branch_id', b.id,
              'branch_name', b.name,
              'count', coalesce(x.contribution_count, 0)
            ) order by b.name
          ),
          '[]'::jsonb
        )
        from public.branches b
        left join (
          select m.branch_id, count(*) as contribution_count
            from public.campaign_mutations m
           where m.campaign_id = c.id
           group by m.branch_id
        ) x on x.branch_id = b.id
        where b.organization_id = p_organization_id
          and b.deleted_at is null
      ),
      (
        select coalesce(
          jsonb_agg(
            jsonb_build_object(
              'category', types.user_type::text,
              'count', coalesce(x.contribution_count, 0)
            ) order by types.user_type::text
          ),
          '[]'::jsonb
        )
        from unnest(enum_range(null::public.managed_user_type))
          as types(user_type)
        left join (
          select m.user_type, count(*) as contribution_count
            from public.campaign_mutations m
           where m.campaign_id = c.id
           group by m.user_type
        ) x on x.user_type = types.user_type
      )
    from public.campaigns c
    where c.organization_id = p_organization_id
      and c.status <> 'archived'
    order by c.created_at desc;
end;
$$;

revoke all on function public.create_campaign(uuid, text, uuid, bigint)
  from public;
revoke all on function public.apply_campaign_increment(uuid, uuid)
  from public;
revoke all on function public.get_campaign_dashboard(uuid) from public;
grant execute on function public.create_campaign(uuid, text, uuid, bigint)
  to authenticated;
grant execute on function public.apply_campaign_increment(uuid, uuid)
  to authenticated;
grant execute on function public.get_campaign_dashboard(uuid)
  to authenticated;

