use sakila;

select first_name, last_name, email
from customer
join rental
using(customer_id)
join inventory
using(inventory_id)
join film
using (film_id)
join film_category
using (film_id)
join category
using (category_id)
where category.name = "Action"
group by first_name, last_name, email;


# 1. Convert the query into a simple stored procedure

drop procedure if exists customers_act;

delimiter //
create procedure customers_act
(IN category VARCHAR(255),
OUT first_name VARCHAR(255),
OUT last_name VARCHAR(255),
OUT email VARCHAR(255)
)
begin
select first_name, last_name, email
from customer
join rental
using(customer_id)
join inventory
using(inventory_id)
join film
using (film_id)
join film_category
using (film_id)
join category
using (category_id)
where category.name = category
group by first_name, last_name, email;
end;
//
delimiter ;

CALL customers_act('Action',@first_name,@last_name,@email);
SELECT @first_name,@last_name,@email;

# QUESTION: How can I make a stored procedure with multiple outcomes?

# 2. Now keep working on the previous stored procedure to make it more dynamic.
# Update the stored procedure in a such manner that it can take a string argument
# for the category name and return the results for all customers that rented movie of
# that category/genre. For eg., it could be action, animation, children, classics, etc.


drop procedure if exists customers_cat;


delimiter //
create procedure customers_cat
(IN category VARCHAR(255)
)
begin
select first_name, last_name, email
from customer
join rental
using(customer_id)
join inventory
using(inventory_id)
join film
using (film_id)
join film_category
using (film_id)
join category
using (category_id)
where category.name = category
group by first_name, last_name, email;
end;
//
delimiter ;

CALL customers_cat('Action');
CALL customers_cat('Animation');


# 3. Write a query to check the number of movies released in each movie category.
# Convert the query in to a stored procedure to filter only those categories that have
# movies released greater than a certain number. Pass that number as an argument in the
# stored procedure.

SELECT c.name AS Category, COUNT(*) AS Number_movies
FROM category c
JOIN film_category f
USING (category_id)
GROUP BY c.name;


drop procedure if exists movies_cat;


delimiter //
create procedure movies_cat
(IN no_releases INT,
OUT Category VARCHAR(255),
OUT No_movies INT
)
begin
SELECT c.name AS Category,
COUNT(*) AS Number_movies INTO No_movies
FROM category c
JOIN film_category f
USING (category_id)
GROUP BY c.name
HAVING COUNT(*) > no_releases;
end;
//
delimiter ;

CALL movies_cat(2, @Category, @No_movies);
SELECT (@Category, @No_movies);

# David's solution

drop procedure if exists CatMovies;
delimiter //
create procedure CatMovies (in num INT)
begin
	select c.name, count(*) as Movies from film_category f
	join category c using (category_id)
	group by category_id
	having Movies > num
    order by 2 asc;
end;
//
delimiter ;
call CatMovies(60);