-- =====================================================================
-- 🎓 SQL LEARNING JOURNEY - A PROGRESSIVE SQL TUTORIAL
-- =====================================================================
-- Purpose: Learn SQL concepts from basic to advanced with practice questions
-- =====================================================================

-- =========================
-- 📌 SECTION 1: DATABASE FUNDAMENTALS
-- =========================

-- Question: How do you create a new database in SQL?
-- CREATE DATABASE IF NOT EXISTS database_name;

-- Let's create our learning database
CREATE DATABASE IF NOT EXISTS sql_learning;

-- Question: How do you select a database to use for your SQL commands?
-- USE database_name;

-- Select our learning database
USE sql_learning;

-- Question: How can you see all available databases on the server?
-- SHOW DATABASES;

-- Question: How would you safely remove a database if needed?
-- DROP DATABASE IF EXISTS database_name; -- Use with extreme caution!

-- =========================
-- 📌 SECTION 2: TABLE CREATION (DDL)
-- =========================

-- Question: How do you create a table with various data types and constraints?
-- CREATE TABLE table_name (
--   column definitions,
--   constraints
-- );

-- Let's create a students table with various column types and constraints
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary key with auto-increment
    first_name VARCHAR(50) NOT NULL,            -- Text field that cannot be empty
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,                         -- Date field
    email VARCHAR(100) UNIQUE,                  -- Text field with uniqueness constraint
    gender ENUM('Male', 'Female', 'Other'),     -- Enumerated values only
    cgpa DECIMAL(3,2) CHECK (cgpa >= 0 AND cgpa <= 10), -- Number with check constraint
    is_active BOOLEAN DEFAULT TRUE,             -- Boolean with default value
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Automatic timestamp
);

-- Question: How do you create a table that has a relationship with another table?
-- Use FOREIGN KEY constraint to establish relationships

-- Create a departments table first
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    hod_name VARCHAR(100),
    established_date DATE
);

-- Create a courses table with a foreign key to departments
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT DEFAULT 3,
    department_id INT,
    description TEXT,
    
    -- Foreign key relationship
    FOREIGN KEY (department_id) REFERENCES departments(department_id) 
        ON DELETE SET NULL -- If department is deleted, set to NULL here
);

-- Question: How do you create a many-to-many relationship between tables?
-- Use a junction/bridge table with foreign keys to both related tables

-- Create an enrollments table (junction table for students and courses)
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade VARCHAR(2),
    
    -- Foreign keys to both tables
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE, -- If a student is deleted, delete their enrollments
        
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE, -- If a course is deleted, delete related enrollments
        
    -- Prevent duplicate enrollments
    UNIQUE KEY (student_id, course_id)
);

-- Question: How do you view the structure of an existing table?
-- DESCRIBE table_name;

-- Question: How do you modify a table to add a new column?
-- ALTER TABLE table_name ADD COLUMN column_name data_type [constraints];

ALTER TABLE students 
ADD COLUMN country VARCHAR(50) DEFAULT 'India';

-- Question: How do you modify an existing column's data type or constraints?
-- ALTER TABLE table_name MODIFY COLUMN column_name new_data_type [new_constraints];

-- Question: How do you rename a column?
-- ALTER TABLE table_name CHANGE COLUMN old_name new_name data_type [constraints];

-- Question: How do you remove a column from a table?
-- ALTER TABLE table_name DROP COLUMN column_name;

-- Question: How do you add a constraint to an existing table?
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_definition;

-- =========================
-- 📌 SECTION 3: INSERTING DATA (DML)
-- =========================

-- Question: How do you insert a single row into a table?
-- INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);

INSERT INTO departments (department_name, hod_name, established_date) 
VALUES ('Computer Science', 'Dr. Rajesh Kumar', '2010-06-15');

-- Question: How do you insert multiple rows at once?
-- INSERT INTO table_name (columns) VALUES (row1_values), (row2_values), ...;

