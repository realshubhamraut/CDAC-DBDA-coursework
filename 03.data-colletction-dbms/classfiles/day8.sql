use hr;

select count(employee_id) no_emp, sum(salary) sum_sal,
min(salary) min_sal,
max(salary) max_sal,
avg(salary), department_id
from employees
group by department_id;


select count(employee_id) no_emp, department_id from employees
group by deparment_id;

use northwind;

select * from orders;

select count(order_id), order_date from orders
group by order_date;


select * from suppliers;

show tables;

select * from categories;

select order_date from orders 
group by order_date;

use hr;


-- no of empl hired for particular year
select * from employees;


select count(employee_id), year(hire_date) as hire_year from employees
group by year(hire_date);

use northwind;

-- find 

select count(*), year(order_date) from orders
group by year(order_date);

use northwind;


select region, count(*) as no_of from customers
group by region
-- having no_of >=6
order by no_of desc;

select (freight) from orders
order by freight desc
limit 5;


select * from orders;


select * from orders;


select region, count(*) as no_of from customers
where region is not null
group by region
having no_of>=6
order by no_of desc;



select * from orders;
-- employees handling orders more than 40

select employee_id, count(employee_id) as total from orders
group by employee_id
HAVING total > 30;


-- 
use northwind;
select * from products;

select count(product_id) as prd, supplier_id from products
group by supplier_id
having prd > 3;



SELECT * from orders;


SELECT ship_city from orders
group by ship_city;





-- 


select count(customer_id), order_id from orders
group by customer_id;


SELECT MAX(order_date) as max_order, min(order_date) as min_order from orders
