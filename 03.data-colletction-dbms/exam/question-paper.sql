
CREATE DATABASE IF NOT EXISTS shopdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shopdb;

CREATE TABLE customers (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(80) NOT NULL,
email VARCHAR(120) NOT NULL UNIQUE,
city VARCHAR(60) NOT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE products (
product_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
category VARCHAR(50) NOT NULL,
price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
stock_qty INT NOT NULL CHECK (stock_qty >= 0),
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
INDEX idx_products_category (category)
) ENGINE=InnoDB;

CREATE TABLE orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
status ENUM('NEW','PAID','SHIPPED','CANCELLED') NOT NULL DEFAULT 'NEW',
total_amount DECIMAL(12,2) NOT NULL DEFAULT 0,
CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
ON UPDATE CASCADE ON DELETE RESTRICT,
INDEX idx_orders_customer (customer_id),
INDEX idx_orders_date (order_date)
) ENGINE=InnoDB;

CREATE TABLE order_items (
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL CHECK (quantity > 0),
unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
PRIMARY KEY (order_id, product_id),
CONSTRAINT fk_oi_order
FOREIGN KEY (order_id) REFERENCES orders(order_id)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_oi_product
FOREIGN KEY (product_id) REFERENCES products(product_id)
ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;




INSERT INTO customers (full_name, email, city) VALUES
('Aditi Rao','aditi@example.com','Mumbai'),
('Rohan Das','rohan@example.com','Pune'),
('Meera Singh','meera@example.com','Delhi'),
('Imran Ali','imran@example.com','Mumbai');

INSERT INTO products (name, category, price, stock_qty) VALUES
('Wireless Mouse','Electronics',799.00, 50),
('Mechanical Keyboard','Electronics',3499.00, 30),
('Office Chair','Furniture',5999.00, 15),
('Notebook A5','Stationery',99.00, 200),
('Ball Pen Blue','Stationery',15.00, 500);

-- Orders (assorted dates/status)
INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2025-09-10 10:05:00', 'PAID', 0),
(1, '2025-09-15 12:30:00', 'SHIPPED', 0),
(2, '2025-09-20 09:45:00', 'NEW', 0),
(3, '2025-09-25 16:10:00', 'PAID', 0);

-- Order Items (assume unit_price snapped at time of order)
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 799.00), -- 2 Wireless Mouse
(1, 4, 5, 99.00), -- 5 Notebook A5
(2, 2, 1, 3499.00), -- 1 Mechanical Keyboard
(2, 5, 10, 15.00), -- 10 Ball Pen Blue
(3, 3, 1, 5999.00), -- 1 Office Chair
(4, 1, 1, 799.00), -- 1 Wireless Mouse
(4, 2, 1, 3499.00); -- 1 Mechanical Keyboard



sds  SET- 2O03                                            PG-DBDA ( Aug Batch)
 Date : 03/10/2025
—------------------------------------------------------------------------------------------------------------------------ 
Note: Submit a .sql file for MYSQL with its name as your PRN number_name 
(eg: 01_Rahul_Sinha.sql)
—------------------------------------------------------------------------------------------------------------------------ 
Section 1: (6 marks)
Write a CREATE TABLE statement for a table department(dept_id INT PK, dept_name VARCHAR(60) UNIQUE NOT NULL). Ensure: dept_id is the Primary Key and auto-increments. The storage engine is InnoDB.
Consider a table department(dept_id, dept_name). (a)Insert ('R&D') and ('Operations') (let the PK auto-generate). (b) Change dept_name='Operations' to dept_name='Ops' using UPDATE with a suitable filter.
 Retrieve all department details where dept_name starts with the letter 'O'.
—------------------------------------------------------------------------------------------------------------------------ 
Section 2 — Work on Given Schema (34 marks)
Add a column discount_pct DECIMAL(5,2) NOT NULL DEFAULT 0.00 to products. Then set discount_pct=10.00 for all products in the Stationery category. (2)

Rename column full_name in customers to name and increase name length to VARCHAR(120) in one statement if possible. Then update all customers in Mumbai to have city stored in uppercase. (2)

List order_id, name (customer), total_items (sum of quantities) and total_value (sum of quantity*unit_price) for all orders placed in September 2025. Order by total_value descending.(3)

Find the top 2 products by total revenue (sum of quantity*unit_price across all orders). Show product_id, name, revenue. Break ties by higher total quantity sold. (3)

Create a BEFORE INSERT trigger on the products table that automatically sets the price to 0.01 if someone tries to insert a product with a price of 0 or negative value.(5)

Write a stored procedure get_customer_orders(p_customer_id INT) that, given a customer id, retrieves the list of all their orders showing order_id, order_date, status, and total_amount, sorted by the most recent order first.
 Also show how you would call this procedure for customer_id = 1.  (5)

Create a deterministic function fn_order_total(p_order_id INT) returning DECIMAL(12,2) that computes SUM(quantity*unit_price) from order_items. Demonstrate using it in a SELECT to list order_id, fn_order_total(order_id) for all orders. (5)

Using a Common Table Expression (CTE), write a query that ranks employees based on their salary within each department. Show emp_id, emp_name, dept_id, salary, and rank_in_dept. (5)

Write a query to display each order’s ID, order date, customer name, and the number of different products included in that order. Only include orders that have more than 1 distinct product. Order the result by order date. (4)