INSERT INTO departments (department_name, hod_name, established_date) VALUES 
('Data Science', 'Dr. Priya Singh', '2015-07-20'),
('Information Technology', 'Dr. Amit Verma', '2012-04-10'),
('Artificial Intelligence', 'Dr. Sneha Patel', '2018-08-05');

-- Question: How do you insert data into a table with relationships?
-- First ensure the referenced data exists, then insert with foreign key values

INSERT INTO courses (course_code, course_name, credits, department_id, description) VALUES
('CS101', 'Introduction to Programming', 4, 1, 'Fundamentals of programming using Python'),
('DS101', 'Fundamentals of Data Science', 4, 2, 'Introduction to data science concepts'),
('IT101', 'Computer Networks', 3, 3, 'Principles of computer networking');

-- Question: How do you insert student data and their course enrollments?
-- First insert the student, then insert enrollments

INSERT INTO students (first_name, last_name, date_of_birth, email, gender, cgpa) VALUES
('Rahul', 'Sharma', '2000-05-15', 'rahul.sharma@example.com', 'Male', 8.5),
('Priya', 'Patel', '2001-03-22', 'priya.patel@example.com', 'Female', 9.2);

INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),  -- Rahul enrolled in Intro to Programming
(1, 3, 'B+'), -- Rahul enrolled in Computer Networks
(2, 1, 'A+'), -- Priya enrolled in Intro to Programming
(2, 2, 'A-'); -- Priya enrolled in Data Science

-- Question: How do you insert data from one table into another?
-- INSERT INTO target_table (columns) SELECT columns FROM source_table WHERE conditions;

-- =========================
-- 📌 SECTION 4: BASIC QUERIES (DQL)
-- =========================

-- Question: How do you retrieve all columns and rows from a table?
-- SELECT * FROM table_name;

-- Question: How do you retrieve specific columns from a table?
-- SELECT column1, column2, ... FROM table_name;

SELECT first_name, last_name, email, cgpa FROM students;

-- Question: How do you rename columns in the query results?
-- SELECT column AS "New Name" FROM table_name;

SELECT 
    first_name AS "First Name", 
    last_name AS "Last Name",
    cgpa AS "CGPA Score"
FROM students;

-- Question: How do you filter data based on specific conditions?
-- SELECT columns FROM table_name WHERE condition;

-- Retrieve students with CGPA greater than 9.0
SELECT * FROM students WHERE cgpa > 9.0;

-- Question: How do you use multiple conditions in a WHERE clause?
-- SELECT columns FROM table_name WHERE condition1 AND/OR condition2;

-- Students who are male and have CGPA > 8.0
SELECT * FROM students 
WHERE gender = 'Male' AND cgpa > 8.0;

-- Question: How do you match against multiple possible values?
-- SELECT columns FROM table_name WHERE column IN (value1, value2, ...);

-- Question: How do you find values within a specific range?
-- SELECT columns FROM table_name WHERE column BETWEEN value1 AND value2;

-- Question: How do you search for patterns in text data?
-- SELECT columns FROM table_name WHERE column LIKE pattern;
-- % = any number of characters, _ = single character

-- Names starting with 'P'
SELECT * FROM students 
WHERE first_name LIKE 'P%';

-- Question: How do you check for NULL or NOT NULL values?
-- SELECT columns FROM table_name WHERE column IS NULL;
-- SELECT columns FROM table_name WHERE column IS NOT NULL;

-- Question: How do you sort query results?
-- SELECT columns FROM table_name ORDER BY column1 [ASC|DESC], column2 [ASC|DESC];

-- Sort students by CGPA in descending order (highest first)
SELECT * FROM students 
ORDER BY cgpa DESC;

-- Question: How do you limit the number of results returned?
-- SELECT columns FROM table_name LIMIT number;

-- Get the top 3 students by CGPA
SELECT * FROM students 
ORDER BY cgpa DESC
LIMIT 3;

-- Question: How do you implement pagination?
-- SELECT columns FROM table_name LIMIT count OFFSET skip;

