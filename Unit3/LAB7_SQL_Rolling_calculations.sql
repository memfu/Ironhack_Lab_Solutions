use sakila;

# 1. Get number of monthly active customers.

# Data I need: customer_id, months

SELECT * FROM rental;

# Get for each customer the date, month and year
create or replace view cust_activity as
select customer_id, convert(rental_date, date) as Activity_date,
date_format(convert(rental_date,date), '%m') as Activity_Month,
date_format(convert(rental_date,date), '%Y') as Activity_year
from rental;

# Get for each year and month, how many unique users rented movies.
create or replace view monthly_act_cust as
select Activity_year, Activity_Month, count(distinct customer_id) as Active_customers 
from cust_activity
group by Activity_year, Activity_Month
order by Activity_year, Activity_Month;

# 2. Active users in the previous month.

# Get the same table again with another column showing the number of active users in the previous month
with cte_activity as (
  select Activity_year, Activity_Month, Active_customers, lag(Active_customers,1) over (partition by Activity_year) as previous_month 
  from monthly_act_cust
)
select * from cte_activity
where previous_month is not null;

# 3. Percentage change in the number of active customers.
create or replace view perc_view as
with cte_percentage as (
select Activity_year, Activity_Month, Active_customers,
lag(Active_customers,1) over (partition by Activity_year) as previous_month
FROM monthly_act_cust)
select * from cte_percentage
where previous_month is not null;

select *,
round((((Active_customers - previous_month) / previous_month) *100), 2) as percchange
from perc_view;


# 4. Retained customers every month.

# Get which "Active customers" where still active the next month.
with distinct_cust as (
  select distinct customer_id , Activity_Month, Activity_year
  from cust_activity
)
select d1.Activity_year, d1.Activity_Month, count(distinct d1.customer_id) as Retained_customers
from distinct_cust d1
join distinct_cust d2
on d1.customer_id = d2.customer_id and d1.activity_Month = d2.activity_Month + 1
group by d1.Activity_Month, d1.Activity_year
order by d1.Activity_year, d1.Activity_Month;
