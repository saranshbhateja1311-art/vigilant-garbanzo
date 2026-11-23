-- JEE X OS atomic cloud snapshot.
-- Curriculum seed is bundled in tracker.json; user progress/settings are stored
-- as one JSON snapshot. Every row is restricted to its authenticated owner.

create table if not exists public.jeex_cloud_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb
    check (jsonb_typeof(data) = 'object' and octet_length(data::text) <= 1000000),
  version bigint not null default 1 check (version >= 1),
  client_updated_at timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table public.jeex_cloud_state enable row level security;

drop policy if exists jeex_cloud_state_select on public.jeex_cloud_state;
drop policy if exists jeex_cloud_state_insert on public.jeex_cloud_state;
drop policy if exists jeex_cloud_state_update on public.jeex_cloud_state;
drop policy if exists jeex_cloud_state_delete on public.jeex_cloud_state;

create policy jeex_cloud_state_select on public.jeex_cloud_state
  for select to authenticated using ((select auth.uid()) = user_id);
create policy jeex_cloud_state_insert on public.jeex_cloud_state
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy jeex_cloud_state_update on public.jeex_cloud_state
  for update to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy jeex_cloud_state_delete on public.jeex_cloud_state
  for delete to authenticated using ((select auth.uid()) = user_id);

grant select, insert, update, delete on public.jeex_cloud_state to authenticated;

create or replace function public.jeex_cloud_state_touch()
returns trigger language plpgsql set search_path = pg_catalog, public as $$
begin
  new.server_updated_at = now();
  if tg_op = 'UPDATE' then
    new.version = old.version + 1;
  else
    new.version = 1;
  end if;
  return new;
end;
$$;

drop trigger if exists jeex_cloud_state_touch_trigger on public.jeex_cloud_state;
create trigger jeex_cloud_state_touch_trigger
  before insert or update on public.jeex_cloud_state
  for each row execute function public.jeex_cloud_state_touch();