-- Question: How do you eliminate duplicate values from results?
-- SELECT DISTINCT column FROM table_name;

-- =========================
-- 📌 SECTION 5: AGGREGATE FUNCTIONS
-- =========================

-- Question: How do you count the number of rows in a table?
-- SELECT COUNT(*) FROM table_name;

SELECT COUNT(*) AS total_students FROM students;

-- Question: How do you count non-NULL values in a specific column?
-- SELECT COUNT(column_name) FROM table_name;

-- Question: How do you count rows that match specific criteria?
-- SELECT COUNT(*) FROM table_name WHERE condition;

SELECT COUNT(*) AS high_cgpa_count 
FROM students 
WHERE cgpa > 8.5;

-- Question: How do you calculate the sum of values in a column?
-- SELECT SUM(column_name) FROM table_name;

SELECT SUM(credits) AS total_credits FROM courses;

-- Question: How do you calculate the average value in a column?
-- SELECT AVG(column_name) FROM table_name;

SELECT AVG(cgpa) AS average_cgpa FROM students;

-- Question: How do you find the minimum and maximum values in a column?
-- SELECT MIN(column_name), MAX(column_name) FROM table_name;

SELECT 
    MIN(cgpa) AS lowest_cgpa,
    MAX(cgpa) AS highest_cgpa
FROM students;

-- Question: How do you group data and perform calculations on each group?
-- SELECT group_column, aggregate_function(column) FROM table_name GROUP BY group_column;

-- Average CGPA by gender
SELECT gender, AVG(cgpa) AS average_cgpa
FROM students
GROUP BY gender;

-- Question: How do you filter groups based on aggregate results?
-- SELECT columns FROM table_name GROUP BY columns HAVING aggregate_condition;

-- Find departments with more than one course
SELECT 
    department_id, 
    COUNT(*) AS course_count
FROM courses
GROUP BY department_id
HAVING COUNT(*) > 1;

-- =========================
-- 📌 SECTION 6: JOINS AND RELATIONSHIPS
-- =========================

-- Question: How do you combine data from multiple related tables?
-- SELECT columns FROM table1 JOIN table2 ON table1.column = table2.column;

-- Question: How do you perform an INNER JOIN to get only matching records?
-- SELECT columns FROM table1 INNER JOIN table2 ON table1.column = table2.column;

-- Get students and their enrolled courses (only matches)
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_code,
    c.course_name,
    e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- Question: How do you perform a LEFT JOIN to get all records from the left table?
-- SELECT columns FROM table1 LEFT JOIN table2 ON table1.column = table2.column;

-- Get all students and their enrollments (even students with no enrollments)
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;

-- Question: How do you perform a RIGHT JOIN to get all records from the right table?
-- SELECT columns FROM table1 RIGHT JOIN table2 ON table1.column = table2.column;

-- Question: How would you simulate a FULL OUTER JOIN in MySQL?
-- Use UNION of LEFT and RIGHT JOINs

-- Question: How do you join a table to itself (self-join)?
-- SELECT columns FROM table1 a JOIN table1 b ON a.column = b.related_column;

-- =========================
-- 📌 SECTION 7: SUBQUERIES
-- =========================

-- Question: How do you write a query inside another query?
-- SELECT columns FROM table1 WHERE column operator (SELECT column FROM table2);

-- Find students with above-average CGPA
SELECT first_name, last_name, cgpa
FROM students
WHERE cgpa > (SELECT AVG(cgpa) FROM students);

-- Question: How do you use IN with a subquery to match multiple values?
-- SELECT columns FROM table1 WHERE column IN (SELECT column FROM table2);

-- Find all courses taken by student with ID 1
SELECT course_code, course_name
FROM courses
WHERE course_id IN (
    SELECT course_id
    FROM enrollments
    WHERE student_id = 1
);

-- Question: How do you use a subquery in the FROM clause (derived table)?
-- SELECT columns FROM (SELECT columns FROM table) AS alias;

