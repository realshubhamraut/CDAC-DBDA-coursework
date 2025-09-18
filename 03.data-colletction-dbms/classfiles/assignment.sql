-- Part A – Table Creation
-- Create a table Department with the following fields:
-- dept_id (Primary Key)
-- dept_name

CREATE DATABASE assignment1;
USE assignment1;

CREATE TABLE departments(
 dept_id int primary key,
 dept_name varchar(200)
 );

-- Create a table Employee with the following fields:
-- emp_id (Primary Key)
-- emp_name
-- salary
-- dept_id (Foreign Key referencing Department)


CREATE TABLE employee(
emp_id int primary key,
emp_name varchar(50),
salary int,
dept_id int,
foreign key (dept_id) references departments(dept_id)
);


INSERT INTO departments
(dept_id, dept_name) VALUES
(2,"court"),
(3,"jury"),
(4,"army")
;


INSERT INTO employee
(emp_id, emp_name, salary, dept_id) VALUES
(1,"Shubham", 40000,1),
(2,"Manoj",50000,2),
(3,"Sameer",48000,1),
(4,"Payal", 78000,3),
(5,"raj",73000,4)
;



SELECT * FROM departments;
select * from employee;


-- Display all employees with their department names.
SELECT emp_name, dept_name FROM employee em
JOIN departments dp ON dp.dept_id = em.dept_id
;


-- Find employees who work in the police department.

SELECT emp_name, dept_name FROM employee em
JOIN departments dp on dp.dept_id = em.dept_id
WHERE dp.dept_name LIKE "police";


-- List department names along with the number of employees in each department.
SELECT dept_name, COUNT(emp_name) as no_of_emp FROM employee em
JOIN departments dp on dp.dept_id = em.dept_id
GROUP BY dept_name;


-- Add a new employee 'Meena' in department 'Finance'.
SELECT * FROM departments;

INSERT INTO employee VALUES(6, "Meena",12000,6);

UPDATE employee SET dept_id = 6 WHERE emp_name = "Meena";

set sql_safe_updates = 0;


SELECT * FROM departments;

-- Find employees who work in the IT department.
SELECT emp_name FROM employee emp
JOIN departments dp ON emp.dept_id = dp.dept_id
WHERE dept_name = "IT";
