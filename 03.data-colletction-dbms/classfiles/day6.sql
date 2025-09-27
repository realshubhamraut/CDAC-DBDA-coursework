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



use northwind;

show tables;

select * from products;

select case
when unit_price < 10 then 'low budget product'
when unit_price > 10  and unit_price < 80 then 'mid budget product'
when unit_price >80 then 'high budget product'
end as price_cat, count(*) as product_c, avg(units_in_stock) as avg_s from products
group by price_cat;


select * from products;


-- 
SELECT case
when discount <= 0.05 then 'low discount'
when discount >=0.06 and discount <= 0.10 then 'mid discount'
when discount >=0.11 and discount <=0.20 then 'high discount'
when discount >=0.21 and discount <= 0.50 then 'huge discount'
when discount >= 0.51 then 'bumper discount'
end as dis_cat, count(*) as ord_c from order_details group by dis_cat;


SELECT case
when timestampdiff(day,order_date, shipped_date)<=3 then 'fast'
when timestampdiff(day, order_date, shipped_date)<=5 then 'normal'
when timestampdiff(day, order_date, shipped_date)>=5 then 'delay'
end as processing_speed, count(order_id) as count_order
from orders
WHERE shipped_date is not null
group by processing_speed
order by count_order desc;


select count(customer_id), order_id from orders
group by customer_id;


SELECT MAX(order_date) as max_order, min(order_date) as min_order from orders;




create database try_join;

use try_join;

CREATE TABLE Department_jn (
    dept_id INT PRIMARY KEY,
    manager_id INT,
    department_name VARCHAR(50)
);

CREATE TABLE Employee_jn (
    emp_id INT PRIMARY KEY,
    e_name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department_jn(dept_id));



INSERT INTO Department_jn (dept_id, manager_id, department_name) 
VALUES
    (1, 101, 'Engineering'),
    (2, 102, 'Sales'),
    (3, 103, 'Marketing'),
    (4, 104, 'Other');


INSERT INTO Employee_jn (emp_id, e_name, salary, department_id) 
VALUES
    (201, 'John Doe', 60000.00, 1),
    (202, 'Jane Smith', 55000.00, 1),
    (203, 'Michael Johnson', 62000.00, 2),
    (204, 'Emily Davis', 58000.00, 2),
    (205, 'Chris Brown', 63000.00, 3),
    (206, 'Amanda Wilson', 60000.00, 3);

insert into employee_jn(emp_id,e_name,salary) values(207,'Jane Doe',90989),
(208,'Brown Wilson',90011);





show tables;

select * from department_jn;
select * from employee_jn;

select * from department_jn
JOIN employee_jn using dept_id;


select * from department_jn dj join empolyee_jn ej using (dept_id);



select emp_id, e_name, salary, department_id from employee_jn e
join department_jn d on e.department_id = d.dept_id;


use hr;


show tables;

SELECT * from jobs;
select * from job_history;

select * from jobs jb
join job_history jh on jb.job_id = jh.job_id;


select * from employees e
join departments m on e.MANAGER_ID = m.manager_id;


SELECT * FROM jobs jb
JOIN job_history jh USING (job_id);

show tables;

select first_name, last_name, d.department_id from employees e
join departments d
on e.department_id = d.department_id;

select * from employees;

select * from jobs;


select concat(first_name,' ' ,last_name) full_name, j.job_id, j.job_title from employees e
join jobs j on e.job_id = j.job_id
where j.job_id in ('AD_VP', 'AD_pres');


-- find the employees along with the department name where the salary is in the range of 5000 to 50000
show tables;

select * from departments;
select concat(first_name,' ',last_name), salary, department_name from employees e
join departments d on d.department_id = e.department_id
WHERE salary BETWEEN 5000 and 50000;

use hr;
use northwind;
select * from categories;

select * from products;

select c.category_name, avg(unit_price) as avg_u from products p
join categories c on p.category_id = c.category_id
group by category_name;



-- for emp and ord table employees handling no of orders
desc orders;
desc employees;

use northwind;

select concat(first_name,' ', last_name) as full_name, count(distinct(order_id)) from employees e
join orders o on e.employee_id = o.employee_id
group by full_name;