-- Get gender-based average CGPA only for groups with high average
SELECT avg_cgpa_by_gender.gender, avg_cgpa_by_gender.average_cgpa
FROM (
    SELECT gender, AVG(cgpa) AS average_cgpa
    FROM students
    GROUP BY gender
) AS avg_cgpa_by_gender
WHERE avg_cgpa_by_gender.average_cgpa > 8.0;

-- Question: How do you write a correlated subquery that references the outer query?
-- SELECT columns FROM table1 t1 WHERE column operator (SELECT column FROM table2 t2 WHERE t2.column = t1.column);

-- Find students who have at least one A+ grade
SELECT s.first_name, s.last_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id AND e.grade = 'A+'
);

-- =========================
-- 📌 SECTION 8: COMMON TABLE EXPRESSIONS (CTEs)
-- =========================

-- Question: How do you create a temporary result set that can be referenced within a query?
-- WITH cte_name AS (SELECT statement) SELECT columns FROM cte_name;

-- Find students and their grades using a CTE
WITH StudentGrades AS (
    SELECT 
        s.student_id,
        s.first_name,
        s.last_name,
        e.grade,
        c.course_name
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
)
SELECT * FROM StudentGrades WHERE grade = 'A+';

-- Question: How do you create multiple CTEs in the same query?
-- WITH cte1 AS (SELECT...), cte2 AS (SELECT...) SELECT columns FROM cte1, cte2;

-- Question: How do you create a recursive CTE to handle hierarchical data?
-- WITH RECURSIVE cte_name AS (base_query UNION ALL recursive_query) SELECT columns FROM cte_name;

-- =========================
-- 📌 SECTION 9: UPDATING DATA
-- =========================

-- Question: How do you update data in a table?
-- UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;

-- Update a student's CGPA
UPDATE students
SET cgpa = 9.5
WHERE student_id = 1;

-- Question: How do you update multiple columns at once?
-- UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;

-- Question: How do you perform calculations in an UPDATE statement?
-- UPDATE table_name SET column = column + value WHERE condition;

-- Increase all students' CGPA by 0.1 if below 9.0
UPDATE students
SET cgpa = cgpa + 0.1
WHERE cgpa < 9.0;

-- Question: How do you update data using values from another table?
-- UPDATE table1 JOIN table2 ON table1.column = table2.column SET table1.column = table2.column WHERE condition;

-- =========================
-- 📌 SECTION 10: DELETING DATA
-- =========================

-- Question: How do you delete specific rows from a table?
-- DELETE FROM table_name WHERE condition;

-- First, add a test student
INSERT INTO students (first_name, last_name, email, cgpa)
VALUES ('Test', 'Student', 'test.student@example.com', 5.0);

-- Then delete the test student
DELETE FROM students
WHERE first_name = 'Test' AND last_name = 'Student';

-- Question: How do you delete data using JOIN conditions?
-- DELETE t1 FROM table1 t1 JOIN table2 t2 ON t1.column = t2.column WHERE condition;

-- Question: How do you delete data using a subquery?
-- DELETE FROM table1 WHERE column IN (SELECT column FROM table2 WHERE condition);

-- =========================
-- 📌 SECTION 11: FUNCTIONS AND EXPRESSIONS
-- =========================

-- Question: How do you manipulate string data in SQL?
-- Use string functions like CONCAT(), UPPER(), LOWER(), LENGTH(), SUBSTRING(), REPLACE()

SELECT 
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    UPPER(first_name) AS uppercase_first,
    LOWER(last_name) AS lowercase_last,
    LENGTH(first_name) AS name_length
FROM students;

-- Question: How do you perform mathematical operations in SQL?
-- Use mathematical functions like ROUND(), CEIL(), FLOOR(), ABS(), POWER()

SELECT 
    credits,
    credits * 15 AS hours_per_semester,
    ROUND(AVG(credits), 1) AS rounded_avg,
    POWER(credits, 2) AS credits_squared
FROM courses
GROUP BY credits;

