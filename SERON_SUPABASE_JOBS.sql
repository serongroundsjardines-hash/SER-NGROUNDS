-- SERÓN GROUNDS
-- Preparación de public.jobs para la aplicación.
-- No borra trabajos existentes.

alter table public.jobs
  add column if not exists address text,
  add column if not exists type text,
  add column if not exists notes text,
  add column if not exists active boolean default true;

update public.jobs
set active = true
where active is null;

alter table public.jobs enable row level security;

drop policy if exists jobs_read on public.jobs;
drop policy if exists jobs_insert on public.jobs;
drop policy if exists jobs_update on public.jobs;

create policy jobs_read
on public.jobs for select
to anon
using (true);

create policy jobs_insert
on public.jobs for insert
to anon
with check (true);

create policy jobs_update
on public.jobs for update
to anon
using (true)
with check (true);

-- Recargar la caché de esquema de PostgREST.
notify pgrst, 'reload schema';
