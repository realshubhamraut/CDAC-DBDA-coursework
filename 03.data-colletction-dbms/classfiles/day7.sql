select * from employees;
select * from countries;
select * from departments;
select * from jobs;
select * from locations;
select * from regions;


select e.employee_id, e.first_name, e.last_name, j.job_title from employees e
join jobs j on e.job_id = j.job_id;

-- 3 table join

-- full_name, employee, city


select concat(first_name, ' ', last_name) as full_name, j.job_title, c.country_name, r.region_name, l.city from employees e
join departments d on e.department_id = d.department_id 
join locations l on  l.location_id = d.location_id
join countries c on c.country_id =l.country_id
join regions r on r.region_id = c.region_id
join jobs j on j.job_id = e.job_id;





-- write a query to display dept_id and no of distinct(locations)

select d.department_id, count(distinct(l.city)) from departments d
join locations l on l.location_id = d.location_id
group by d.department_id;


select l.location_id, count(distinct d.department_id) as num_departments
from locations l
join departments d on l.location_id = d.location_id
group by l.location_id;



-- write a query to find distinct dept where employees work

select distinct(d.department_id), d.department_name, count(e.employee_id) as n_em from employees e
join departments d on d.department_id = e.department_id
WHERE e.department_id is not null
group by e.department_id, d.department_name
order by n_em;


-- no of emp working in each countires that has > 15 emp


select count(e.employee_id) as emp_count, c.country_name from employees e
join departments d on d.department_id = e.department_id
join locations l on l.location_id = d.location_id
join countries c on c.country_id = l.country_id
group by c.country_name
having emp_count > 15;



-- find the employees by their emp name, job id, job title, department_id, where department id are either 90 30 40 or 100

select concat(first_name, ' ', last_name) as full_name, e.job_id, j.job_title, d.department_id from employees e
join departments d on d.department_id = e.department_id
join jobs j on j.job_id = e.job_id
WHERE d.department_id in (30,90,40,100);


select * from department_jn;

use hr;
-- 
select e.*, d.* from employees e
left join departments d on e.department_id = d.department_id;
-- 



-- employees who have never handled any order

show tables;
select * from orders;


select e.employee_id, concat(e.first_name,' ', e.last_name)as full_name, e.title from employees e
left join orders o on e.employee_id = o.employee_id
where o.employee_id is null
group by e.employee_id;


-- display all the products with category information ensuring all products are shown even if category data is missing


select * from products;
select * from categories;


select product_id,  product_name, category_name from products p
left join categories c on p.category_id = c.category_id;


-- subquery

select first_name, department_id from employees
where department_id = (select department_id from departments where department_id =90);


-- need to find employees who earns maximum salary

select concat(first_name,' ', last_name) as full_name, job_id, salary from employees
where salary = (select max(salary) from employees);

select concat(first_name,' ', last_name) as full_name, job_id, max(salary)from employees;

select * from employees;

-- find the employees with same job and salary where emp_id = 100

SELECT concat(first_name,' ', last_name) as full_name, job_id, salary from employees e
where (job_id, salary) in (select job_id, salary from employees where employee_id = 102);

-- third highest payed employee


select concat(first_name,' ', last_name) as full_name, salary from employees
where salary = (select salary from employees
order by salary desc limit 1 offset 2);

select max(salary) from employees where salary

order by salary desc;


use northwind;
select * from orders;
show tables;

-- find the customer who have placed atleast one order


select concat(first_name,' ', last_name), count(order_id) as full_name from customers c
join orders o on o.customer_id = c.customer_id
group by order_id
having count(order_id) > 1;
select * from orders;


use northwind;
SELECT c.customer_id,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >= 1;


-- find all employees working in department located in the regions = americas

use hr;

select * from regions;

select department_id, region_name from departments d
join locations l on l.location_id = d.location_id
join countries c on c.country_id = l.country_id
join regions r on r.region_id = c.region_id
WHERE region_name = 'A';


select employee_id, first_name, salary from employees where salary>= all (select salary from employees);

-- find a department where all employees earn more than 5000


select department_id, d.department_name from departments d
where d.department_id in(
select e.department_id from employees e
where e.salary >= 5000);


















select department_id, d.department_name from departments d
where department_id in(select department_id from employees
where salary > 15000);


use northwind;

-- find product which has same supplier and category as product chai

select * from categories;


select product_name, supplier_id from products
where supplier_id in (select supplier_id from products
WHERE product_name = 'chai')
and product_name != 'chai';


SELECT product_name, supplier_id, category_id
FROM products
WHERE (supplier_id, category_id) IN (
    SELECT supplier_id, category_id
    FROM products
    WHERE product_name = 'Chai'
);

use hr;
select first_name, salary, department_id from employees
where department_id > any(select department_id from departments where department_name = 'Executive');

select first_name , department_id from employees where department_id = any(90,70,2000);

select first_name, salary from employees where job_id = 'IT_PROG';




