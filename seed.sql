insert into books
    (title)
values
    ('Big Little Lies'),
    ('Harry Potter'),
    ('Dune'),
    ('Game of Thrones 2'),
    ('Harry Potter 2'),
    ('Harry Potter 3'),
    ('Game of Thrones')
;

insert into customers
    (name, email)
values
    ('Alice', 'alice@email.com'),
    ('Bob', 'bob@email.com'),
    ('Cho', 'cho@email.com'),
    ('Daryl', 'daryl@email.com'),
    ('Emmy', 'emmy@email.com')
;

insert into sales
    (customer_id, book_id, purchase_date)
values
    (1, 1, '2020-01-01'),
    (1, 3, '2020-01-01'),
    (3, 5, '2019-12-24'),
    (5, 4, '2020-01-01'),
    (1, 2, '2019-12-12'),
    (4, 1, '2020-01-15')
;






