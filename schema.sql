-- AGRNSM - Base centrale des réservations
-- À exécuter dans Supabase > SQL Editor.
-- Cette structure bloque un même jour + une même demi-journée
-- pour toutes les réservations actives (Demande ou Confirmée).

create extension if not exists pgcrypto;

create table if not exists public.reservations (
  id uuid primary key default gen_random_uuid(),
  activity_id integer not null,
  teacher text not null,
  school text not null,
  email text not null,
  phone text not null,
  date date not null,
  time time not null,
  half_day text not null check (half_day in ('matin','apres-midi')),
  level text not null,
  students integer not null check (students between 1 and 60),
  notes text,
  status text not null default 'Demande'
    check (status in ('Demande','Confirmée','Refusée','Annulée')),
  created_at timestamptz not null default now()
);

create unique index if not exists reservations_one_active_halfday
on public.reservations(date, half_day)
where status in ('Demande','Confirmée');

alter table public.reservations enable row level security;

-- Lecture publique limitée aux disponibilités : aucune donnée personnelle.
drop view if exists public.reservations_public;
create view public.reservations_public
with (security_invoker = false) as
select date, half_day, status
from public.reservations
where status in ('Demande','Confirmée');

grant select on public.reservations_public to anon, authenticated;

-- Pour permettre au site public d'envoyer une demande.
-- Cette politique autorise uniquement INSERT, pas la lecture des données personnelles.
drop policy if exists "public can create reservation" on public.reservations;
create policy "public can create reservation"
on public.reservations
for insert
to anon, authenticated
with check (
  status = 'Demande'
  and teacher <> ''
  and school <> ''
  and email <> ''
  and phone <> ''
);

-- Les enseignants ne peuvent pas lire la table complète.
-- L'administration se connecte avec un compte Supabase créé dans Authentication.
drop policy if exists "admin can read reservations" on public.reservations;
create policy "admin can read reservations"
on public.reservations
for select
to authenticated
using (true);

drop policy if exists "admin can update reservations" on public.reservations;
create policy "admin can update reservations"
on public.reservations
for update
to authenticated
using (true)
with check (true);

drop policy if exists "admin can delete reservations" on public.reservations;
create policy "admin can delete reservations"
on public.reservations
for delete
to authenticated
using (true);

-- IMPORTANT :
-- Pour une sécurité renforcée en production, créer une table profiles
-- avec un rôle 'admin' et remplacer les policies authenticated=true
-- par une vérification du rôle administrateur.
