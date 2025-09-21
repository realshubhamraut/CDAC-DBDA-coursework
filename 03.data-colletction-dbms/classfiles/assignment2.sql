-- Q1.Create a table students with columns: id (INT), name (VARCHAR, NOT NULL), and age (INT with default 18).


create DATABASE assignment2;
USE  assignment2;
CREATE TABLE students(id int, std_name varchar(200) not null,
age int default 18);


-- Q2. Insert into students: (1, NULL, 20). What will happen?


INSERT INTO students VALUES(1, NULL, 20);
-- cannot be null

-- Q3. Insert into students: (2, 'Ravi'). What will be stored in age?

INSERT INTO students (id, std_name) values(2,'Ravi');

-- Q4. Why will the following query fail?

INSERT INTO students (id) VALUES (3); -- because of not null constraint


-- Q5.Modify the students table so that the age column default changes from 18 to 21.


ALTER table students
alter column age set default 21;


-- Q6. Drop the NOT NULL constraint on the name column. Write the query.

ALTER table students
MODIFY COLUMN std_name varchar(200) NULL;


--  Q7. Create a table department with columns: dept id (INT, PRIMARY KEY), dept name (VARCHAR). J


create table department(dept_id int primary key, dept_name varchar(20));


-- Q8. Insert (1,IT') and (1, 'HR'). What error will you get?

INSERT INTO department 
(dept_id, dept_name) VALUES
(1,'IT'),
(2,'HR');


-- Q9. Can a table have two PRIMARY KEYS? Demonstrate with a query.
-- not possible to have the two primary keys

-- Q10. Create a table enrollment with composite primary key (student_id, course _id).

create table enrollment(student_id int,
course_id varchar(50),
primary key(student_id, course_id));

-- Q.11 Try inserting (101, 'DBMS') twice into enrollment. What happens?

INSERT INTO enrollment VALUES (101, 'DBMS');
INSERT INTO enrollment values (101, 'DBMS');


-- 19:01:42	INSERT INTO enrollment values (101, 'DBMS')	Error Code: 1062. Duplicate entry '101-DBMS' for key 'enrollment.PRIMARY'	0.0012 sec


-- Q 12. Create a table users with columns: user id (INT, PRIMARY KEY, AUTO_INCREMENT), email (VARCHAR, UNIQUE).
CREATE table users(
user_id int primary key auto_increment,
email varchar(50) unique);


-- Q 13. Insert ('abc@mail.com') twice. What error occurs?

INSERT INTO users (email) values ('abc@gmail.com');
INSERT INTO users (email) values ('abc@gmail.com');

-- INSERT INTO users (email) values ('abc@gmail.com')	Error Code: 1062. Duplicate entry 'abc@gmail.com' for key 'users.email'	0.0016 sec


-- Q 14. Does the following query work? Why? 
-- INSERT INTO users (email) VALUES (NULL); 
-- INSERT INTO users (email) VALUES (NULL);


INSERT INTO users (email) values (NULL);
INSERT INTO users (email) values (NUll);
INSERT INTO users (email) values (NUll);

-- the values gets inserted since they are of NULL


-- Q 15. Create a table products with UNIQUE constraint on (sku, region).

drop table products;


CREATE table products(
sku int primary key, region varchar(120),
unique (sku, region)
);



-- Q 16. Insert (sku='Al', region='US') twice. What error?


INSERT INTO products (sku, region) values('1', 'US');



-- Q 17. Create a table department with primary key dept_id. Then create employee table with foreign key dept_id referencing department.

create table department1(dept_id int primary key);

CREATE table employee1(
emp_id int,
dept_id INT,
foreign key (dept_id) REFERENCES department(dept_id));

-- Q.18 Insert into employee (emp_id=1, name='Asha', dept id-99) when no such dept exists. What error?

INSERT INTO employee VALUES(emp_id, 99);


-- Q19. Delete dept_id=1 from department when employees exist. What error without ON DELETE CASCADE?
SELECT * from department;

drop table department;



CREATE table department(
dept_id int PRIMARY KEY,
dept_name VARCHAR(100)
);



-- Q20.









