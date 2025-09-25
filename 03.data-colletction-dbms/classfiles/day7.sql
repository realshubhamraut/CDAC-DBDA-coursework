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
select employee_id, concat(first_name, ' ', last_name) as full_name from employees
where date_format(hire_date, '%m-%d') between date_format(current_date, '%m-%d') and date_format(date_add

