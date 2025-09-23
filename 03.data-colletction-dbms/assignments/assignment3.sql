-- Create 'customers' table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    address VARCHAR(100)
);

-- Create 'employees' table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age VARCHAR(10),  -- This will be modified later to INT
    salary DECIMAL(10, 2),
    department_id INT
);

-- Create 'contacts' table
CREATE TABLE contacts (
    contact_id INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)  -- This will be renamed later to 'home_address'
);

-- Create 'departments' table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create 'students' table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Create 'users' table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100)  -- This will have a unique constraint added later
);

-- Create 'inventory' table
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT  -- Default value will be set later
);

-- Create 'products' table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create 'locations' table
CREATE TABLE locations (
    location_id INT,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(50),
    state_province VARCHAR(50),  -- This will be renamed to 'state' later
    country_id VARCHAR(2),
    PRIMARY KEY (location_id)
);

-- Create 'job_history' table
CREATE TABLE job_history (
    employee_id INT,
    job_id VARCHAR(10),
    department_id INT,
    start_date DATE,
    end_date DATE
);



-- Create 'jobs' table
CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(50),
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);



-- 1. Write a query to add a new column named 'phone_number' of type VARCHAR(20) to a table named 'customers'.

ALTER TABLE customers add column phone_number varchar(20);

-- 2. Write a query to modify the data type of the column 'age' in a table named 'employees' to INT.
ALTER table employees modify age INT;


-- 3. Write a query to rename the column 'address' to 'home address' in a table named 'contacts'.

alter table contacts rename column address to home_address;

-- 4. Write a query to add a foreign key constraint named fk department' to a column named
-- 'department_id' in a table named 'employees", referencing the 'department id' column in a table
-- named 'departments'


ALTER TABLE employees add constraint fk_department foreign key (department_id) references departments(department_id);

-- 5. Write a query to drop the primary key constraint from a table named 'students'.

desc students;
ALTER TABLE students DROP primary key;

-- 6. Write a query to add a unique constraint named 'uc_email' to a column named 'email' in a table named 'users.

alter table users add constraint uc_email unique(email);


-- 7. Write a query to add a default value of '0' to a column named 'quantity' in a table named 'inventory'.


ALTER table inventory alter quantity SET DEFAULT 0;


-- 8. Write a query to modify the position of the column 'last name' to be the first column in a table named 'customers'.

alter table customers modify column last_name varchar(200) first;

-- 9. Write a query to change the auto-increment value of a column named product id' to start from 1001 in a table named 'products'.

ALTER TABLE products AUTO_INCREMENT = 1001;

-- 10. Write a query to add a check constraint named chk salary to a column named salary' in a 
-- table named 'employees', ensuring that the salary is greater than or equal to 2000.


ALTER table employees add constraint chk_sal CHECK(salary>=2000);


-- BASED ON HR DATABASE

show databases;
use hr;
show tables;

-- 1. Write a SQL statement to rename the table countries to country_new.

ALTER TABLE countries RENAME TO countries_new;

select * from countries_new;

-- 2. Write a SQL statement to add a column region_ id to the table locations.

ALTER TABLE locations add column region_id int;

-- 3. Write a SQL statement to add a column ID as the first column of the table locations.

desc locations;
ALTER TABLE locations modify column country_id varchar(2) first;


-- 4 Write a SQL statement to add a column region_id after state_province to the table locations.

alter table locations add column region_id int after state_province;


-- 5. Write a SQL statement to change the data type of the column country_id to integer in the table locations.

alter table locations modify column country_id int;

-- Error Code: 1366. Incorrect integer value: 'IT' for column 'country_id' at row 1

-- 6. Write a SQL statement to drop the column city from the table locations.

alter table locations drop column city;


select * from locations;
-- 7. Write a SQL statement to change the name of the column state_province to state, keeping the data type and size same

alter table locations change state_province state varchar(255);

show create table locations;
-- 8. Write a SQL statement to add a primary key for the columns location id in the locations table.

select * from locations;

alter table locations drop primary key;

alter table locations add primary key(location_id);

-- 9. Write a SQL statement to add a primary key for a combination of columns location_id and country_id.
alter table locations add primary key pk_1 (location_id, country_id);


-- 10. Write a SQL statement to drop the existing primary from the table locations on a combination of columns location_id and country_id.


alter table locations drop primary key;


-- 11. Write a SQL statement to add a foreign key on the job_id column of the job_history table referencing the primary key job_id of jobs table.

alter table job_history add constraint new_fk foreign key (job_id) references jobs(job_id);

-- 12. Write a SQL statement to add a foreign key constraint named fk_job_id on the job_id column of the job_history table referencing the primary key job_id of the jobs table.

alter table job_history add constraint new_fk_con foreign key (job_id) references jobs(job_id);

-- 13. Write a SQL statement to drop the existing foreign key fk_job_id from the job_history table on job_id column which is referencing the job_id of jobs table.


alter table job_history drop foreign key fk_job_id;

-- 14. Write a SQL statement to add an index named indx job_id on job_id column in the table job_history.

alter table job_history add index job_id_index (job_id);

-- 15. Write a SQL statement to drop the index indx_job_id from job_history table.

alter table job_history drop index job_id_index;

-- 16. Write a query to change the length of the email column in the customers table to VARCHAR(150).

show tables;

alter table customers modify column email varchar(150);

-- 17. Write a query to add a new column status of type VARCHAR(10) with a default value of 'active' to the employees table.

alter table employees add column new_column varchar(10) default 'active';

-- 18. Write a query to drop the phone_number column from the customers table.
show databases;
alter table customers drop column phone_number;


-- 19. Write a query to modify the department_name column in the departments table to ensure it cannot contain NULL values.

alter table departments modify department_name varchar(255) not null;

-- 20. Write a query to drop the UNIQUE constraint on the email column in the users table.
alter table users modify column email varchar(20);

-- 21. Write a query to rename the inventory table to product_inventory.

select * from imventory;

show tables;
alter table inventory rename product_inventory;



-- 22.Write a query to add a foreign key constraint on the employee_id column of the job history

ALTER table job_history ADD constraint fk_employee foreign key (employee_id) references employees(emploee_id);


-- 23. Write a query to change the default value of the status column in the employees table to 'inactive'.
ALTER TABLE employees alter column emp_status SET DEFAULT 'inactive';
select * from employees;

-- 24. Write a query to drop the foreign key constraint named fk department from the employees table.

ALTER table employees drop foreign key fk_department;


-- 25 Write a query to move the salary column to be after the last_name column in the employees table.
alter table employees modify column salary decimal(8,2) after last_name;

desc employees;


-- 26. Write a query to remove the default value from the status column in the employees table.
alter table employees modify column emp_status varchar(20);

alter table employees alter column new_column drop default;

-- 27. Write a query to rename the uc_email constraint on the email column in the users table to unique_email_constraint.

alter table users rename index uc_email to unique_email_constdraint;

show indexes from users;

-- 28. Write a query to disable the foreign key constraint fk department on the employees table and then re-enable it.


SET FOREIGN_KEY_CHECKS = 0;

SET FOREIGN_KEY_CHECKS = 1;



SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'employees'
  AND TABLE_SCHEMA = 'assignment3';
  

-- 29.Write a query to change the age column in the employees table to SMALLINT and allow it to accept NULL values.

ALTER TABLE employees
MODIFY COLUMN age SMALLINT NULL;





--
