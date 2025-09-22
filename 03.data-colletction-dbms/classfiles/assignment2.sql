DROP database assignment2;
CREATE DATABASE assignment2;
USE assignment2;

-- Q1. Create a table students with columns: id (INT), name (VARCHAR, NOT NULL), and age (INT with default 18).

CREATE TABLE students(
id int,
std_name varchar(25) not null,
age int DEFAULT 18
);


-- Q2. What happens when you insert (1, NULL, 20)?

INSERT INTO STUDENTS(id, std_name, age)
VALUES (1, NULL, 20);

-- ERROR 1048 (23000): Column 'name' cannot be null


-- Q3. What age is stored when you insert (2, ‘Ravi’)?

INSERT INTO students (id, std_name)
VALUES (2, 'Ravi');

-- mysql uses default age 18


-- Q4. Why does this fail? INSERT INTO students (id) VALUES (3);

INSERT INTO students (id) VALUES (3);

-- name doesn't have the default value


-- Q5. Change the default age from 18 to 21

ALTER TABLE students
MODIFY age INT DEFAULT 21;



-- Q6. Drop the NOT NULL constraint on the name column. Write the query.

ALTER TABLE students
MODIFY std_name varchar(255) NULL;


-- Q7.  Create a table department with columns: dept_id (INT, PRIMARY KEY), dept_name (VARCHAR).

CREATE TABLE department (
dept_id INT primary key,
dept_name varchar(255)
);

-- Q8. Insert (1,‘IT’) and (1,‘HR’): Expected error

INSERT INTO department(dept_id, dept_name) VALUES (1, 'IT');
INSERT INTO department(dept_id, dept_name) VALUES (1, 'HR');

-- Error Code: 1062. Duplicate entry "1' for key 'department.PRIMARY'


-- Q9. can a table have two primary keys

-- ANS - NO its not possible


-- Q10. Create `enrollment` with a composite primary key

CREATE TABLE enrollment(
student_id int,
course_id int,
PRIMARY Key (student_id, course_id)
);


-- Q11. Try inserting (101, 'DBMS') twice into enrollment. What happens?
 
INSERT INTO enrollment (student_id, course_id) VALUES (101, 21);
INSERT INTO enrollment (student_id, course_id) VALUES (101, 21);

-- Error Code: 1062. Duplicate entry '101-21' for key 'enrollment.PRIMARY'

-- Q12. Create the `users` table with AUTO_INCREMENT primary key and a UNIQUE email

CREATE TABLE users (
user_id INT PRIMARY KEY AUTO_INCREMENT,
email varchar(255) UNIQUE
);




-- Q13. Insert (`'abc@mail.com'`) twice. What error occurs?

INSERT INTO USERS (email) VALUES ('abc@mail.com');
INSERT INTO USERS (email) VALUES ('abc@mail.com');

-- becuase email we specified unique we can't really have duplicate emails


-- Q14. Do these two inserts with `NULL` in `email` work? Why?

INSERT INTO USERS (email) VALUES (NULL);
INSERT INTO USERS (email) VALUES (NULL);




-- Q15. Create a `products` table with a UNIQUE constraint on `(sku, region)`


CREATE TABLE products(
product_id INT PRIMARY KEY AUTO_INCREMENT,
sku VARCHAR(100),
region VARCHAR(50),
UNIQUE KEY uq_sku_region (sku, region)
);


INSERT INTO products(sku, region)
VALUES ('A1','US');
INSERT INTO products(sku, region)
VALUES ('A1','US');


-- duplicate entry as we have created the sku, region as we have crated it as the unique key

-- Q17. Create `department` and `employee` with a foreign key

CREATE TABLE department (
dept_id int primary key,
dept_name varchar(25)
);

CREATE TABLE employee(
emp_id INT primary key,
name varchar(25),
dept_id int,
constraint fk_emp_dept foreign key(dept_id) references department(dept_id)
);




-- Q18. Insert an employee referencing a non-existent department

INSERT INTO employee(emp_id, name, dept_id)
VALUES (1, 'Asha', 99);

-- ERROR 1452 (23000): Cannot add or update a child row, because we don't have the ID 99 in the parent table

-- Q19. Delete `dept_id = 1` when employees exist (without ON DELETE CASCADE)

INSERT INTO department VALUES (1, 'cyber');
INSERT INTO employee values(1, 'shubham', 1);
DELETE FROM department WHERE dept_id = 1;



-- Cannot delete or update a parent row: a foreign key constraint fails



-- Q20. Use `ON DELETE CASCADE` and then delete the parent

DELETE FROM department where dept_id = 1 ON DELETE CASCADE;
DESC department;
desc employee;


-- Q21. 




