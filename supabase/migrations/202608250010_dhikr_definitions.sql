create type public.dhikr_definition_status as enum (
  'draft',
  'under_review',
  'approved',
  'archived'
);

create table public.dhikr_definitions (
  id uuid primary key default gen_random_uuid(),
  title varchar(160) not null check (length(btrim(title)) between 1 and 160),
  display_text text not null check (length(btrim(display_text)) > 0),
  description text,
  default_target integer not null check (default_target between 1 and 100000),
  status public.dhikr_definition_status not null default 'draft',
  created_by uuid not null default auth.uid() references public.profiles (id),
  source_reference text,
  content_version integer not null default 1 check (content_version > 0),
  content_checksum text generated always as (
    md5(
      title || E'\n' || display_text || E'\n'
      || coalesce(description, '') || E'\n' || default_target::text
    )
  ) stored,
  reviewed_by uuid references public.profiles (id),
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint approved_dhikr_has_review check (
    status <> 'approved'
    or (
      source_reference is not null
      and length(btrim(source_reference)) > 0
      and reviewed_by is not null
      and reviewed_at is not null
    )
  )
);

create index dhikr_definitions_status_title_idx
  on public.dhikr_definitions (status, title);

create or replace function public.prepare_dhikr_definition()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  content_changed boolean := false;
begin
  new.title := btrim(new.title);
  new.display_text := btrim(new.display_text);
  new.description := nullif(btrim(new.description), '');
  new.source_reference := nullif(btrim(new.source_reference), '');

  if tg_op = 'UPDATE' then
    if new.created_by is distinct from old.created_by then
      raise exception 'The creator cannot be changed.' using errcode = '42501';
    end if;
    content_changed :=
      new.title is distinct from old.title
      or new.display_text is distinct from old.display_text
      or new.description is distinct from old.description
      or new.default_target is distinct from old.default_target
      or new.source_reference is distinct from old.source_reference;
    if content_changed then
      new.content_version := old.content_version + 1;
      if old.status = 'approved' then
        new.status := 'under_review';
      end if;
      new.reviewed_by := null;
      new.reviewed_at := null;
    else
      new.content_version := old.content_version;
    end if;
  end if;

  if new.status = 'approved' and (
    tg_op = 'INSERT'
    or old.status <> 'approved'
  ) then
    if new.source_reference is null then
      raise exception 'A source reference is required for approval.'
        using errcode = '23514';
    end if;
    new.reviewed_by := auth.uid();
    new.reviewed_at := now();
  elsif new.status in ('draft', 'under_review') then
    new.reviewed_by := null;
    new.reviewed_at := null;
  end if;

  return new;
end;
$$;

create trigger dhikr_definitions_prepare
before insert or update on public.dhikr_definitions
for each row execute function public.prepare_dhikr_definition();

create trigger dhikr_definitions_set_updated_at
before update on public.dhikr_definitions
for each row execute function public.set_updated_at();

alter table public.dhikr_definitions enable row level security;

create policy dhikr_definitions_read_approved_or_admin
on public.dhikr_definitions for select
to authenticated
using (status = 'approved' or public.is_admin());

create policy dhikr_definitions_create_draft_for_admin
on public.dhikr_definitions for insert
to authenticated
with check (
  public.is_admin()
  and created_by = (select auth.uid())
  and status = 'draft'
);

create policy dhikr_definitions_update_for_admin
on public.dhikr_definitions for update
to authenticated
using (public.is_admin())
with check (public.is_admin());

revoke all on public.dhikr_definitions from anon, authenticated;
grant select on public.dhikr_definitions to authenticated;
grant insert (
  title, display_text, description, default_target, source_reference
) on public.dhikr_definitions to authenticated;
grant update (
  title, display_text, description, default_target, status, source_reference
) on public.dhikr_definitions to authenticated;

revoke all on function public.prepare_dhikr_definition() from public;
