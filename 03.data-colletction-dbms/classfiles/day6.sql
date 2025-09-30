create database operator_ex;
use operator_ex;
show tables;
use hr;
-- arithmentic operators
SELECT salary, salary* 1000 as mul_bonus FROM employees;
SELECT salary, salary - 1000 as min_bonus FROM employees;
SELECT salary, salary + 1000 as add_bonus FROM employees;
SELECT salary, salary % 1000 as mod_bonus FROM employees;
SELECT salary, salary / 1000 as div_bonus from employees;





select salary, check_bonus+1000 as bonus from employees;

-- comparison operators (=,<>,<=,>=,<,>)

select * from jobs;

SELECT employee_id, concat(first_name,' ',last_name) as full_name from employees where first_name = 'Steven';


SELECT employee_id, concat(first_name,' ', last_name) full_name, department_id from employees WHERE salary > 12000;

SELECT employee_id, concat(first_name,' ', last_name) full_name, department_id from employees WHERE department_id = 12;

SELECT employee_id, concat(first_name,' ', last_name) full_name, department_id from employees where check_bonus is null;

select * from employees;

show tables;

select * from bad_employees;

SELECT * FROM employees where department_id != 90;


SELECT * FROM employees WHERE manager_id <> 199;

SELECT first_name, last_name from employees WHERE year(hire_date) <> 1990;

SELECT * from employees
WHERE salary > 1000 order by salary desc;


-- to find employees who are working since 1987-08-01


select first_name, last_namefrom employees
WHERE hire_date >= '1987-08-01';


SELECT * from employees;
WHERE year(hire_date) >= 1980;

select * from employees where
salary < 10000;

select * from employees where salary <= 10000;

select * from employees where salary >= 10000;

SELECT count(*) from employees where commission_pct <  0.15;

select * from employees
where salary between 2000 and 100000;


select * from employees
WHERE hire_date between '1987-08-01' AND '1987-08-30';

SELECT * From employees
WHERE year(hire_date) LIKE 1989;


SELECT count(*) FROM employees
where department_id BETWEEN 70 AND 100;


SELECT first_name, last_name from employees

WHERE first_name BETWEEN 'a%' AND 'd%';


SELECT first_name, last_name from employees
WHERE manager_id NOT between 70 and 105;


SELECT * FROM employees where department_id IN (70,40,90,100);

SELECT * FROM employees where job_id IN ('AD_VP','IT_PROG','FI_MGR');

SELECT * FROM employees where first_name LIKE 'DIANA';


SELECT * from employees where 
job_id not in('HR_REP', 'AD_PRES','AD_VP');
