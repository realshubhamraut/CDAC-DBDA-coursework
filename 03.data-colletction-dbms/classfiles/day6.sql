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

use hr;
SELECT employee_id, concat(first_name, ' ', last_name) as full_name from employees;
select employee_id, concat(first_name,' ', last_name) as full_name from employees;



select employee_id, concat("Name: ", first_name,", department_id", department_id) as name_department FROM employees;


select employee_id, concat("Name: ", first_name, "email :", email, "phone :", phone_number) as emp_details FROM employees;

-- write a query to represent contact info of a employee(email,phone);

SELECT * from employees;

SELECT first_name, length(first_name) as length_of_first_name from employees;


SELECT first_name, last_name from employees
WHERE length(first_name) = length(last_name);


SELECT first_name from employees
WHERE length(first_name) =3;


SELECT first_name, length(first_name) as length_of_first_name from employees
where length(first_name)>=3;



SELECT upper(first_name), lower(last_name) from employees;

SELECT first_name, substring(last_name,1,5) from employees;

select substring(first_name,1,2) from employees;

SELECT substring(phone_number,-2) from employees;

SELECT first_name from employees WHERE substring(first_name,1,1) = upper(substring(first_name,1,1));

-- SELECT first_name, concat(upper(substring(first_name,1,1)),'',substring(first_name,2) from employees;

SELECT country_id, country_name, concat(substring(country_id,1,1),lower(substring(country_id,2,2)),'-', lower(country_name)) as total
from countries_new;


SELECT first_name, left(first_name,2), right(first_name,2) from employees;



SELECT first_name, ltrim(first_name), rtrim(first_name) from employees;


select first_name, rpad(first_name, 6, '$') from employees;


select first_name, reverse(first_name)
from employees;



select first_name, phone_number, replace(phone_number,'.','-');

SELECT first_name, job_id, replace(job_id, 'AD_VP', 'president') from employees;

select country_id, country_name, replace(country_name, 'United States of America' , 'United Kingdom') from countries_new
WHERE country_name IN( 'United States of America' ,'United Kingdom');


SELECT now();
select curdate();
select curtime();
select system_user();

SELECT first_name, last_name, year(hire_date), month(hire_date), day(hire_date), monthname(hire_date) from employees;



