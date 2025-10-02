-- subquery

-- 1. Write a query to find the name (first_name, last_name)
-- and the salary of the employees who have a higher salary than the
-- employee whose last_name='Bull'.


select concat(first_name,' ', last_name) as full_name, salary from employees
where salary  > (select salary from employees where last_name = 'Bull');


-- 2. Write a query to find the name (first_name, last_name) of all employees
--  who works in the IT department.


select concat(first_name,' ', last_name) as full_name from employees
where department_id = (select department_name from departments where department_name LIKE 'IT');

-- 3. Write a query to find the name (first_name, last_name) of the employees who have a manager
-- and worked in a USA based department. 

use hr;
select concat(first_name,' ', last_name) as full_name from employees
where manager_id is not null and
department_id in (select d.department_id from departments d
join locations l on d.location_id = l.location_id join countries c on l.country_id = c.country_id
where c.country_name = 'United States of America');


select * from countries;


