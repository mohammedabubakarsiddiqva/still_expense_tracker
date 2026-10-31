-- Run in Supabase > SQL Editor
create table if not exists public.still_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.still_state enable row level security;
create policy "read own data" on public.still_state for select using ((select auth.uid()) = user_id);
create policy "insert own data" on public.still_state for insert with check ((select auth.uid()) = user_id);
create policy "update own data" on public.still_state for update using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "delete own data" on public.still_state for delete using ((select auth.uid()) = user_id);
