use sakila;

# 1. Get film ratings.

SELECT DISTINCT rating FROM film;

# 2. Get release years.

SELECT DISTINCT release_year FROM film;

# 3. Get all films with ARMAGEDDON in the title.

SELECT title FROM film
WHERE title LIKE '%armageddon%';

# 4. Get all films with APOLLO in the title
SELECT title FROM film
WHERE title LIKE '%apollo%';

# 5. Get all films which title ends with APOLLO.
SELECT title FROM film
WHERE title LIKE '%apollo';

# 6. Get all films with word DATE in the title.
SELECT title FROM film
WHERE title REGEXP '[[:space:]]date[[:space:]]';
# This doesn't return anything because neither the films starting nor ending with date will appear


SELECT title FROM film
WHERE title REGEXP '[[:space:]]date';
# This works: all films ending with ' date'

SELECT title FROM film
WHERE title REGEXP '^date[[:space:]]';
# This works: ^ indicates the beginning of the string

SELECT title FROM film
WHERE title LIKE '%date%';

# Solution - Space is [[:space:]]
SELECT title FROM film
WHERE title REGEXP '[[:space:]]date[[:space:]]' OR
title REGEXP '[[:space:]]date' OR
title REGEXP '^date[[:space:]]';

# 7. Get 10 films with the longest title.
SELECT title, LENGTH(title) AS longest_title
FROM film
ORDER BY longest_title DESC
LIMIT 10;

# 8. Get 10 the longest films.
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;

# 9. How many films include Behind the Scenes content?
SELECT COUNT(*)
FROM film
WHERE special_features IN ('Behind the Scenes');

# 10. List films ordered by release year and title in alphabetical order.
SELECT title, release_year FROM film
ORDER BY 1 ASC, 2 DESC;