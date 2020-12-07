use sakila;

# 1. Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT c.first_name, c.last_name, c.email
from customer c
inner join rental r
using (customer_id)
group by c.customer_id;

# inner join and left join have the same results


# 2. What is the average payment made by each customer (display the customer id, customer name (concatenated),
# and the average payment made).
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Name, ROUND(AVG(p.amount),2) AS Average_payment
FROM customer c
join payment p
using (customer_id)
group by c.customer_id;

# 3. Select the name and email address of all the customers who have rented the "Action" movies.

# 3.a. Write the query using multiple join statements

SELECT CONCAT(c.first_name, ' ', c.last_name) AS Name, c.email AS Email
FROM customer c
join rental r
using (customer_id)
join inventory i
using (inventory_id)
join film_category fc
using (film_id)
join category ct
using (category_id)
WHERE ct.name = 'Action'
group by c.customer_id;
# 3.b. Write the query using sub queries with multiple WHERE clause and IN condition
SELECT 
    CONCAT(first_name, ' ', last_name) AS Name, email AS Email
FROM
    customer
WHERE
	customer_id IN (SELECT 
            customer_id
        FROM
            rental
        WHERE
            inventory_id IN (SELECT 
                    inventory_id
                FROM
                    inventory
                WHERE
                    film_id IN (SELECT 
                            film_id
                        FROM
                            film_category
                        WHERE
                            category_id IN (SELECT 
                                    category_id
                                FROM
                                    category
                                WHERE
                                    name = 'Action'))));

# 3.c. Verify if the above two queries produce the same results or not
# Both queries have the same results


# 4. Use the case statement to create a new column classifying existing columns as either or high value transactions
# based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4,
# the label should be medium, and if it is more than 4, then it should be high.

SELECT customer_id, amount AS Amount,
CASE
WHEN amount BETWEEN 0 AND 2 THEN 'Low'
WHEN amount BETWEEN 2 AND 4 THEN 'Medium'
WHEN amount > 4 THEN 'High'
END AS Classification
FROM payment;


