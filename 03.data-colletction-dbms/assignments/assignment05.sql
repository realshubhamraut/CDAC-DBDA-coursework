create database assignment5;
use assignment5;


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department_id INT,
    commission_pct DECIMAL(4,2),
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);



CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name) VALUES
(80, 'Sales'),
(90, 'Operations'),
(100, 'Accounting'),
(110, 'Marketing'),
(120, 'IT'),
(130, 'HR');


INSERT INTO departments (department_id, department_name) VALUES
(80, 'Sales'),
(90, 'Operations'),
(100, 'Accounting'),
(110, 'Marketing'),
(120, 'IT'),
(130, 'HR');


INSERT INTO employees (employee_id, first_name, last_name, email, department_id, commission_pct, salary) VALUES
(101, 'John', 'Doe', 'john.doe@example.com', 110, 0.05, 6000),
(102, 'Jane', 'Smith', 'jane.smith@example.com', 80, 0.15, 5500),
(103, 'Alice', 'Johnson', 'alice.johnson@example.com', 80, 0.25, 7000),
(104, 'Bob', 'Brown', 'bob.brown@example.com', 90, NULL, 4800),
(105, 'Charlie', 'Davis', 'charlie.davis@example.com', 100, NULL, 4500),
(106, 'Eva', 'Green', 'eva.green@example.com', 120, 0.10, 9000),
(107, 'Frank', 'White', 'frank.white@example.com', 110, 0.08, 6200),
(108, 'Grace', 'Lee', 'grace.lee@example.com', 80, 0.10, 5000),
(109, 'Hannah', 'Moore', 'hannah.moore@example.com', 130, NULL, 7500);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department_id INT,
    commission_pct DECIMAL(4,2),
    salary DECIMAL(10,2)
);

-- 1. Write a SQL statement to change the email column of the employees table with 'not available' for all employees.
update employees
set email = 'not available';



 
-- 2. Write a SQL statement to change the email and commission_pct column of employees
-- table with 'not available' and 0.10 for all employees.

update employees
set email = 'not available',
commission_pct = 0.10;


-- 3. Write a SQL statement to change the email and commission_pct column of employees
-- table with 'not available' and 0.10 for those employees whose department_id is 110.
update employees
set email = 'not available',
commission_pct = 0.10
where department_id = 110;


-- 4. Write a SQL statement to change the email column of employees table with 'not
-- available' for those employees whose department_id is 80 and gets a commission_pct is
-- less than 20

update employees
SET email = 'not available'
where department_id = 80
and commission_pct < 0.20;

-- 5. Write a SQL statement to change the email column of the employees table with 'not
-- available' for those employees who belong to the 'Accounting' department.

update employees set salary = 8000
where employee_id = 105
and salary < 5000;

UPDATE employees
SET email = 'not available'
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE department_name = 'Accounting'
);
-- 6. Write a SQL statement to change the salary of an employee to 8000 whose ID is 105, if
-- the existing salary is less than 5000.

update employees
set salary = 8000
WHERE employee_id = 105 AND salary < 5000;


-- 7. Write a SQL statement to change the job ID of the employee whose ID is 118, to
-- SH_CLERK if the employee belongs to the department, whose ID is 30 and the existing
-- job ID does not start with SH.

update employees
set commision_pct =0.15
WHERE department_id

update employee 
set id = 118
WHERE 
-- 8. Write a SQL statement to increase the salary of employees under the department 40, 90
-- and 110 according to the company rules that salary will be increased by 25% for
-- department 40, 15% for department 90 and 10% for department 110 and the rest of the
-- departments will remain the same.
-- 9. Write a SQL statement to increase the minimum and maximum salary of PU_CLERK by
-- 2000 as well as the salary for those employees by 20% and commission percent by 10.