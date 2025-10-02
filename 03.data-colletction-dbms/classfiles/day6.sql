create database operator_ex;
use operator_ex;
show tables;

use hr;
show tables;

select * from employees
where first_name like 'd%';

SELECT * FROM employees
WHERE BINARY first_name LIKE 'D%';


select * from employees where first_name like '%e';

select * from employees where first_name like '%ah%';


SELECT * FROM employees where first_name like '_d%';

SELECT count(*) from employees where first_name like '%a_';

select * from employees
where first_name NOT LIKE 'a%';


select first_name from employees
WHERE first_name regexp '^[aeiou]';

select first_name from employees
where lower(left(first_name,1)) in ('a','e','i','o','u');

SELECT * from employees
WHERE department_id = 90 and salary = 24000;

select * from employees
where department_id = 90 or salary = 24000 and check_bonus is null;


SELECT * from employees
where  department_id >100;

select * from employees where check_bonus is null and check_bonus is null;

SELECT * from employees where 
salary > 10000 and department_id in (80,90,70,100);

select * from employees;


select * from employees
WHERE job_id IN ('IT_PROG') AND hire_date BETWEEN '1987-08-01' AND '2008-08-01' and salary > 10000;



select * from employees
WHERE salary > 15000 OR commission_pct < 0.30
ORDER BY commission_pct desc;

select * from employees
where not(salary between 5000 and 10000) and salary is not null;

select * from employees
WHERE year(hire_date) <> '1982';

SELECT * from 
employees where first_name regexp '^A';





SELECT * FROM employees where phone_number regexp '^[0-9]$';


