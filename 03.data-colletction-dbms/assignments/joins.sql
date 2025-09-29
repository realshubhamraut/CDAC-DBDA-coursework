select * from employees;
select * from countries;
select * from departments;
select * from jobs;
select * from locations;
select * from regions;


-- 1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
use hr;

SELECT d.department_id, l.location_id, l.street_address, l.city, l.state_province, c.country_name from departments d
join locations l on l.location_id = d.location_id
join countries c on c.country_id = l.country_id; 


-- 2. Write a query to find the name (first_name, last name), department ID and name of all the employees

select concat(first_name, ' ', last_name) as full_name, d.department_id, department_name from employees e
join departments d on d.department_id = e.department_id;


-- 3. Write a query to find the name (first_name, last_name), job, department ID and name of the employees who works in London.

select * from employees;



select first_name, last_name, j.job_id, d.department_id from employees e
join departments d on d.department_id = e.department_id 
join jobs j on j.job_id = e.job_id
join locations l on l.location_id = d.location_id
where l.city = 'London';
 
-- 4. Write a query to find the employee id, name (last_name) along with their manager_id and name (last_name).

SELECT e.employee_id, e.last_name AS employee_name, e.manager_id, m.last_name AS manager_name FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 5. Write a query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'.

SELECT concat(first_name,' ', last_name) as full_name, hire_date from employees
WHERE hire_date > (select hire_date from employees where last_name = 'Jones');

-- 6. Write a query to get the department name and number of employees in the department.
select d.department_name, count(e.employee_id) from employees e
join departments d on e.department_id = d.department_id
group by d.department_name;

-- 7. Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90.

select e.employee_id, j.job_title, datediff(jh.end_date, jh.start_date) as days_worked from employees e
join jobs j on j.job_id = e.job_id
join job_history jh on j.job_id = jh.job_id;

-- 8. Write a query to display the department ID and name and first name of manager.


select d.department_id, e.first_name from departments d
join employees e on d.department_id = e.department_id;


-- 9. Write a query to display the department name, manager name, and city
select d.department_name, concat(e.first_name, ' ', e.last_name) as manager_name, l.city
from departments d
join locations l on l.location_id = d.location_id
join countries c on c.country_id = l.country_id
join employees e on d.manager_id = e.employee_id;


-- 10. Write a query to display the job title and average salary of employees.

select j.job_title, avg(e.salary) as avg_sal  from employees e
join jobs j on j.job_id = e.job_id
group by j.job_title;



-- 10. Write a query to display the job title and average salary of employees.
select j.job_title, avg(e.salary) as avg_sal
from employees e
join jobs j on j.job_id = e.job_id
group by j.job_title;

-- 11. Write a query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.

select job_title, concat(first_name,' ', last_name) as full_name, e.salary - j.min_salary as sal_diff from employees e
join jobs j on  j.job_id = e.job_id;

-- 12. Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.

select jh.employee_id, j.job_title, jh.start_date, jh.end_date, jh.department_id, e.salary from job_history jh
join employees e on jh. employee_id  = e.employee_id
join jobs j on jh.job_id = j.job_id
where e.salary > 10000;


-- 13. Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.

select d.department_name, concat(e.first_name,' ', last_name), e.hire_date, e.salary from departments d
join employees e on d.manager_id = e.employee_id
where timestampdiff(year, e.hire_date, curdate()) > 15;
show tables;

