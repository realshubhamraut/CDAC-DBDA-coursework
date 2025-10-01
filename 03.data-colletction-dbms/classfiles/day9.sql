-- Step 1: create & use database
CREATE DATABASE IF NOT EXISTS triggers;
USE triggers;

-- Step 2: drop tables in correct order
DROP TABLE IF EXISTS employee_email_log;
DROP TABLE IF EXISTS employee_log;
DROP TABLE IF EXISTS department_stats;
DROP TABLE IF EXISTS employee;

-- Step 3: create employee table
CREATE TABLE employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    salary DECIMAL(10,2),
    department_id INT
);

-- Step 4: logging table (general logs)
CREATE TABLE employee_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_message VARCHAR(255),
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 5: email log table
CREATE TABLE employee_email_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    email VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

-- Step 6: department stats table
CREATE TABLE department_stats (
    department_id INT PRIMARY KEY,
    total_employees INT DEFAULT 0,
    total_salary_budget DECIMAL(15,2) DEFAULT 0
);

-- ===========================================
-- 🔥 TRIGGERS
-- ===========================================

DELIMITER $$

-- 1. default salary if NULL
CREATE TRIGGER before_insert_default_salary
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.salary IS NULL THEN
        SET NEW.salary = 15000.00;
    END IF;
END$$

-- 2. default department if NULL
CREATE TRIGGER before_insert_default_department
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.department_id IS NULL THEN
        SET NEW.department_id = 100;
    END IF;
END$$

-- 3. log when row is inserted
CREATE TRIGGER after_employee_insert_log
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO employee_log (log_message)
    VALUES (CONCAT('A new employee has been inserted with ID: ', NEW.employee_id));
END$$

-- 4. prevent salary decrease
CREATE TRIGGER prevent_salary_decrease
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    IF NEW.salary < OLD.salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be decreased!';
    END IF;
END$$

-- 5. auto-generate email after insert
CREATE TRIGGER after_employee_insert_email
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO employee_email_log (employee_id, email)
    VALUES (NEW.employee_id, CONCAT(NEW.username, '@company.com'));
END$$

-- 6. update department stats on insert
CREATE TRIGGER after_employee_insert_stats
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO department_stats (department_id, total_employees, total_salary_budget)
    VALUES (NEW.department_id, 1, IFNULL(NEW.salary,0))
    ON DUPLICATE KEY UPDATE 
        total_employees = total_employees + 1,
        total_salary_budget = total_salary_budget + IFNULL(NEW.salary,0);
END$$

DELIMITER ;

-- ===========================================
-- TEST DATA
-- ===========================================

-- insert employees
INSERT INTO employee (name, username, salary, department_id)
VALUES ('Shubham Raut', 'shubham.r', 50000, 101);

INSERT INTO employee (name, username, salary, department_id)
VALUES ('Alexandra Lee', 'alex.lee', 60000, 101);

INSERT INTO employee (name, username, department_id)
VALUES ('Karen Smith', 'karen.smith', 102); -- salary will default to 15000

INSERT INTO employee (name, username)
VALUES ('Alice Johnson', 'alice.j'); -- dept=100, salary=15000

-- ===========================================
-- CHECK RESULTS
-- ===========================================
SELECT * FROM employee;
SELECT * FROM employee_log;
SELECT * FROM employee_email_log;
SELECT * FROM department_stats;