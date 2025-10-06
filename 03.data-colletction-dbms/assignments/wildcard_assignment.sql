-- Salespeople Table

create  database salespeople;
use salespeople;

CREATE TABLE salespeople (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);

-- Customers Table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salespeople(salesman_id)
);

-- Orders Table
CREATE TABLE orders_table(
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salespeople(salesman_id)
);

-- Generic Table for col1 pattern matching
CREATE TABLE patterns (
    col1 VARCHAR(100)
);

-- Employees Table
CREATE TABLE employees_table (
    emp_idno INT PRIMARY KEY,
    emp_fname VARCHAR(50),
    emp_lname VARCHAR(50),
    emp_dept VARCHAR(50)
);

-- Salespeople
INSERT INTO salespeople VALUES
(5001, 'Nolan', 'Paris', 0.13),
(5002, 'Nelson', 'Rome', 0.12),
(5003, 'Oliver', 'London', 0.15),
(5004, 'Zara', 'Berlin', 0.11),
(5005, 'Niel', 'Madrid', 0.14),
(5006, 'Nickel', 'Paris', 0.10);

-- Customers
INSERT INTO customer VALUES
(3007, 'Ben', 'Paris', NULL, 5001),
(3008, 'Brian', 'Rome', 200, 5002),
(3009, 'Susan', 'Berlin', 300, 5004),
(3010, 'John', 'London', NULL, 5003),
(3011, 'Megan', 'Madrid', 100, 5005),
(3012, 'Allan', 'Paris', 400, 5006);

-- Orders
INSERT INTO orders_table VALUES
(7001, 500.00, '2023-01-10', 3007, 5001),
(7002, 948.50, '2023-02-15', 3008, 5002),
(7003, 1983.43, '2023-03-20', 3009, 5004),
(7004, 2500.00, '2023-04-25', 3010, 5003),
(7005, 3999.99, '2023-05-30', 3011, 5005);

-- Patterns
INSERT INTO patterns VALUES
('abc_def'),
('ghi/jkl'),
('mno_/pqr'),
('stu%vwx'),
('no_special_characters');

-- Employees
INSERT INTO employees_table VALUES
(1001, 'Alice', 'Doe', 'Sales'),
(1002, 'Bob', 'Davis', 'Marketing'),
(1003, 'Charlie', 'Smith', 'IT'),
(1004, 'David', 'Duncan', 'HR'),
(1005, 'Eva', 'Brown', 'Finance');


select * from salespeople;
select * from customer;
-- 1. write a SQL query to find the details of those salespeople who come from the 'Paris' City or 'Rome' City. Return salesman_id, name, city, commission.
select salesman_id, name, city, commission from salespeople where city = 'Paris' or  city='Rome';

-- 2.write a SQL query to find the details of the salespeople who come from either 'Paris' or 'Rome'. Return salesman_id, name, city, commission.
select salesman_id, name, city, commission from salespeople where city in ('Paris','Rome');

-- 3. write a SQL query to find the details of those salespeople who live in cities other than Paris and Rome. Return salesman_id, name, city, commission.
select salesman_id, name, city, commission from salespeople where city not in ('Paris','Rome');
  
-- 4. write a SQL query to retrieve the details of all customers whose ID belongs to any of the values 3007, 3008 or 3009. 
-- Return customer_id, cust_name, city, grade, and salesman_id.  
select customer_id, cust_name, city, grade,salesman_id from customer where customer_id in(3007, 3008 ,3009);

select * from salespeople;
-- 5. write a SQL query to find salespeople who receive commissions between 0.12 and 0.14 (begin and end values are included). 
-- Return salesman_id, name, city, and commission.  
select commission, name, city, salesman_id from salespeople where commission between 0.12 and 0.14;

-- 6. write a SQL query to select orders between 500 and 4000 (begin and end values are included). 
-- Exclude orders amount 948.50 and 1983.43. Return ord_no, purch_amt, ord_date, customer_id, and salesman_id. 

select * from orders_table;

select ord_no, purch_amt, ord_date, customer_id,salesman_id from orders_table where purch_amt 
between 500 and 4000 and purch_amt not in (948.50 ,1983.43);

-- 7. write a SQL query to retrieve the details of the salespeople whose names begin with any 
-- letter between 'A' and 'L' (not inclusive).  Return salesman_id, name, city, commission. 

select * from salespeople;

select * from salespeople  where name like 'A%' and 'L%';

-- 8.write a SQL query to find the details of all salespeople except those whose names begin with any 
-- letter between 'A' and 'L' (not inclusive). Return salesman_id, name, city, commission.  
select * from salespeople  where name not like 'A%' and 'L%';

-- 9.write a SQL query to retrieve the details of the customers whose names begins with the letter 'B'. 
-- Return customer_id, cust_name, city, grade, salesman_id.. 
select * from customer where cust_name like 'B%';
 
-- 10. write a SQL query to find the details of the customers whose names end with the letter 'n'. 
-- Return customer_id, cust_name, city, grade, salesman_id.
select * from customer where cust_name like '%n';

-- 11. write a SQL query to find the details of those salespeople whose names begin with ‘N’ and the fourth character is 'l'. 
-- Rests may be any character. Return salesman_id, name, city, commission. 
select * from salespeople where name like 'n__l%';

-- 12.write a SQL query to find those rows where col1 contains the escape character underscore ( _ ). Return col1.

select * from patterns where col1 like '%\_%';

-- 13. write a SQL query to identify those rows where col1 does not contain the escape character underscore ( _ ). Return col1.
select * from patterns where col1  not like '%\_%';

-- 14.write a SQL query to find rows in which col1 contains the forward slash character ( / ). Return col1.
select * from patterns where col1 like '%\/%';

-- 15. write a SQL query to identify those rows where col1 does not contain the forward slash character ( / ). Return col1.
select * from patterns where col1 not like '%\/%';

-- 16. write a SQL query to find those rows where col1 contains the string ( _/ ). Return col1.
select * from patterns where col1 like '%\_/%';

-- 17. write a SQL query to find those rows where col1 does not contain the string ( _/ ). Return col1.
select * from patterns where col1 not like '%\_/%';

-- 18. write a SQL query to find those rows where col1 contains the character percent ( % ). Return col1.
select * from patterns where col1 like '%\%%';
-- 19. write a SQL query to find those rows where col1 does not contain the character percent ( % ). Return col1.
select * from patterns where col1 not like '%\%%';
-- 20. write a SQL query to find all those customers who does not have any grade. 
-- Return customer_id, cust_name, city, grade, salesman_id.
select * from customer where grade is null;
-- 21. write a SQL query to locate all customers with a grade value. Return customer_id, cust_name,city, grade, salesman_id.
select * from customer where grade is not null;

-- 22. write a SQL query to locate the employees whose last name begins with the letter 'D'. 
-- Return emp_idno, emp_fname, emp_lname and emp_dept. 
select * from employees_table where emp_lname like 'd%';
