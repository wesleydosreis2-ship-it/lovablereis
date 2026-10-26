-- LeadFlow: execute no SQL Editor do Supabase.
create extension if not exists pgcrypto;
create table if not exists public.leads (
 id uuid primary key default gen_random_uuid(), name text not null, phone text not null default '', address text not null default '', product text not null default '',
 sale_date date not null default current_date, amount numeric(12,2) not null default 0 check(amount>=0), shipping_cost numeric(12,2) not null default 0 check(shipping_cost>=0),
 product_cost numeric(12,2) not null default 0 check(product_cost>=0), status text not null default 'novo' check(status in ('novo','atendimento','vendido','perdido')),
 payment_status text not null default 'recebido' check(payment_status in ('recebido','pendente')), notes text not null default '', created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists public.expenses (
 id uuid primary key default gen_random_uuid(), description text not null, amount numeric(12,2) not null check(amount>0), date date not null default current_date,
 category text not null default 'Operacional', created_at timestamptz not null default now()
);
create index if not exists leads_sale_date_idx on public.leads(sale_date);
create index if not exists leads_status_idx on public.leads(status);
create index if not exists expenses_date_idx on public.expenses(date);
create or replace function public.set_updated_at() returns trigger language plpgsql as $$ begin new.updated_at=now(); return new; end; $$;
drop trigger if exists leads_set_updated_at on public.leads;
create trigger leads_set_updated_at before update on public.leads for each row execute function public.set_updated_at();
-- PROTOTIPO: estas políticas são abertas. Não use com dados reais sem adicionar autenticação
-- e políticas RLS por usuário (auth.uid()). Nunca exponha a service_role key no frontend.
alter table public.leads enable row level security;
alter table public.expenses enable row level security;
drop policy if exists "leadflow prototype leads access" on public.leads;
create policy "leadflow prototype leads access" on public.leads for all to anon,authenticated using(true) with check(true);
drop policy if exists "leadflow prototype expenses access" on public.expenses;
create policy "leadflow prototype expenses access" on public.expenses for all to anon,authenticated using(true) with check(true);