-- Question: How do you work with dates in SQL?
-- Use date functions like DATE_ADD(), DATEDIFF(), YEAR(), MONTH(), DAY()

SELECT 
    enrollment_date,
    DATE_ADD(enrollment_date, INTERVAL 6 MONTH) AS six_months_later,
    DATEDIFF(CURRENT_DATE, enrollment_date) AS days_enrolled,
    YEAR(enrollment_date) AS enrollment_year
FROM enrollments;

-- Question: How do you use conditional logic in SQL?
-- Use CASE expressions

SELECT 
    student_id,
    first_name,
    last_name,
    cgpa,
    CASE 
        WHEN cgpa >= 9.0 THEN 'Excellent'
        WHEN cgpa >= 8.0 THEN 'Very Good'
        WHEN cgpa >= 7.0 THEN 'Good'
        ELSE 'Average'
    END AS performance
FROM students;

-- =========================
-- 📌 SECTION 12: VIEWS
-- =========================

-- Question: How do you create a virtual table (view) based on a SELECT query?
-- CREATE VIEW view_name AS SELECT statement;

-- Create a view for student course information
CREATE OR REPLACE VIEW student_course_view AS
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Question: How do you query data from a view?
-- SELECT columns FROM view_name;

SELECT * FROM student_course_view
WHERE grade = 'A+';

-- Question: How do you create a view with calculated columns?
-- CREATE VIEW view_name AS SELECT columns, expressions AS alias FROM tables;

-- Question: How do you update data through a view?
-- Can only update simple views: UPDATE view_name SET column = value WHERE condition;

-- =========================
-- 📌 SECTION 13: STORED PROCEDURES
-- =========================

-- Question: How do you create a reusable SQL code block (stored procedure)?
-- CREATE PROCEDURE procedure_name() BEGIN SQL statements; END;

DELIMITER //
CREATE PROCEDURE GetAllStudents()
BEGIN
    SELECT * FROM students;
END //
DELIMITER ;

-- Question: How do you execute a stored procedure?
-- CALL procedure_name();

CALL GetAllStudents();

-- Question: How do you create a procedure that accepts input parameters?
-- CREATE PROCEDURE procedure_name(IN param_name param_type) BEGIN SQL statements; END;

DELIMITER //
CREATE PROCEDURE GetStudentsByGrade(IN grade_param VARCHAR(2))
BEGIN
    SELECT 
        s.student_id,
        s.first_name,
        s.last_name,
        c.course_name,
        e.grade
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.grade = grade_param;
END //
DELIMITER ;

-- Question: How do you create a procedure that returns output values?
-- CREATE PROCEDURE procedure_name(OUT param_name param_type) BEGIN SET param_name = value; END;

DELIMITER //
CREATE PROCEDURE GetDepartmentStats(
    IN dept_id INT,
    OUT course_count INT,
    OUT avg_credits DECIMAL(5,2)
)
BEGIN
    SELECT 
        COUNT(*), 
        AVG(credits)
    INTO 
        course_count, 
        avg_credits
    FROM courses
    WHERE department_id = dept_id;
END //
DELIMITER ;

-- =========================
-- 📌 SECTION 14: FUNCTIONS
-- =========================

-- Question: How do you create a custom function that returns a single value?
-- CREATE FUNCTION function_name(parameters) RETURNS return_type BEGIN SQL statements; RETURN value; END;

DELIMITER //
CREATE FUNCTION CalculateGrade(score DECIMAL(5,2)) 
RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
    DECLARE grade VARCHAR(2);
    
    IF score >= 90 THEN
        SET grade = 'A+';
    ELSEIF score >= 85 THEN
        SET grade = 'A';
    ELSEIF score >= 80 THEN
        SET grade = 'A-';
    ELSEIF score >= 75 THEN
        SET grade = 'B+';
    ELSEIF score >= 70 THEN
        SET grade = 'B';
    ELSE
        SET grade = 'C';
    END IF;
    
    RETURN grade;
END //
DELIMITER ;

