-- Group by - Having - condtional - intermediate level



-- QUESTION 1: Employee Order Count by Year
-- Business Scenario: Count how many orders each employee handled per year.
-- Requirements: Show employee order counts for each year (1997-1998). Include only employees who processed more than 10 orders per year.
-- Categorize employees as 'High Volume' (>30 orders), 'Medium Volume' (15-30 orders), or 'Low Volume' (<15 orders).
-- Expected Output: employee_id, order_year, total_orders, avg_freight, employee_category

select o.employee_id, concat(e.first_name, ' ', e.last_name) as full_name, year(o.order_date) as order_year,
count(o.order_id) as total_orders,
AVG(o.freight) as avg_freight,
CASE 
when count(o.order_id) > 30 then 'high volume'
when count(o.order_id) BETWEEN 15 and 30 then 'median volume'
else 'low volume'
end as emp_cat





from orders o
join employees e on o.employee_id = e.employee_id
where year(o.order_date) between 1997 and 1998
group by o.employee_id, full_name, year(o.order_date)
having count(o.order_id) > 10
order by order_year, total_orders desc;

-- Business Scenario: Analyze customer ordering patterns by month.
-- Requirements: Show customer order counts by month for 1997. Include only customers with more than
-- orders per month and average freight above $15. Classify months as 'High Season' (Dec-Feb), 'Medium Season'
-- (Mar-May, Sep-Nov), or 'Low Season' (Jun-Aug).
-- Expected Output: customer_id, order_month, month_name, total_orders, avg_freight, season_type




-- select customer_id, month(order_year);


-- use northwind;

select customer_id, order_id, order_date, freight
from orders
where year(order_date) = 1998
limit 20;

select customer_id, order_id, order_date, month(order_date) as order_month,
monthname(order_date) as month_name
from orders
where year (order_date)  = 1997
limit 20;



SELECT
  o.customer_id,
  MONTH(o.order_date)    AS order_month,
  MONTHNAME(o.order_date) AS month_name,
  COUNT(o.order_id)      AS total_orders,
  AVG(o.freight)         AS avg_freight,
  CASE
    WHEN MONTH(o.order_date) IN (12,1,2) THEN 'High Season'
    WHEN MONTH(o.order_date) IN (3,4,5,9,10,11) THEN 'Medium Season'
    ELSE 'Low Season'
  END AS season_type
FROM orders o
WHERE o.order_date IS NOT NULL
  AND YEAR(o.order_date) = 1997
GROUP BY
  o.customer_id,
  MONTH(o.order_date),
  MONTHNAME(o.order_date)
HAVING
  COUNT(o.order_id) > 2
  AND AVG(o.freight) > 15
ORDER BY order_month, total_orders DESC;








