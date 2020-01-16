-- With a linking table, you can:
-- Use a subquery to get the title of books that have been purchased:
select title
from books
    where id in (select book_id from sales);

-- Use a subquery to get the title of books that have not been purchased
select title
from books
    where id not in (select book_id from sales);

-- But they also allow you to get data from multiple tables with a single query:
-- Better, get the title and purchase dates of books
select b.title, s.purchase_date
from sales s
    inner join books b
    on s.book_id = b.id;

-- Better, get the title and purchase dates of books
-- in alphabetical order of title
select b.title, s.purchase_date
from sales s
    inner join books b
    on s.book_id = b.id
order by b.title;

-- Better, get the title and purchase dates of books
-- in alphabetical order of purchase date
select b.title, s.purchase_date
from sales s
    inner join books b
    on s.book_id = b.id
order by s.purchase_date;

-- You can also join more than 2 tables:
-- Get the names of customers and the books they bought

select c.name, b.title
from sales s
    inner join customers c
    on s.customer_id = c.id
        inner join books b
        on s.book_id = b.id;


-- How to write a join for two tables:
-- 1. write down the name of the two tables you want to join into a single "temporary" table
-- 2. give them aliases (not required, but common practice)
-- 3. specify how they're linked
-- 4. select the column names, using the table aliases

-- To add a third table to the join:
-- 5. write down the name of the third table
-- 6. give it an alias
-- 7. specify how it's linked to either of the first two tables
-- 8. add columns from the third table to the select
