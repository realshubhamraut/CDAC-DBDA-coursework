create database assignment5;
use assignment5;

-- 1. Write a SQL statement to change the email column of the employees table with 'not available' for all employees.

delete from employees where employee_id = 100;
alter table employees drop constraint EMP_EMAIL_UK;
 
-- 2. Write a SQL statement to change the email and commission_pct column of employees
-- table with 'not available' and 0.10 for all employees.


update employees
set email = 'not available',
commission_pct = 0.10;


-- 3. Write a SQL statement to change the email and commission_pct column of employees
-- table with 'not available' and 0.10 for those employees whose department_id is 110.


update employees set email = 'not available',
commission_pct = 0.10
where department_id = 110;



-- 4. Write a SQL statement to change the email column of employees table with 'not
-- available' for those employees whose department_id is 80 and gets a commission_pct is
-- less than 20
update employees
set email = 'not_available'
WHERE department_id = 80 AND commission_pct < 0.20;

select * from departments;
-- 5. Write a SQL statement to change the email column of the employees table with 'not
-- available' for those employees who belong to the 'Accounting' department.

select * from employees;

update employees
set email = 'not available'
WHERE JOB_ID LIKE 'AC%';


-- 6. Write a SQL statement to change the salary of an employee to 8000 whose ID is 105, if
-- the existing salary is less than 5000.

UPDATE EMPLOYEES
SET SALARY = 8000 WHERE EMPLOYEE_ID = 105
AND SALARY < 50000;

-- 7. Write a SQL statement to change the job ID of the employee whose ID is 118, to
-- SH_CLERK if the employee belongs to the department, whose ID is 30 and the existing
-- job ID does not start with SH.

UPDATE EMPLOYEES
SET JOB_ID = 'SH_CLERK'
WHERE EMPLOYEE_ID = 118
AND DEPARTMENT_ID = 38
AND JOB_ID NOT LIKE 'SH%';



-- 8. Write a SQL statement to increase the salary of employees under the department 40, 90
-- and 110 according to the company rules that salary will be increased by 25% for
-- department 40, 15% for department 90 and 10% for department 110 and the rest of the
-- departments will remain the same.

UPDATE EMPLOYEES
SET SALARY = CASE
WHEN DEPARTMENT_ID = 40 THEN salary * 1.25
WHEN department_id = 90 then salary * 1.15
WHEN department_id = 110 THEN salary * 1.10
else salary
end;




-- 9. Write a SQL statement to increase the minimum and maximum salary of PU_CLERK by
-- 2000 as well as the salary for those employees by 20% and commission percent by 10


update jobs
SET min_salary = min_salary + 2000,
max_salary = max_salary + 2000
WHERE job_id = 'PU_CLERK';