-- Question: How do you use a custom function in a query?
-- SELECT function_name(value) FROM table_name;

SELECT CalculateGrade(92) AS grade;

-- =========================
-- 📌 SECTION 15: TRIGGERS
-- =========================

-- Question: How do you create code that automatically runs when a table is modified?
-- CREATE TRIGGER trigger_name BEFORE/AFTER INSERT/UPDATE/DELETE ON table_name FOR EACH ROW BEGIN statements; END;

-- Create an audit table for tracking changes
CREATE TABLE student_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    action_type VARCHAR(10) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details JSON
);

-- Question: How do you create an AFTER INSERT trigger?
-- CREATE TRIGGER trigger_name AFTER INSERT ON table_name FOR EACH ROW BEGIN statements; END;

DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_audit (student_id, action_type, details)
    VALUES (
        NEW.student_id,
        'INSERT',
        JSON_OBJECT(
            'first_name', NEW.first_name,
            'last_name', NEW.last_name,
            'email', NEW.email
        )
    );
END //
DELIMITER ;

-- Question: How do you create an AFTER UPDATE trigger?
-- CREATE TRIGGER trigger_name AFTER UPDATE ON table_name FOR EACH ROW BEGIN statements; END;

-- Question: How do you create a BEFORE INSERT trigger for validation?
-- CREATE TRIGGER trigger_name BEFORE INSERT ON table_name FOR EACH ROW BEGIN validation_logic; END;

-- =========================
-- 📌 SECTION 16: TRANSACTIONS
-- =========================

-- Question: How do you ensure multiple SQL statements are executed as a single unit?
-- START TRANSACTION; statements; COMMIT; (or ROLLBACK to undo)

START TRANSACTION;

    -- Insert a new student
    INSERT INTO students (first_name, last_name, email, cgpa)
    VALUES ('Transaction', 'Test', 'transaction.test@example.com', 8.2);
    
    -- Get the new student ID
    SET @new_student_id = LAST_INSERT_ID();
    
    -- Enroll the student in a course
    INSERT INTO enrollments (student_id, course_id, enrollment_date)
    VALUES (@new_student_id, 1, CURDATE());

COMMIT;  -- or ROLLBACK to undo

-- Question: How do you handle errors in transactions?
-- START TRANSACTION; statements; IF error THEN ROLLBACK; ELSE COMMIT; END IF;

-- =========================
-- 📌 SECTION 17: INDEXES
-- =========================

-- Question: How do you create an index to improve query performance?
-- CREATE INDEX index_name ON table_name(column);

CREATE INDEX idx_student_email ON students(email);

-- Question: How do you create a composite index on multiple columns?
-- CREATE INDEX index_name ON table_name(column1, column2);

CREATE INDEX idx_enrollment_student_course ON enrollments(student_id, course_id);

-- Question: How do you create a unique index?
-- CREATE UNIQUE INDEX index_name ON table_name(column);

-- Question: How do you create a fulltext index for text searching?
-- CREATE FULLTEXT INDEX index_name ON table_name(column1, column2);

-- =========================
-- 📌 SECTION 18: ADVANCED SQL FEATURES
-- =========================

-- Question: How do you use window functions to perform calculations across rows?
-- SELECT column, aggregate_function() OVER (PARTITION BY column ORDER BY column) FROM table;

-- Create a table for demonstrating window functions
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sale_date DATE,
    amount DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO sales (product_name, category, sale_date, amount) VALUES
('Laptop', 'Electronics', '2023-01-05', 75000.00),
('Smartphone', 'Electronics', '2023-01-12', 45000.00),
('Office Chair', 'Furniture', '2023-01-08', 12000.00),
('Desk', 'Furniture', '2023-01-15', 25000.00);

-- Window function example
SELECT 
    sale_id,
    product_name,
    category,
    amount,
    SUM(amount) OVER() AS total_sales,
    SUM(amount) OVER(PARTITION BY category) AS category_total,
    RANK() OVER(PARTITION BY category ORDER BY amount DESC) AS category_rank
