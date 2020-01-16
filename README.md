
# Many-to-Many relationships

You may create tables that are related, but cannot be described in terms of "has one", "belongs to", or "has many".

Imagine a bookstore. It has books and it has customers. Any single customer can purchase multiple books. Any book can be purchased by multiple customers.

You do not use a foreign key to capture this kind of relationship. Instead, you will use a "linking table". Linking tables do not need a primary key. Their purpose is to record the IDs from two (or more) other tables.

Here is an example of the data in the `books` table:

| id |	title |
| -- |	-- |
| 1  |	Big Little Lies |
| 2  |	Harry Potter |
| 3  |	Dune |
| 4  |	Harry Potter 2 |
| 5  |	Harry Potter 3 |

And here is the data that might be in the `customers` table:

| id | name	    | email |
| -- | ----	    | ----  |
| 1  | Alice	| alice@email.com   |
| 2  | Bob	    | bob@email.com |
| 3  | Cho	    | cho@email.com |


We might create a third table that records the book id and the customer id when a purchase is made:

| customer_id   |	book_id |	purchase_date   |
| ---   |	--- |	---   |
| 1             |	1       |	2020-01-01      |
| 1             |	3       |	2020-01-01      |
| 3             |	5       |	2019-12-24      |
| 2             |	4       |	2020-01-01      |
| 1             |	2       |	2019-12-12      |
| 3             |	1       |	2020-01-15      |

## The schema

You can create these tables with the following SQL statements:

```sql
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
```

## Getting information about books purchased

Since the `sales` table only contains the IDs of books that have been purchased, you can use a subquery to get those IDs.

This way you can get the title of books whose IDs are in the sales table.

```sql
select title
from books
    where id in (select book_id from sales);
```

Using the `not` keyword, you can find books that no one has purchased:

```sql
select title
from books
    where id not in (select book_id from sales);
```

Subqueries can include `where` clauses. Here is a query that gets the title of books sold after 2019:

```sql
select title
from books
    where id in (select book_id from sales where purchase_date > '2019-12-31');
```

### Checkpoint

- Write a query to find out which customers have purchased a book.
- Write a query to find out which customers purchased a book last year.

## Getting information about customers and the books they purchased

Linking tables allow you to combine the information in two tables. You can then query resulting "temporary" table.

To combine tables into a temporary table, begin by writing the names of the two tables:

```sql
sales
books
```

Add the keywords `from` and `inner join`:

```sql
from sales
inner join books
```

Give the tables aliases: 

```sql
from sales s
inner join books b
```

(Though not required, it is a common practice.)

Specify how the tables are related (using the alias):

```sql
from sales s
inner join books b
on s.book_id = b.id
```

This creates a unified virtual table that you can `select` from:

```sql
select b.title, s.purchase_date
from sales s
inner join books b
on s.book_id = b.id;
```

Note the use of table aliases when writing the column names.

As with subqueries, you can add `where` clauses or `order by`:

```sql
select b.title, s.purchase_date
from sales s
inner join books b
on s.book_id = b.id
order by b.title; -- sort alphabetically by book title
```

```sql
select b.title, s.purchase_date
from sales s
inner join books b
on s.book_id = b.id
order by s.purchase_date; -- sort by purchase date
```

### Checkpoint

- Use the `inner join` syntax to get the names of customers who purchased a book.
- Use the `inner join` syntax to get the name and email of the customer who made the most recent purchase.

## Combining three tables

You can `join` a third table onto the temporary table.

Write down the name of the third table

```sql
select b.title, s.purchase_date
from sales s
inner join books b
on s.book_id = b.id

customers
```

Add the `inner join` keywords:

```sql
select b.title, s.purchase_date
from sales s
inner join books b
on s.book_id = b.id

inner join customers
```

Give the table an alias:

```sql
select b.title, s.purchase_date
from sales s
inner join books b
on s.book_id = b.id

inner join customers c
```


Specify how the third table is related to any of the other tables:


```sql
select b.title, s.purchase_date
from sales s
inner join books b
on s.book_id = b.id

inner join customers c
on s.customer_id = c.id;
```

Add columns from the third table to the `select`:

```sql
select c.name, b.title, s.purchase_date
from sales s
inner join books b
on s.book_id = b.id

inner join customers c
on s.customer_id = c.id;
```
