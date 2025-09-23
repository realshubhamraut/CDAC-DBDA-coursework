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

DELETE FROM department where dept_id = 1;
DESC department;
desc employee;


-- Q21. Use `ON DELETE SET NULL` in a foreign key
desc employee;
DROP TABLE if exists employee;

CREATE TABLE employee(
emp_id INT primary key,
name varchar(30),
dept_id int,
constraint fk_emp_dept
foreign key (dept_id)
references department(dept_id)
ON DELETE SET NULL
);



-- Q22.  Delete `dept_id = 1` and observe what happens

DELETE FROM department WHERE dept_id = 1;
select * from department;

select * from employee;


-- Q23. Drop the foreign key constraint from `employee`

SHOW CREATE TABLE employee;
DESC employee;

ALTER TABLE employee drop foreign key fk_emp_dept;


-- Q25. Create table with balance > = 0. using check

drop table accounts;
create table accounts(
ac_id int primary key,
ac_name varchar(40),
ac_bal int default 0 CONSTRAINT chk_balance_range CHECK (ac_bal>=0));




insert into accounts(ac_id, ac_bal) VALUES (1, -100);


-- Q26. Modify the constraint so that balance must be between 100 and 1,000,000.


show create table accounts;

ALTER TABLE accounts
DROP CONSTRAINT chk_balance_range;

ALTER TABLE accounts
ADD constraint chk_balalnce_range CHECK (ac_bal BETWEEN 100 AND 1000000);

-- Q27. Try to insert (id=2, balance=50). What error do you get?

INSERT INTO accounts
(ac_id, ac_bal) VALUES (2, 50);

-- Error Code: 3819. Check constraint 'chk_balalnce_range' is violated.	0.0069 sec

-- Q28.Create table invoices with invoice_id AUTO_INCREMENT PRIMARY KEY. Insert 3 rows. What will be the IDs?

CREATE TABLE invoices (
invoice_id int primary key auto_increment,
amount DECIMAL (10,2)
);

INSERT into invoices (amount)
VALUES (150.00),(275.00),(123.56);


-- these values will recieve the 1,2,3 as their invoice_id


-- Q29. Delete last row. Insert again. Will AUTO_INCREMENT reuse the deleted number?

DELETE FROM invoices
WHERE invoice_id = 3;

INSERT into invoices (amount)
VALUES(400.00);


-- this will delete the invoice_id and there will be the next id will be assigned upon insertion i.e 4

-- Q30 Write queries to:
-- 1. Add a UNIQUE constraint on phone column in users.

CREATE TABLE users(
user_name varchar(23),
user_phone int);

ALTER TABLE USERS ADD constraint unq_phone UNIQUE(user_phone);


-- 2. Drop the UNIQUE constraint from users.
ALTER TABLE users
DROP INDEX unq_phone;


-- Q31 .Create a table library with a composite primary key (book_id, branch_id) and a UNIQUE constraint on (isbn, branch_id).

CREATE TABLE library(
book_id int,
branch_id int,
isbn varchar(40),
primary key(book_id, branch_id),
UNIQUE key uq_isbn_branch(isbn, branch_id));


-- Q32. Insert (book_id=1, branch_id=101, isbn='A123') twice. What error occurs?


INSERT INTO library VALUES (1,101,'A123');
INSERT INTO library VALUES (1,101,'A123');

-- Error Code: 1062. Duplicate entry "1-101' for key 'library.PRIMARY'


-- Q33. Insert (book_id=1, branch_id=102, isbn='A123). Will it work? Why?

INSERT into library values(1, 102, 'A123'); 

-- although isbn is same for both the branch id is different, so it will work


-- Q34. Can you have a table with PRIMARY KEY and multiple UNIQUE constraints? Write a query.


drop table contacts;
create table contacts(
id int primary key,
email varchar(255) unique,
phone varchar(20) unique
);


-- Q35. Try to create a table with both PRIMARY KEY(id) and UNIQUE(id). What happens?

create table bad_example(
id int primary key,
unique (id));


-- this works in the most of the databases, but it could be further redundant as we don't really need to unique constrainn
-- cuz the primary key has the preference;
desc bad_example;


-- Q36 Create `exam_results` with composite PK and a CHECK on `marks`


CREATE TABLE exam_results(
student_id int,
exam_id int,
marks int,
primary key (student_id, exam_id),
constraint chk_marks_range
CHECK(marks BETWEEN 0 and 100))
;

-- Q37. Create table orders referencing customers with ON UPDATE CASCADE. Update customer_id in parent – what happens in child?
CREATE Table customers(
customer_id int primary key,
customer_name varchar(45)
);


create table orders(
order_id int primary key AUTO_INCREMENT,
customer_id int, 
amount DECIMAL(10,2),
CONSTRAINT fk_order_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON UPDATE CASCADE
);


INSERT INTO customers(customer_id, name) VALUES (1, 'Alice');
INSERT INTO orders(order_id, customer_id, amount) VALUES (100,1,50.0);


















