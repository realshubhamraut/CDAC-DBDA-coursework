set sql_safe_updates = 0;
--

-- Q1. Create a table Department with the following fields:
-- dept_id (Primary Key)
-- dept_name


CREATE DATABASE assignment1;
USE assignment1;

CREATE TABLE departments(
 dept_id int primary key,
 dept_name varchar(200)
 );

-- Q2. Create a table Employee with the following fields:
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


-- part B - data insertions

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

-- Part C 
-- Q4. Display all employees with their department names.
SELECT emp_name, dept_name FROM employee em
JOIN departments dp ON dp.dept_id = em.dept_id
;


-- Q5. Find employees who work in the police department.

SELECT emp_name, dept_name FROM employee em
JOIN departments dp on dp.dept_id = em.dept_id
WHERE dp.dept_name LIKE "police";


-- Q6. List department names along with the number of employees in each department.
SELECT dept_name, COUNT(emp_name) as no_of_emp FROM employee em
JOIN departments dp on dp.dept_id = em.dept_id
GROUP BY dept_name;


-- Q7. Add a new employee 'Meena' in department 'Finance'.
SELECT * FROM departments;

INSERT INTO employee VALUES(6, "Meena",12000,6);

UPDATE employee SET dept_id = 6 WHERE emp_name = "Meena";


-- Q8. Try inserting an employee with a non-existing department id (say dept_id = 10). What happens? Why?

INSERT INTO employee (dept_id, emp_name) VALUES (10, "jamin");
-- it shows error


-- Q9. Delete the Finance department. What happens to employees in that department?

DELETE FROM departments where dept_name = 'Finance';

-- Q10. Modify the Employee table so that if a department is deleted, all its employees are also deleted (ON DELETE CASCADE).
-- Find employees who work in the IT department.
SELECT emp_name FROM employee emp
JOIN departments dp ON emp.dept_id = dp.dept_id
WHERE dept_name = "IT";


-- Delete the Finance department. What happens to employees in that department?


