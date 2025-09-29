use northwind;


select first_name, department_name, emp_salary
from (select e.first_name, d.department_name, e.salary as emp_salary, e. Department_id from employees e
join departments d on d.department_id = e.department_id) as join_d where department_name = 'IT';




select full_name, department_name, city, country_name from
(select concat(first_name, ' ', last_name) as full_name, d.department_id, department_name, l.location_id, l.city, c.country_id, c.country_name from employees e
join departments d on e.department_id = d.DEPARTMENT_ID
join locations l on l.location_id = d.location_id
join countries c on c.country_id = l.country_id) as join_till_country
where city = 'Seattle';

-- write a query to find the departments that have 5 or more employees. display the department name
-- and department id.

select department_name, department_id
from (select d.department_id, d.department_name, count(d.department_id)
from employees e
join departments d on e.department_id =d.DEPARTMENT_ID
group by department_name, d.department_id
having count(d.department_id)>=5) as g_ex;

-- find employees where employee salary > avg(department_sal)

select employee_id, salary from employees 
where salary >(select avg(salary) from employees);

select avg(salary) as avg_salary from employees
group by department_id;



-- write a query to find the employees who are earning > avg(salary) department
-- display employee_id, their salary, department_avg

select first_name, department_id, department_name, salary from employees
join departments d on d.DEPARTMENT_ID = e.department_id
where salary > (select avg(salary) as avg_salary from employees
group by department_id);


-- “write a query to find the employees whose salary is greater than the average salary of their own department.
-- display employee_id, salary, department_id, and department_name.”


select e.employee_id, e.salary, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id
where e.salary > (
    select avg(salary)
    from employees
    where department_id = e.department_id
);

-- write a query to find the employees whose salary is greater than or equal to the average
-- salary of their respective department. display employee first name, department name,
-- department id, their salary, and the department average salary.

select first_name, department_name, j_j.department_id, salary, dept_avg from employees e
join (select d.department_name, d.department_id, avg(salary) as dept_avg from employees e
join departments d on d.department_id = e.department_id
group by d.department_id, d.department_name) as j_j on j_j.department_id = e.department_id
where e.salary >= j_j.dept_avg;
  


-- write a query to find the departments that have 10 or more employees. display department id,
-- department name, and the number of employees in each department.


select department_id, department_name, emp_count
from (
    select d.department_id, d.department_name, count(e.employee_id) as emp_count
    from employees e
    join departments d on e.department_id = d.department_id
    group by d.department_id, d.department_name
    having count(e.employee_id) >= 10
) as dept_with_10_plus;



-- CTE --


with print as
(select "hello welcome to pg-dbda" as Welcome_note)
select welcome_note from print;


with avg_count as 
(select department_id, avg(salary) from employees group by department_id)

select first_name, salary, dept_avg, c.department_id from employees
join avg_count c on e.department_id - c.department_id
where e.salary>= dept_avg;



WITH avg_count AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT e.first_name, e.salary, c.avg_salary, c.department_id
FROM employees e
JOIN avg_count c ON e.department_id = c.department_id
WHERE e.salary >= c.avg_salary;


-- find the departments where there are 0 employees working
--  with dept_id, dept_name

WITH emp_count AS (
    SELECT department_id, COUNT(*) AS emp_total
    FROM employees
    GROUP BY department_id
)
SELECT d.department_id, d.department_name
FROM departments d
LEFT JOIN emp_count e ON d.department_id = e.department_id
WHERE e.emp_total IS NULL;


-- find the no of emp working in each department with including emp_count = 0;

WITH emp_count AS (
    SELECT department_id, COUNT(employee_id) AS emp_total
    FROM employees
    GROUP BY department_id
)
SELECT d.department_id, d.department_name,
       COALESCE(e.emp_total, 0) AS emp_count
FROM departments d
LEFT JOIN emp_count e 
       ON d.department_id = e.department_id;


-- find the department where there is no magager assigned

WITH mgr_check AS (
    SELECT d.department_id, d.department_name, d.manager_id, e.employee_id
    FROM departments d
    LEFT JOIN employees e 
           ON d.manager_id = e.employee_id
)
SELECT department_id, department_name
FROM mgr_check
WHERE employee_id IS NULL;


-- “Find the list of employees along with their department’s city, region, and the total number of employees working in that department.”


WITH emp_dept AS (
    SELECT employee_id, first_name, department_id, salary
    FROM employees
),
r_map AS (
    SELECT d.department_id, d.department_name, c.country_name, l.city,
           TRIM(REPLACE(r.region_name, '\r', '')) AS region_name
    FROM departments d
    JOIN locations l ON d.location_id = l.location_id
    JOIN countries c ON c.country_id = l.country_id
    JOIN regions r ON r.region_id = c.region_id
),
dept_co AS (
    SELECT department_id, COUNT(*) AS num_of_emp
    FROM employees
    GROUP BY department_id
)
SELECT e.employee_id, e.first_name, e.department_id,
       r.city, r.region_name, d.num_of_emp
FROM emp_dept e
JOIN r_map r ON r.department_id = e.department_id
JOIN dept_co d ON d.department_id = e.department_id;


-- write a query to job_id, job_title, count(job_id), region_name

WITH r_map AS (
    SELECT d.department_id, 
           TRIM(REPLACE(r.region_name, '\r', '')) AS region_name
    FROM departments d
    JOIN locations l ON d.location_id = l.location_id
    JOIN countries c ON c.country_id = l.country_id
    JOIN regions r ON r.region_id = c.region_id
)
SELECT j.job_id, j.job_title, COUNT(e.job_id) AS job_count, r.region_name
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN r_map r ON e.department_id = r.department_id
GROUP BY j.job_id, j.job_title, r.region_name
order by job_title, job_count desc;


select department_id from employees 
union all
select department_id from departments;


-- unions


select employee_id,salary,'high salalry'as salcat from employees where salary>5000
union select employee_id,salary,'loesalary'as salcat from employees where salary<=5000;

select employee_id,salary,'high earner'as salcat from employees where salary>=5000
union all select employee_id,salary,'low earner'as salcat from employees where salary<=5000;




-- recursive union



with ex_rec as(
select employee_id,manager_id,department_id,first_name,0 as level
from employees
where manager_id is null

union all

select employee_id,manager_id,department_id,first_name,1 as level
from employees
where manager_id=80)
select *from ex_rec;




    
    with ex_rec as(
select employee_id,manager_id,department_id,first_name,0 as level
from employees
where department_id=80

union all

select employee_id,manager_id,department_id,first_name,1 as level
from employees
where department_id=90)
select *from ex_rec;