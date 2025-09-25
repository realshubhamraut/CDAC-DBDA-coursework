-- 1

use hr;
 select concat(first_name, ' ', last_name) as full_name
from employees;

-- 2 

select lower(first_name) as full_name,
upper(last_name) as last_name_upper
from employees;


-- 3

select upper(country_name) as country_name
from countries_new;

-- 4. 

SELECT first_name, LENGTH(first_name) AS name_length
FROM employees;

-- 5.

select email, length(email) as email_length from employees
where length(email) > 10;


-- 6. 


select substring(first_name, 1,3) as first3_chars
from employees;


-- 7. 

select right(phone_number,4) as last4_digits
from employees;


-- 8.

select last_name, INSTR(last_name, 'a') as position_of_a
from employees;


-- 9. 

select last_name, INSTR(job_title, 'IT') as position_of_a
from employees;


-- 10. 

select replace(first_name, 'a', 'X') as updated_name
from employees;


-- 11.

select replace(region_name, 'Europe', 'EU') as updated_region
from regions;

-- 12. 

SELECT trim(first_name) as cleaned_name
from employees;


-- 13. 

SELECT RTRIM(state) as cleaned_state
from locations;


select * from locations;


-- 14. 

select left(email,5) as email_prefix
from employees;


-- 15. 


select right(country_name, 3) as last3_chars
from countries_new;

-- 16. 

select substring(email, instr(email, '@') + 1 )as email_domain
from employees;


-- 17. 


select substring_index(phone_number, ' ', 1) as country_code from employees;


-- 18. 

select first_name, last_name, STRCMP(first_name, last_name) AS comparison_result

from employees;


-- 19. 

select region_name, CASE WHEN region_name = 'Asia' THEN 0 ELSE 1 END AS comparison_result
from regions;

-- 20. 

SELECT CONCAT(first_name, '-', last_name, '-', job_id) AS emp_details
from employees;

select * from employees;


-- 21. 

select first_name, substring_index(email, '@', 1) as username
from employees;


-- 22. 

select last_name, replace(last_name, 'e', 'E') as updated_last_name
from employees
where last_name LIKE '%e%';

-- 23. 


select first_name, INSTR(first_name, 'o') AS position_of_o
from employees;

-- 24. 


SELECT TRIM(city) as cleaned_city,
left(trim(city), 3) as first3_chars
from locations;

select * from locations;


-- 25. 

select last_name, INSTR(last_name, 'n') as position_of_n
from employees
WHERE last_name LIKE '%n%';


-- 26. 

select first_name, INSTR(first_name, 'a') as position_of_a
from employees;


-- 27.

select job_title,
INSTR(job_title, 'e') AS position_of_e
FROM jobs
WHERE instr(job_title,'e') > 5;



-- 28. 


SELECT first_name, last_name from employees
WHERE first_name < last_name;


-- 26. 
SELECT department_name
from departments
WHERE find_in_set(department_name, 'IT,HR');


-- 27. 


SELECT first_name, length(first_name) as name_length
from employees
where length(first_name) > 6;

-- 28. 

SELECT country_name from countries_new
WHERE country_name in ('China','India','Japan');


-- 29 

select first_name, last_name, department_id from employees
WHERE department_id in (50, 60, 70);


-- 30. 


select country_name, left(country_name,2) as first2,
right(country_name,2) as last2
from countries;



-- 31. 

select last_name from employees
WHERE instr(last_name, 'o')> length(last_name) / 2;

-- 32. 

select first_name, 
INSTR(first_name, 'a') as pos_a, 
INSTR(last_name, 'e') as pos_e
from employees
where first_name like '%a%' AND first_name like '%e%';


-- 33. 

select first_name, email,
substring(email, instr(email, '@') + 1) as domain
from employees
WHERE substring(email, instr(email, '@') + 1) = 'example.com';


-- 34.

select count(*) as employee_count from employees
where department_id in (50,60,70);


-- 35. 

select country_name from countries_new
WHERE region_id in(1,3);



-- 36. 


select first_name, last_name, department_id, salary
from employees
WHEre department_id in(50,60,70) or salary > 10000;


-- 37.

select first_name, last_name, department_id, manager_id from employees
WHERE department_id in (50,60) and manager_id in(103, 100);


-- 38. 


SELECT concat(e.first_name, ',', e.last_name, ',', c.country_name) as emp_country
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
JOIN countries_new c on l.country_id = c.country_id;

select * from employees;


-- 39.

select case when salary > 8000 then upper(first_name) else first_name end as first_name_case,
case when salary < 8000 then lower(last_name) else last_name end as last_name_case
from employees;

