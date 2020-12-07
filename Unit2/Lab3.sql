# 1. How many distinct (different) actors' last names are there?

SELECT DISTINCT last_name, COUNT(last_name) AS number FROM sakila.actor
GROUP BY last_name;

# 2. In how many different languages where the films originally produced?
# (Use the column language_id from the film table)

use sakila;

SELECT * FROM film;

SELECT DISTINCT language_id, COUNT(language_id) FROM film
GROUP BY language_id;

# 3. How many movies were released with "PG-13" rating?

SELECT COUNT(*) FROM film
WHERE rating = 'PG-13';

# 4. Get 10 the longest movies from 2006.
SELECT title, length FROM film
WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10;

# 5. How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(max(return_date), min(rental_date)) AS operating_days
FROM rental;

# 6. Show rental info with additional columns month and weekday. Get 20.
SELECT rental_id,
rental_date,
DATE_FORMAT(rental_date, '%M') AS month,
DATE_FORMAT(rental_date, '%W') AS weekday
FROM rental
LIMIT 20;

# 7. Add an additional column day_type with values 'weekend' and 'workday'
# depending on the rental day of the week.

SELECT rental_id,
rental_date,
DATE_FORMAT(rental_date, '%M') AS month,
DATE_FORMAT(rental_date, '%W') AS weekday,
CASE
WHEN DATE_FORMAT(rental_date, '%W') = 'Saturday' THEN 'weekend'
WHEN DATE_FORMAT(rental_date, '%W') = 'Sunday' THEN 'weekend'
ELSE 'workday'
END AS day_type
FROM rental;

use sakila;
# 8. How many rentals were in the last month of activity?
SELECT year(rental_date), month(rental_date), COUNT(*) FROM rental
GROUP BY rental_date
ORDER BY 1 DESC, 2 DESC
LIMIT 1;