FROM sales;

-- Question: How do you work with JSON data in MySQL?
-- Use JSON functions like JSON_EXTRACT, JSON_OBJECT, etc.

ALTER TABLE students ADD COLUMN preferences JSON;

UPDATE students
SET preferences = '{"theme": "dark", "notifications": true}'
WHERE student_id = 1;

SELECT 
    student_id,
    first_name,
    JSON_EXTRACT(preferences, '$.theme') AS theme,
    JSON_EXTRACT(preferences, '$.notifications') AS notifications
FROM students
WHERE preferences IS NOT NULL;

-- Question: How do you create a pivot table in SQL?
-- Use conditional aggregation with CASE statements

SELECT 
    category,
    SUM(CASE WHEN MONTH(sale_date) = 1 THEN amount ELSE 0 END) AS January
FROM sales
GROUP BY category;

-- =========================
-- 📌 SECTION 19: OPTIMIZATION TECHNIQUES
-- =========================

-- Question: How do you analyze a query execution plan?
-- EXPLAIN SELECT statement;

EXPLAIN
SELECT 
    s.first_name,
    s.last_name,
    c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.cgpa > 8.0;

-- Question: How can you make your queries more efficient?
-- 1. Use appropriate indexes
-- 2. Avoid SELECT *
-- 3. Be specific with WHERE clauses
-- 4. Use appropriate JOINs
-- 5. Limit result sets

-- Question: What are some best practices for SQL code organization?
-- 1. Use consistent naming conventions
-- 2. Add comments to explain complex queries
-- 3. Format SQL for readability
-- 4. Break complex queries into views or stored procedures
-- 5. Keep database schema diagrams updated

-- =========================
-- 📌 SECTION 20: PRACTICAL EXERCISES
-- =========================

-- Question: How would you create a comprehensive student transcript report?
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_name,
    c.credits,
    e.grade,
    CASE 
        WHEN e.grade = 'A+' THEN 10.0
        WHEN e.grade = 'A' THEN 9.0
        WHEN e.grade = 'A-' THEN 8.5
        WHEN e.grade = 'B+' THEN 8.0
        WHEN e.grade = 'B' THEN 7.0
        ELSE 6.0
    END AS grade_points,
    c.credits * CASE 
        WHEN e.grade = 'A+' THEN 10.0
        WHEN e.grade = 'A' THEN 9.0
        WHEN e.grade = 'A-' THEN 8.5
        WHEN e.grade = 'B+' THEN 8.0
        WHEN e.grade = 'B' THEN 7.0
        ELSE 6.0
    END AS weighted_points
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = 1  -- Change to the student you want
ORDER BY c.course_code;

-- Question: How would you perform a department performance analysis?
WITH CourseStats AS (
    SELECT 
        d.department_id,
        d.department_name,
        COUNT(DISTINCT c.course_id) AS course_count,
        COUNT(DISTINCT e.student_id) AS student_count,
        AVG(
            CASE
                WHEN e.grade = 'A+' THEN 10.0
                WHEN e.grade = 'A' THEN 9.0
                WHEN e.grade = 'A-' THEN 8.5
                WHEN e.grade = 'B+' THEN 8.0
                WHEN e.grade = 'B' THEN 7.0
                ELSE 6.0
            END
        ) AS avg_grade_points
    FROM departments d
    LEFT JOIN courses c ON d.department_id = c.department_id
    LEFT JOIN enrollments e ON c.course_id = e.course_id
    GROUP BY d.department_id, d.department_name
)
SELECT 
    department_name,
    course_count,
    student_count,
    ROUND(avg_grade_points, 2) AS average_grade,
    CASE 
        WHEN avg_grade_points >= 9.0 THEN 'Excellent'
        WHEN avg_grade_points >= 8.0 THEN 'Very Good'
        WHEN avg_grade_points >= 7.0 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS department_performance
FROM CourseStats
ORDER BY avg_grade_points DESC;

-- ======== END OF SQL LEARNING JOURNEY ========