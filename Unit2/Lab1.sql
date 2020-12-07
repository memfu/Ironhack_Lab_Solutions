SELECT * FROM sakila.actor;
SELECT * FROM sakila.address;
SELECT * FROM sakila.category;
SELECT * FROM sakila.city;
SELECT * FROM sakila.country;
SELECT * FROM sakila.customer;
SELECT * FROM sakila.film;
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.film_text;
SELECT * FROM sakila.inventory;

SELECT * FROM sakila.film;

SELECT title, language_id from sakila.film;

SELECT sakila.film.title, sakila.language.name from sakila.film
INNER JOIN sakila.language on sakila.film.language_id=sakila.language.language_id;

SELECT COUNT(store_id) AS Number_of_Stores FROM sakila.store;

SELECT * FROM sakila.store;

SELECT count(staff_id) AS NumberofEmployees FROM sakila.staff;

SELECT * FROM sakila.staff;

SELECT first_name FROM sakila.staff;

# Lab SQL 2

# Right clicking on the schema I can set a schema as a default, so I don't have to specify the db everytime

SELECT * FROM sakila.actor
WHERE first_name = 'Scarlett';

SELECT * FROM sakila.actor
WHERE last_name = 'Johansson';

SELECT COUNT(inventory_id) FROM sakila.inventory;

SELECT DISTINCT count(rental_id) FROM sakila.rental;

SELECT DISTINCT datediff(return_date, rental_date) AS Rental_days
FROM sakila.rental;

SELECT min(rental_duration), max(rental_duration)
FROM sakila.film;

SELECT min(length) AS Min_duration, max(length) AS Max_duration
FROM sakila.film;

SELECT avg(length) AS Average_duration
FROM sakila.film;

SELECT from_unixtime(avg(length), '%m:%s') as Average_duration
FROM sakila.film;

SELECT avg(length) DIV 60 as Hours, avg(length) % 60 as Minutes
FROM sakila.film;

SELECT DISTINCT length FROM sakila.film;

SELECT count(film_id) FROM sakila.film
WHERE length > 180;

SELECT * from sakila.customer
LIMIT 10;

SELECT Concat(substring(first_name,1,1), lower(substring(first_name,2,100))) AS first_name, 
last_name,
lower(email) AS email
from sakila.customer;

SELECT max(length(title)) AS longest_title FROM sakila.film;

SELECT DISTINCT length(title) AS length FROM sakila.film
ORDER BY length(title);

SELECT Concat(substring(first_name,1,1), lower(substring(first_name,2,length(first_name)))) AS first_name, 
last_name,
lower(email) AS email
from sakila.customer;

SELECT Concat(
			Concat(substring(first_name,1,1),
            lower(substring(first_name,2,length(first_name)))), 
' ', last_name, ' - ',
lower(email)) AS Customer_email
from sakila.customer;