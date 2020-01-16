create table books (
    id serial primary key,
    title text
);

create table customers (
    id serial primary key,
    name text,
    email text
);

create table sales (
    book_id integer references books (id),
    customer_id integer references customers (id),
    purchase_date date
);