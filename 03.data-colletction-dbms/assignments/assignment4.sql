
create database assignment4;
use assignment4;


-- 1. Write a SQL statement to create a simple table of countries including columns country_id,country_name and region_id.
CREATE TABLE countries(
country_id int, 
country_name varchar(30),
region_id int);

-- 2. Write a SQL statement to create a simple table of countries including columns country_id,country_name and region_id which already exists.

CREATE TABLE IF not exists countries(
country_id int, 
country_name varchar(30),
region_id int
);


-- 3. Write a SQL statement to create the structure of a table dup_countries similar to countries.

CREATE TABLE dup_countries as
select * from countries where 1=0;


-- 4. Write a SQL statement to create a duplicate copy of countries table including structure and data by name dup_countries


CREATE table dup_countries1 as 
select * from countries;


-- 5. Write a SQL statement to create a table where countries set a constraint NULL.


CREATE TABLE countries2 (
country_id int,
country_name varchar(100) null, 
region_id int
);


-- 6. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, max_salary and check whether the max_salary amount exceeds the upper limit 25000.

create table jobs(
job_id int,
job_title varchar(40),
min_salary int,
max_salary int CHECK (max_salary<=25000)
);


-- 7 Write a SQL statement to create a table named countries including columns country_id, country_name and region_id and make sure that no countries except Italy, India and China will be entered in the table.

CREATE TABLE countries3 (
    country_id INT,
    country_name VARCHAR(50),
    region_id INT,
    CONSTRAINT chk_country_name CHECK (country_name IN ('Italy', 'India', 'China'))
);


-- 8. Write a SQL statement to create a table named job_histry including columns employee_id, start_date, end_date, job_id and department_id and make sure that the value against column end_date will be entered at the time of insertion to the format like '--/--/----'.

CREATE table job_history(
employee_id int primary key, 
start_date datetime,
end_date varchar(10) CHECK (end_date LIKE '__/__/___'),
job_id int,
department_id int);


-- 9. Write a SQL statement to create a table named countries including columns country_id,country_name and region_id and make sure that no duplicate data against column country_id will be allowed at the time of insertion.


CREATE table country4(
country_id int primary key,
country_name varchar(30),
region_id int);


-- 10. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.


CREATE table jobs1(
job_id int primary key,
min_salary int default 8000, 
max_salary int default NUll, 
job_title varchar(30) default '');


-- 11. Write a SQL statement to create a table named countries including columns country_id, country_name and region_id and make sure that the country_id column will be a key field which will not contain any duplicate data at the time of insertion.

create table countries1(
country_id int primary key,
country_name varchar(20),
region_id int);


-- 12.Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make sure that the column country_id will be unique and store an auto incremented value.


CREATE table countries4(
country_id int UNIQUE AUTO_INCREMENT,
country_name varchar(30),
region_id int);




-- 13. . Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make sure that the combination of columns country_id and region_id will be unique.

CREATE table countries5(
country_id int, country_name varchar(30),
region_id int,
unique(country_id, region_id));

-- 14. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column job_id contain only those values which are exists in the jobs table.

create table job_history3(
employee_id int UNIQUE, start_date datetime,
end_date datetime, job_id int,
 foreign key (job_id) references jobs1(job_id), department_id int); 


-- 15. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only those unique combination values, which combinations are exists in the departments table.

create table departments(
department_id decimal(4,0) not null default 0,
department_name varchar(30) not null, manager_id decimal(6,0) not null default 0,
location_id decimal(4,0),
primary key (department_id, manager_id)
);



CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(40),
    email VARCHAR(50),
    phone_no DECIMAL(10,0),
    hire_date DATETIME, 
    job_id INT,
    salary INT,
    commision INT, 
    manager_id DECIMAL(6,0), 
    department_id DECIMAL(4,0),
    FOREIGN KEY (department_id, manager_id)
        REFERENCES departments(department_id, manager_id)
);



-- 16. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column department_id, reference by the column department_id of departments table, can contain only those values which are exists in the departments table and another foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. "A foreign key constraint is not required merely to join two tables. For storage engines other than InnoDB, it is possible when defining a column to use a REFERENCES tbl_name(col_name) clause, which has no actual effect, and serves only as a memo or comment to you that the column which you are currently defining is intended to refer to a column in another table." 


CREATE TABLE employees11 (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(40),
    email VARCHAR(50),
    phone_number BIGINT,
    hire_date DATETIME,
    job_id INT,
    salary DECIMAL(10,2),
    commission DECIMAL(10,2),
    manager_id INT,
    department_id DECIMAL(4,0),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (job_id) REFERENCES jobs1(job_id)
) ENGINE=InnoDB;


CREATE TABLE departments11 (
    department_id DECIMAL(4,0) NOT NULL PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    manager_id DECIMAL(6,0),
    location_id DECIMAL(4,0)
) ENGINE=InnoDB;

CREATE TABLE jobs11 (
    job_id INT NOT NULL PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL DEFAULT ' ',
    min_salary DECIMAL(6,0) DEFAULT 8000,
    max_salary DECIMAL(6,0) DEFAULT NULL
) ENGINE=InnoDB;


-- 17. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON UPDATE CASCADE action allows you to perform cross-table update and ON DELETE RESTRICT action reject the deletion. The default action is ON DELETE RESTRICT.

CREATE TABLE employees12 (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(40),
    job_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (job_id)
        REFERENCES jobs11(job_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- 18

CREATE TABLE employees13 (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(40),
    job_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (job_id)
        REFERENCES jobs11(job_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
) ENGINE=InnoDB;


-- 19

CREATE TABLE employees15 (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(40),
    job_id INT NULL,
    salary DECIMAL(10,2),
    FOREIGN KEY (job_id)
        REFERENCES jobs11(job_id)
        ON DELETE SET NULL
        ON UPDATE SET NULL
) ENGINE=InnoDB;



-- 20


CREATE TABLE employees17 (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(40),
    job_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (job_id)
        REFERENCES jobs11(job_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE=InnoDB;



