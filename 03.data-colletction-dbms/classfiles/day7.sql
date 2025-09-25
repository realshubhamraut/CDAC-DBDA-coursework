select now(), curdate(), curtime(), sysdate(), system_user();

select employee_id, first_name, last_name,
year(hire_date),
month(hire_date),
day(hire_date),
monthname(hire_date),
dayname(hire_date),
dayname(hire_date)
from employees;


INSERT INTO employees (
  employee_id, first_name, last_name, salary, email, phone_number,
  job_id, commission_pct, manager_id, department_id, status, hire_date, termination_date
)
VALUES (
  999, 'shubham', 'raut', 100000, 'shubh@gmail.com', '9898989898',
  'AD_ASST', 0.34, 102, 11, 'inactive', NULL, NULL
);


select employee_id, concat(first_name,' ',last_name), hire_date from employees where hire_date = curdate();


SELECT curtime();

select count(*) as no_of_records, curtime() as report_generated from employees;

-- date_add/date_sub


select date_add("2025-09-25", interval 1 year);
select date_add("2025-09-25", interval 1 day);
select date_add("2025-09-25", interval 1 month);


select date_sub("2025-09-25", interval 1 year);
select date_sub("2025-09-25", interval 1 day);
select date_sub("2025-09-25", interval 1 month);

select date_sub("2023-08-23", interval 1 year);


select date_sub("2023-09-23", interval 1 month);
select date_sub("2024-09-10", interval 1 day);

select date_Add("2023-12-23", interval "1_1" year_month);  -- adds 1 year 1 month

select employee_id, concat(first_name,' ', last_name) as full_name, date_Add(hire_date, interval 30 day) as probation_period from employees;


SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE hire_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);



select round(datediff(curdate(), hire_date)/365) as date_diff from employees;

select timestampdiff(month, hire_date, curdate()) from employees;
select timestampdiff(day, hire_date, curdate()) from employees;
select timestampdiff(year, hire_date, curdate()) from employees;

SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name, hire_date
from employees
where timestampdiff(day, hire_date, curdate())<=30;

select date_format("2025-09-25", '%d-%m-%y');



--  find the employees who servered for 35 + years
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name from employees
WHERE timestampdiff(day, hire_date, curdate())>=35;


SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE TIMESTAMPDIFF(day, hire_date, CURDATE()) >= 35;

-- find the employees who were hired in the august

SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name from employees
where (month(hire_date) = 8);


-- find the employees who are having birth aniversary in next 30 days

select * from employees;

SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name from employees
WHERE (month(hire_date) + interval 1 month);

SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE date_format(hire_date, '%m-%d') between date_format(current_date, '%m-%d') and date_format(date_add(current_date, interval 30 day), '%m-%d');













-- WORKING WITH NORTHWIND DATA












select concat(first_name,' ', last_name) as full_name, birth_date, timestampdiff(year, birth_date, curdate()) as diff_year from employees;

desc orders;


-- how many days ago the orders were placed from today

select order_id, order_date, timestampdiff(day, order_date, curdate()) as days_since_order from orders;


-- find the order that was placed in year 1997;

SELECT order_id, order_date from orders
WHERE YEAR(order_date) =1997;


-- time betwen the orders and the ship date


SELECT order_id, order_date, shipped_date, timestampdiff(day, order_date, shipped_date) as time_between from orders
WHERE shipped_date is not null;


-- 

use hr;

select concat(first_name,' ', last_name) as full_name, salary, if(salary>10000, 'High Salary','Low Salary') as sal_cat
from employees;


select concat(first_name,' ', last_name) as full_name, commission_pct,
if(commission_pct>0.15, 'high commision', 'low commision') as comm_cat from employees
where department_id in (90,70,100);


select concat(first_name, ' ', last_name) as full_name, hire_date, if(year(hire_date)> '1997', "Vetran", "regular") as emp_cat from employees;


-- classify the employees ffrom there job_id if the emp jobid is fi_mgr or pu_man

SELECT concat(first_name, ' ', last_name) as full_name, job_id, if (job_id in ('PU_MAN', 'FI_MGR'), 'manager', 'employee')  as role from employees
group by role;


SELECT IF(job_id IN ('PU_MAN', 'FI_MGR'), 'manager', 'employee') AS role, COUNT(*) AS total_count
FROM employees
GROUP BY role;



 SELECT (concat(first_name, ' ', last_name)) as full_name, if (length(first_name)>5, 'long name', 'short name') from employees;


SELECT (concat(first_name, ' ', last_name)) as full_name, job_id, case when job_id like 'FI_MRG' THEN 'Finance Manager' when job_id like 'AD_pres' then 'President'
else 'other'
end as job_cat from employees;


SELECT (concat(first_name, ' ', last_name)) as full_name, salary,
CASE WHEN salary<5000 then 'low range' when salary>5000 and salary<1000 then 'mid range' WHEN salary>10000 then 'high sal' else 'other' end as sal_cat from employees;

select * from employees;



select first_name, salary, commission_pct from employees;

show tables;

desc orders;

use northwind;

select * from orders;


select order_id, customer_id, shipped_date, ifnull(shipped_date, 'NA') as ship_check from orders;



select first_name, last_name, coalesce(home_phone, extension,'NO Infor') as no_info from employees;

use northwind;
SELECT customer_id, company_name, region, postal_code, coalesce(region, postal_code,'NA') as region_check from customers;



select avg(salary) from employees;
use hr;




