use sakila;

# 1. Create a query or queries to extract the information you think may be relevant for building the prediction model.
# It should include some film features and some rental features.

SELECT * FROM country;

SELECT * FROM store;

SELECT * FROM address;

# Category name, city name (no country), because there are just 2 stores (300 and 576)
# number of rentals per month
# group by category
# rank with partition by country
# rank with partition by month

# Query to see the category name and the city

SELECT cat.name AS Category, c.city AS City
FROM category cat
JOIN film_category f
ON f.category_id = cat.category_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN store s
ON i.store_id = s.store_id
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id;

# Query to see the rental_date per month and year
# We join rental with the inventory_id

# create or replace view rental_activity as

select inventory_id,
date_format(convert(rental_date,date), '%m') as Activity_Month,
date_format(convert(rental_date,date), '%Y') as Activity_year
from rental;

# Two previous queries together
use sakila;
SELECT cat.name AS Category, c.city AS City,
date_format(convert(r.rental_date,date), '%m') as Activity_Month,
date_format(convert(r.rental_date,date), '%Y') as Activity_year,
COUNT(r.rental_id) AS Number_rentals
FROM category cat
JOIN film_category f
ON f.category_id = cat.category_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN store s
ON i.store_id = s.store_id
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
GROUP BY Category, City, Activity_Month, Activity_year;

# I had to group all the variables except count()
# Ranking by month and year missing