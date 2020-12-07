use sakila;

# LAB - SQL Join

# 1. List number of films per category.
SELECT c.name AS Category, Count(f.film_id) AS Count
from category c
left join film_category f
on c.category_id = f.category_id
group by c.name
order by Count;

# inner and left join show the same result

# 2. Display the first and last names,
# as well as the address, of each staff member.

SELECT s.first_name AS First_name, s.last_name AS Last_name, a.address AS Address
FROM staff s
JOIN address a
on s.address_id = a.address_id;

# 3. Display the total amount rung up by each staff member in August of 2005.

SELECT * FROM payment;

SELECT s.first_name AS First_name, s.last_name AS Last_name,
SUM(p.amount) AS Sum
FROM staff s
JOIN payment p
on s.staff_id = p.staff_id
WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) = 08
group by s.staff_id;

# I don't need to select the staff_id, I can just group by


# 4. List each film and the number of actors who are listed for that film.
SELECT f.title AS Title, COUNT(a.actor_id) AS Number_actors
FROM film f
left JOIN film_actor a
on f.film_id = a.film_id
group by f.title;

# 5. Using the tables payment and customer and the JOIN command,
# list the total paid by each customer.
# List the customers alphabetically by last name.

SELECT c.first_name, c.last_name, SUM(p.amount)
FROM customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by c.last_name;


# LAB SQL Joins on multiple tables

# 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id AS Store_id, c.city AS City, d.country AS Country
FROM store s
join address a
on s.address_id = a.address_id
join city c
on c.city_id = a.city_id
join country d
on c.country_id = d.country_id;

# 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id AS Store_id, SUM(p.amount) AS Sum
FROM store s
join staff st
on s.store_id = st.store_id
join payment p
on st.staff_id = p.staff_id
group by s.store_id;

# 3. What is the average running time of films by category?
SELECT c.name AS Category, round(AVG(f.length), 2) AS Average_length
FROM category c
join film_category fc
on c.category_id = fc.category_id
join film f
on f.film_id = fc.film_id
group by c.name;

# 4. Which film categories are longest?
SELECT 
    c.name AS Category,
    ROUND(AVG(f.length), 2) AS Average_length
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY Average_length DESC;


# 5. Display the most frequently rented movies in descending order.
SELECT f.title AS Title, COUNT(r.rental_id) AS Frequency
FROM film f
join inventory i
on f.film_id = i.inventory_id
join rental r
on r.inventory_id = i.inventory_id
group by Title
order by Frequency DESC;

# 6. List the top five genres in gross revenue in descending order.
SELECT c.name AS Category, SUM(p.amount) AS Revenue
FROM category c
join film_category fc
on c.category_id = fc.category_id
join inventory i
on i.film_id = fc.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by Category
order by Revenue DESC
LIMIT 5;

# 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, s.store_id
FROM store s
join inventory i
on s.store_id = i.store_id
join film f
on i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;


