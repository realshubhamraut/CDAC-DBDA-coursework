
use hr;
show tables;

-- 1. Write a SQL query to find the number of employees hired in each year.

select employee_id, concat(first_name, ' ' last_name) as full_name, year(hire_date) from employees
order by hire_date;


-- 2. Write a SQL query to find the number of employees in each department.

select * from employees;

select department_id, count(employee_id) from employees
group by department_id;

-- 3. Write a SQL query to find the department with the highest total salary.

select SUM(salary) as total_sal, department_id from employees
group by department_id
ORDER BY total_sal desc
limit 1;

-- 4.  Write a query to list the number of jobs available in the employees table.

select count(distinct(job_id)) from employees;


-- 5. Write a query to get the total salaries payable to employees.

SELECT sum(salary) from employees;


-- 6. Write a query to get the minimum salary from the employees table.

select min(salary) from employees;

-- 7. Write a query to get the maximum salary of an employee working as a Programmer. 

SELECT max(salary) from employees
WHERE job_id = 'IT_PROG';


-- 8 . Write a query to get the average salary and number of employees working the department 90. 

SELECT AVG(salary) as avg_sal, count(*) as num_employees from employees
where department_id = 90;

-- 9. Write a query to get the highest, lowest, sum, and average salary of all employees. 

SELECT MAX(salary), MIN(salary), sum(salary), AVG(salary) from employees;

-- 10. Write a query to get the number of employees with the same job


select count(employee_id), job_id from employees
group by(job_id);


-- 11. Write a query to get the difference between the highest and lowest salaries. 

select max(salary) - min(salary)  as diff from employees;

-- 12. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager. 

select * from employees;


SELECT manager_id, min(salary) from employees
group by manager_id;

-- 13. Write a query to get the department ID and the total salary payable in each department.

SELECT department_id, sum(salary) from employees
group by department_id;


-- 14. Write a query to get the average salary for each job ID excluding programmer. 
SELECT job_id, avg(salary) from employees
WHERE job_id != 'IT_PROG'
group by job_id;


-- 15. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only. 

SELECT job_id, sum(salary), max(salary), min(salary), AVG(salary) from employees
where department_id = 90
group by job_id;


-- 16, Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.




select job_id, MAX(salary) from employees
group by job_id
having max(salary) >= 4000;


-- 17. Write a query to get the average salary for all departments employing more than 10 employees. 


select department_id, avg(salary) as avg_sal from employees
group by department_id
having count(employee_id) > 10;


-- categorize product by price range and show average stock for each range



