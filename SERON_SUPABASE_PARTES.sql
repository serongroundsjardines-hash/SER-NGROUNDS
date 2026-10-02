-- SERÓN GROUNDS · habilitar partes/incidencias del portal trabajador
-- Ejecutar una sola vez en Supabase > SQL Editor.

alter table public.worker_incidents enable row level security;

drop policy if exists worker_incidents_read on public.worker_incidents;
drop policy if exists worker_incidents_insert on public.worker_incidents;

create policy worker_incidents_read
on public.worker_incidents for select
to anon
using (true);

create policy worker_incidents_insert
on public.worker_incidents for insert
to anon
with check (true);

-- El portal guarda hasta 4 fotos comprimidas dentro del campo JSONB "photos".
-- No modifica ni borra los fichajes existentes.
