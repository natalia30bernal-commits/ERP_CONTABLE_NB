-- ERP CONTABLE NB - Supabase schema inicial

create table if not exists clientes (
  id uuid primary key default gen_random_uuid(),
  razon_social text not null,
  nit text unique,
  dv text,
  representante_legal text,
  ciudad text,
  departamento text,
  telefono text,
  correo text,
  regimen_tributario text,
  clasificacion text[] default '{}',
  estado text default 'Activo',
  created_at timestamp with time zone default now()
);

create table if not exists cuentas_cobro (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references clientes(id) on delete set null,
  numero text unique not null,
  concepto text,
  periodo text,
  fecha_emision date,
  fecha_vencimiento date,
  valor_bruto numeric default 0,
  retefuente numeric default 0,
  reteica numeric default 0,
  valor_neto numeric default 0,
  estado text default 'Generada',
  pdf_url text,
  created_at timestamp with time zone default now()
);

create table if not exists ingresos_personales (
  id uuid primary key default gen_random_uuid(),
  cuenta_cobro_id uuid references cuentas_cobro(id) on delete set null,
  cliente_id uuid references clientes(id) on delete set null,
  fecha date,
  concepto text,
  valor_bruto numeric default 0,
  retenciones numeric default 0,
  valor_neto numeric default 0,
  estado text default 'Ingreso Pendiente',
  created_at timestamp with time zone default now()
);

create table if not exists tareas (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references clientes(id) on delete set null,
  titulo text not null,
  descripcion text,
  fecha_limite date,
  prioridad text default 'Media',
  estado text default 'Pendiente',
  created_at timestamp with time zone default now()
);

create table if not exists reuniones (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references clientes(id) on delete set null,
  titulo text not null,
  fecha date,
  hora text,
  modalidad text,
  estado text default 'Programada',
  observaciones text,
  created_at timestamp with time zone default now()
);

create table if not exists historial_cliente (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references clientes(id) on delete cascade,
  tipo_actividad text,
  descripcion text,
  modulo_origen text,
  estado text,
  created_at timestamp with time zone default now()
);
