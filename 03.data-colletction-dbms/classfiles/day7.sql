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



