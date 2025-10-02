-- 1) Hello, Employees (staging CTE)
-- Task: Build a CTE that returns EMPLOYEE_ID, full_name, JOB_ID, DEPARTMENT_ID, SALARY.
--  Output: employee_id, full_name, job_id, department_id, salary.
--  Hint: CONCAT(COALESCE(FIRST_NAME,''),' ',LAST_NAME).


with emp_cte as (
select employee_id, concat(first_name,' ', last_name) as full_name, job_id, department_id, salary from employees
);

WITH employees_cte AS (
    SELECT 
        employee_id,
        CONCAT(COALESCE(first_name, ''), ' ', last_name) AS full_name,
        job_id,
        department_id,
        salary
    FROM employees
)
SELECT *
FROM employees_cte;

with emp_cte as (
select employee_id, concat(