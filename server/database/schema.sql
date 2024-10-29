-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- Create tables
create table public.categories (
    id uuid default uuid_generate_v4() primary key,
    name text not null,
    slug text not null unique,
    description text,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

create table public.products (
    id uuid default uuid_generate_v4() primary key,
    name text not null,
    slug text not null unique,
    description text,
    price decimal(10,2) not null,
    category_id uuid references public.categories(id),
    image_url text,
    stock_quantity integer not null default 0,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

create table public.orders (
    id uuid default uuid_generate_v4() primary key,
    user_id uuid references auth.users(id),
    status text not null default 'pending',
    total_amount decimal(10,2) not null,
    shipping_address jsonb not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

create table public.order_items (
    id uuid default uuid_generate_v4() primary key,
    order_id uuid references public.orders(id),
    product_id uuid references public.products(id),
    quantity integer not null,
    price_at_time decimal(10,2) not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create RLS policies
alter table public.categories enable row level security;
alter table public.products enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;

-- Categories policies
create policy "Categories are viewable by everyone" on public.categories
    for select using (true);

-- Products policies
create policy "Products are viewable by everyone" on public.products
    for select using (true);

-- Orders policies
create policy "Users can view their own orders" on public.orders
    for select using (auth.uid() = user_id);

create policy "Users can insert their own orders" on public.orders
    for insert with check (auth.uid() = user_id);

-- Order items policies
create policy "Users can view their own order items" on public.order_items
    for select using (
        exists (
            select 1 from public.orders
            where orders.id = order_items.order_id
            and orders.user_id = auth.uid()
        )
    );

create policy "Users can insert their own order items" on public.order_items
    for insert with check (
        exists (
            select 1 from public.orders
            where orders.id = order_items.order_id
            and orders.user_id = auth.uid()
        )
    );