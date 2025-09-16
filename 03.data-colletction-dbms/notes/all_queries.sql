-- =====================================================================
-- 🎓 COMPREHENSIVE SQL TUTORIAL - CDAC DBDA COURSE
-- =====================================================================
-- Author: Database Instructor
-- Version: 2.0
-- Purpose: Learn SQL from basics to advanced concepts with practice questions
-- Last Updated: September 16, 2025
-- =====================================================================

-- =========================
-- 📌 SECTION 1: DATABASE FUNDAMENTALS
-- =========================

-- Question: How do you create a new database in SQL?
CREATE DATABASE IF NOT EXISTS cdac_tutorial;

-- Question: How do you select a specific database to work with?
USE cdac_tutorial;

-- Question: How can you see all the databases on the server?
SHOW DATABASES;

-- Question: How would you safely remove a database if needed?
-- DROP DATABASE IF EXISTS database_name;  -- Commented out for safety (USE WITH CAUTION!)

-- =========================
-- 📌 SECTION 2: TABLE CREATION (DDL - Data Definition Language)
-- =========================

-- Question: How do you create a table with various data types and constraints?
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary key with auto-increment
    first_name VARCHAR(50) NOT NULL,            -- Text field that cannot be empty
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,                         -- Date field
    email VARCHAR(100) UNIQUE,                  -- Text field with uniqueness constraint
    phone VARCHAR(15),
    gender ENUM('Male', 'Female', 'Other'),     -- Enumerated values only
    enrollment_date DATE DEFAULT (CURRENT_DATE),-- Default value is current date
    is_active BOOLEAN DEFAULT TRUE,             -- Boolean with default value
    cgpa DECIMAL(3,2),                          -- Numeric with precision (e.g., 9.45)
    address TEXT,                               -- For larger text content
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Auto timestamp on creation
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Auto updates on changes
);

-- Question: How do you create a table with appropriate data types for different purposes?
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,  -- Department names must be unique
    hod_name VARCHAR(100),                         -- Head of Department
    office_location VARCHAR(50),
    contact_email VARCHAR(100),
    established_date DATE,
    budget DECIMAL(12,2) DEFAULT 0.00              -- Large decimal for monetary values
);

-- Question: How do you create a table with foreign key relationships?
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT DEFAULT 3,
    department_id INT,                          -- Will reference departments table
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Creating a relationship between tables
    FOREIGN KEY (department_id) REFERENCES departments(department_id) 
        ON DELETE SET NULL                      -- If department deleted, set to NULL here
);

-- Question: How do you create a many-to-many relationship between tables?
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade VARCHAR(2),
    status VARCHAR(20) DEFAULT 'Active',
    feedback TEXT,
    
    -- Creating relationship to students table
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,                      -- If student deleted, remove their enrollments
        
    -- Creating relationship to courses table
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE,                      -- If course deleted, remove related enrollments
        
    -- Preventing duplicate enrollments
    UNIQUE KEY (student_id, course_id)
);

-- Question: How do you view the structure of an existing table?
DESCRIBE students;  -- Shows all columns and their properties

-- Question: How do you see the complete table creation statement?
SHOW CREATE TABLE students;

-- Question: How do you add a new column to an existing table?
ALTER TABLE students 
ADD COLUMN nationality VARCHAR(50) DEFAULT 'Indian';

-- Question: How do you modify an existing column's properties?
ALTER TABLE students
MODIFY COLUMN phone VARCHAR(20);  -- Changed from VARCHAR(15) to VARCHAR(20)

-- Question: How do you rename a column in a table?
ALTER TABLE students
CHANGE COLUMN nationality country VARCHAR(50) DEFAULT 'India';

-- Question: How do you remove a column from a table?
-- ALTER TABLE students
-- DROP COLUMN address;

-- Question: How do you add a constraint to an existing table?
ALTER TABLE students
ADD CONSTRAINT check_cgpa CHECK (cgpa >= 0 AND cgpa <= 10);

-- =========================
-- 📌 SECTION 3: INSERTING DATA (DML - Data Manipulation Language)
-- =========================

-- Question: How do you insert a single row into a table?
INSERT INTO departments (department_name, hod_name, office_location, established_date, budget)
VALUES ('Computer Science', 'Dr. Rajesh Kumar', 'Block A, Room 101', '2010-06-15', 5000000.00);

-- Question: How do you insert multiple rows at once?
INSERT INTO departments (department_name, hod_name, office_location, established_date, budget) VALUES 
('Data Science', 'Dr. Priya Singh', 'Block B, Room 201', '2015-07-20', 6000000.00),
('Information Technology', 'Dr. Amit Verma', 'Block A, Room 105', '2012-04-10', 4500000.00),
('Artificial Intelligence', 'Dr. Sneha Patel', 'Block C, Room 301', '2018-08-05', 7000000.00),
('Database Management', 'Dr. Vikram Singh', 'Block B, Room 205', '2014-03-15', 4000000.00);

-- Question: How do you insert data with foreign key relationships?
INSERT INTO courses (course_code, course_name, credits, department_id, description) VALUES
('CS101', 'Introduction to Programming', 4, 1, 'Fundamentals of programming using C and Python'),
('DS101', 'Fundamentals of Data Science', 4, 2, 'Introduction to data science concepts and tools'),
('IT101', 'Computer Networks', 3, 3, 'Principles of computer networking and protocols'),
('AI101', 'Introduction to Artificial Intelligence', 4, 4, 'Foundations of AI and intelligent systems'),
('DB101', 'Database Management Systems', 4, 5, 'Fundamentals of database design and SQL'),
('CS201', 'Data Structures', 4, 1, 'Study of fundamental data structures and algorithms'),
('DS201', 'Statistical Methods for Data Science', 3, 2, 'Statistical foundations for data analysis'),
('DB201', 'Advanced Database Concepts', 3, 5, 'Advanced topics in database management');

-- Question: How do you insert data for entities with relationships?
INSERT INTO students (first_name, last_name, date_of_birth, email, phone, gender, cgpa, address) VALUES
('Rahul', 'Sharma', '2000-05-15', 'rahul.sharma@example.com', '9876543210', 'Male', 8.5, 'Mumbai, Maharashtra'),
('Priya', 'Patel', '2001-03-22', 'priya.patel@example.com', '9876543211', 'Female', 9.2, 'Pune, Maharashtra'),
('Amit', 'Kumar', '1999-11-10', 'amit.kumar@example.com', '9876543212', 'Male', 7.8, 'Delhi, Delhi'),
('Neha', 'Singh', '2000-07-05', 'neha.singh@example.com', '9876543213', 'Female', 8.9, 'Bangalore, Karnataka'),
('Vikram', 'Joshi', '1998-09-18', 'vikram.joshi@example.com', '9876543214', 'Male', 8.1, 'Chennai, Tamil Nadu');

-- Question: How do you insert data into a junction table to establish relationships?
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade) VALUES
(1, 1, '2023-01-15', 'A'),  -- Rahul enrolled in Intro to Programming
(1, 6, '2023-01-15', 'B+'), -- Rahul enrolled in Data Structures
(2, 1, '2023-01-15', 'A+'), -- Priya enrolled in Intro to Programming
(2, 4, '2023-01-15', 'A-'), -- Priya enrolled in Intro to AI
(3, 2, '2023-01-15', 'B'),  -- Amit enrolled in Data Science
(3, 7, '2023-01-15', 'B+'), -- Amit enrolled in Statistical Methods
(4, 3, '2023-01-15', 'A'),  -- Neha enrolled in Computer Networks
(4, 5, '2023-01-15', 'A-'), -- Neha enrolled in DBMS
(5, 5, '2023-01-15', 'B+'), -- Vikram enrolled in DBMS
(5, 8, '2023-01-15', 'A');  -- Vikram enrolled in Advanced Database

-- Question: How do you insert data from another table or query result?
-- First, create a temporary table
CREATE TABLE temp_students (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    cgpa DECIMAL(3,2)
);

-- Insert some data into the temp table
INSERT INTO temp_students VALUES
('Ananya', 'Desai', 'ananya.desai@example.com', 8.7),
('Rohan', 'Verma', 'rohan.verma@example.com', 7.5);

-- Insert from temp_students into students
INSERT INTO students (first_name, last_name, email, cgpa, gender)
SELECT 
    first_name, 
    last_name, 
    email, 
    cgpa,
    'Male' -- Default gender for demonstration
FROM temp_students;

-- Clean up the temporary table
DROP TABLE temp_students;

-- =========================
-- 📌 SECTION 4: BASIC QUERIES (DQL - Data Query Language)
-- =========================

-- Question: How do you retrieve all columns and rows from a table?
SELECT * FROM students;

-- Question: How do you retrieve specific columns from a table?
SELECT first_name, last_name, email, cgpa FROM students;

-- Question: How do you rename columns in query results?
SELECT 
    first_name AS "First Name", 
    last_name AS "Last Name",
    cgpa AS "CGPA Score"
FROM students;

-- Question: How do you filter data using simple conditions?
SELECT * FROM students WHERE gender = 'Female';

-- Question: How do you use comparison operators in queries?
SELECT * FROM students WHERE cgpa > 8.5;
SELECT * FROM students WHERE date_of_birth >= '2000-01-01';

-- Question: How do you combine multiple conditions?
SELECT * FROM students 
WHERE gender = 'Male' AND cgpa > 8.0;

SELECT * FROM students 
WHERE cgpa > 9.0 OR date_of_birth > '2000-01-01';

-- Question: How do you match against multiple possible values?
SELECT * FROM students 
WHERE student_id IN (1, 3, 5);

-- Question: How do you find values within a range?
SELECT * FROM students 
WHERE cgpa BETWEEN 8.0 AND 9.0;

-- Question: How do you search for patterns in text?
-- % = wildcard for any number of characters
-- _ = wildcard for exactly one character
SELECT * FROM students 
WHERE first_name LIKE 'A%';  -- Names starting with 'A'

SELECT * FROM students 
WHERE email LIKE '%@example.com';  -- Emails ending with @example.com

SELECT * FROM students 
WHERE last_name LIKE 'S_____';  -- Last names starting with S and exactly 6 letters

-- Question: How do you check for NULL or NOT NULL values?
SELECT * FROM students 
WHERE date_of_birth IS NULL;

SELECT * FROM students 
WHERE date_of_birth IS NOT NULL;

-- Question: How do you sort query results?
SELECT * FROM students 
ORDER BY cgpa DESC;  -- Descending order (highest to lowest)

SELECT * FROM students 
ORDER BY last_name ASC, first_name ASC;  -- Sort by last name, then first name

-- Question: How do you limit the number of rows returned?
SELECT * FROM students 
ORDER BY cgpa DESC
LIMIT 3;  -- Top 3 students by CGPA

-- Question: How do you implement pagination with LIMIT and OFFSET?
SELECT * FROM students 
ORDER BY student_id
LIMIT 2 OFFSET 2;  -- Skip first 2 students, show next 2

-- Question: How do you eliminate duplicate values from results?
SELECT DISTINCT gender FROM students;

-- =========================
-- 📌 SECTION 5: AGGREGATE FUNCTIONS
-- =========================

-- Question: How do you count the total number of rows in a table?
SELECT COUNT(*) AS total_students FROM students;

-- Question: How do you count non-NULL values in a specific column?
SELECT COUNT(date_of_birth) AS students_with_dob FROM students;

-- Question: How do you count rows that match a condition?
SELECT COUNT(*) AS male_students FROM students WHERE gender = 'Male';

-- Question: How do you sum numeric values in a column?
SELECT SUM(credits) AS total_credits FROM courses;

-- Question: How do you calculate the average of numeric values?
SELECT AVG(cgpa) AS average_cgpa FROM students;

-- Question: How do you find minimum and maximum values?
SELECT 
    MIN(cgpa) AS lowest_cgpa,
    MAX(cgpa) AS highest_cgpa
FROM students;

-- Question: How do you group data for aggregation?
SELECT gender, COUNT(*) AS count
FROM students
GROUP BY gender;

-- Question: How do you perform multiple aggregations by group?
SELECT 
    department_id, 
    COUNT(*) AS course_count,
    SUM(credits) AS total_credits
FROM courses
GROUP BY department_id;

-- Question: How do you filter groups based on aggregate results?
SELECT 
    department_id, 
    COUNT(*) AS course_count
FROM courses
GROUP BY department_id
HAVING COUNT(*) > 1;  -- Only departments with more than 1 course

-- Question: How do you sort aggregated results?
SELECT 
    department_id, 
    AVG(credits) AS avg_credits
FROM courses
GROUP BY department_id
ORDER BY avg_credits DESC;

-- =========================
-- 📌 SECTION 6: JOINS AND RELATIONSHIPS
-- =========================

-- Question: How do you combine data from multiple related tables?
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    e.course_id,
    c.course_name,
    e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- Question: How do you include all rows from the left table even without matches?
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    e.course_id,
    c.course_name,
    e.grade
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;

-- Question: How do you include all rows from the right table even without matches?
SELECT 
    c.course_id,
    c.course_name,
    e.student_id,
    s.first_name,
    s.last_name
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
LEFT JOIN students s ON e.student_id = s.student_id;

-- Question: How do you simulate a FULL OUTER JOIN in MySQL?
-- MySQL doesn't have FULL JOIN, but we can simulate it with UNION
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    e.course_id,
    c.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
UNION
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    e.course_id,
    c.course_name
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id IS NULL;

-- Question: How do you create a cartesian product of two tables?
SELECT 
    s.first_name,
    c.course_name
FROM students s
CROSS JOIN courses c
LIMIT 10;  -- Limiting results for demonstration

-- Question: How do you join a table to itself (self-join)?
-- First, create a table with self-referential relationship
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Insert some employee data
INSERT INTO employees (employee_id, first_name, last_name, manager_id) VALUES
(1, 'Rajesh', 'Kumar', NULL),  -- CEO, no manager
(2, 'Priya', 'Singh', 1),      -- Reports to CEO
(3, 'Vikram', 'Sharma', 1),    -- Reports to CEO
(4, 'Neha', 'Patel', 2),       -- Reports to Priya
(5, 'Amit', 'Verma', 2);       -- Reports to Priya

-- Self join to find employees and their managers
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- =========================
-- 📌 SECTION 7: SUBQUERIES
-- =========================

-- Question: How do you write a query inside another query?
-- Find students with above-average CGPA
SELECT first_name, last_name, cgpa
FROM students
WHERE cgpa > (SELECT AVG(cgpa) FROM students);

-- Question: How do you use a subquery with the IN operator?
-- Find all courses taken by student with ID 1
SELECT course_code, course_name
FROM courses
WHERE course_id IN (
    SELECT course_id
    FROM enrollments
    WHERE student_id = 1
);

-- Question: How do you use a subquery in the FROM clause (derived table)?
SELECT avg_cgpa_by_gender.gender, avg_cgpa_by_gender.average_cgpa
FROM (
    SELECT gender, AVG(cgpa) AS average_cgpa
    FROM students
    GROUP BY gender
) AS avg_cgpa_by_gender
WHERE avg_cgpa_by_gender.average_cgpa > 8.0;

-- Question: How do you use a correlated subquery?
-- Find students who have at least one grade of 'A+'
SELECT s.student_id, s.first_name, s.last_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id AND e.grade = 'A+'
);

-- Question: How do you use a subquery in the SELECT clause?
SELECT 
    d.department_id,
    d.department_name,
    (SELECT COUNT(*) FROM courses c WHERE c.department_id = d.department_id) AS course_count
FROM departments d;

-- Question: How do you use multiple levels of subqueries?
-- Find the department with the highest average course credits
SELECT 
    department_id,
    department_name
FROM departments
WHERE department_id = (
    SELECT department_id
    FROM (
        SELECT department_id, AVG(credits) AS avg_credits
        FROM courses
        GROUP BY department_id
        ORDER BY avg_credits DESC
        LIMIT 1
    ) AS highest_avg_dept
);

-- =========================
-- 📌 SECTION 8: COMMON TABLE EXPRESSIONS (CTEs)
-- =========================

-- Question: How do you create a temporary result set for reference in a query?
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
SELECT * FROM StudentGrades WHERE grade = 'A';

-- Question: How do you create multiple CTEs in the same query?
WITH 
    DepartmentCourseCount AS (
        SELECT 
            d.department_id,
            d.department_name,
            COUNT(c.course_id) AS course_count
        FROM departments d
        LEFT JOIN courses c ON d.department_id = c.department_id
        GROUP BY d.department_id, d.department_name
    ),
    TopDepartments AS (
        SELECT department_id, department_name, course_count
        FROM DepartmentCourseCount
        WHERE course_count > 1
    )
SELECT * FROM TopDepartments
ORDER BY course_count DESC;

-- Question: How do you create a recursive CTE for hierarchical data?
-- Generate a series of dates
WITH RECURSIVE DateSeries AS (
    SELECT CURDATE() AS date
    UNION ALL
    SELECT date + INTERVAL 1 DAY
    FROM DateSeries
    WHERE date < CURDATE() + INTERVAL 6 DAY
)
SELECT 
    date,
    DAYNAME(date) AS day_of_week
FROM DateSeries;

-- Question: How do you use recursive CTEs for organization hierarchies?
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case (all top-level managers)
    SELECT 
        employee_id, 
        first_name,
        last_name,
        manager_id,
        0 AS level,
        CONCAT(first_name, ' ', last_name) AS hierarchy_path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case (all direct reports)
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.manager_id,
        eh.level + 1,
        CONCAT(eh.hierarchy_path, ' > ', e.first_name, ' ', e.last_name)
    FROM employees e
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT 
    employee_id,
    first_name,
    last_name,
    level,
    hierarchy_path
FROM EmployeeHierarchy
ORDER BY level, first_name;

-- =========================
-- 📌 SECTION 9: UPDATING DATA
-- =========================

-- Question: How do you modify existing data in a table?
UPDATE students
SET phone = '9999999999'
WHERE student_id = 1;

-- Question: How do you update multiple columns at once?
UPDATE students
SET 
    cgpa = 9.0,
    address = 'Updated Mumbai Address'
WHERE student_id = 1;

-- Question: How do you update using calculations?
UPDATE students
SET cgpa = cgpa + 0.5
WHERE cgpa < 8.0;

-- Question: How do you update data using JOIN conditions?
UPDATE courses c
JOIN departments d ON c.department_id = d.department_id
SET c.is_active = FALSE
WHERE d.department_name = 'Database Management' AND c.course_code = 'DB101';

-- Question: How do you update data based on a subquery?
UPDATE students
SET cgpa = (
    SELECT AVG(
        CASE
            WHEN e.grade = 'A+' THEN 10.0
            WHEN e.grade = 'A' THEN 9.0
            WHEN e.grade = 'A-' THEN 8.5
            WHEN e.grade = 'B+' THEN 8.0
            WHEN e.grade = 'B' THEN 7.0
            WHEN e.grade = 'B-' THEN 6.0
            ELSE 5.0
        END
    )
    FROM enrollments e
    WHERE e.student_id = students.student_id
)
WHERE student_id IN (SELECT student_id FROM enrollments);

-- =========================
-- 📌 SECTION 10: DELETING DATA
-- =========================

-- Question: How do you remove specific rows from a table?
-- First, add a test student
INSERT INTO students (first_name, last_name, email, cgpa)
VALUES ('Test', 'Student', 'test.student@example.com', 5.0);

-- Then delete the test student
DELETE FROM students
WHERE first_name = 'Test' AND last_name = 'Student';

-- Question: How do you delete data using JOIN conditions?
-- Insert test data
INSERT INTO courses (course_code, course_name, department_id)
VALUES ('TEST101', 'Test Course', 5);

-- Delete using JOIN
DELETE c
FROM courses c
JOIN departments d ON c.department_id = d.department_id
WHERE c.course_code = 'TEST101' AND d.department_name = 'Database Management';

-- Question: How do you delete data using a subquery?
-- Insert test data first
INSERT INTO enrollments (student_id, course_id, grade)
VALUES (1, 5, 'F');

-- Delete enrollments with 'F' grades
DELETE FROM enrollments
WHERE grade = 'F' AND student_id IN (
    SELECT student_id FROM students WHERE cgpa > 8.0
);

-- Question: How do you efficiently delete all rows from a table?
-- CREATE TABLE temp_demo (id INT, name VARCHAR(50));
-- INSERT INTO temp_demo VALUES (1, 'Test'), (2, 'Test2');
-- TRUNCATE TABLE temp_demo;  -- Faster than DELETE, resets auto-increment

-- =========================
-- 📌 SECTION 11: FUNCTIONS AND EXPRESSIONS
-- =========================

-- Question: How do you manipulate string data in SQL?
SELECT 
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    UPPER(first_name) AS uppercase_first,
    LOWER(last_name) AS lowercase_last,
    LENGTH(first_name) AS name_length,
    SUBSTRING(first_name, 1, 3) AS name_substring,
    REPLACE(email, '@example.com', '@cdac.edu') AS new_email
FROM students;

-- Question: How do you perform mathematical calculations?
SELECT 
    credits,
    credits * 15 AS hours_per_semester,
    ROUND(AVG(credits), 1) AS rounded_avg,
    CEILING(AVG(credits)) AS ceiling_avg,
    FLOOR(AVG(credits)) AS floor_avg,
    POW(credits, 2) AS credits_squared,
    SQRT(ABS(credits - 3)) AS sqrt_diff_from_3
FROM courses
GROUP BY credits;

-- Question: How do you manipulate date and time values?
SELECT 
    enrollment_date,
    DATE_ADD(enrollment_date, INTERVAL 6 MONTH) AS six_months_later,
    DATEDIFF(CURRENT_DATE, enrollment_date) AS days_enrolled,
    YEAR(enrollment_date) AS enrollment_year,
    MONTH(enrollment_date) AS enrollment_month,
    DAY(enrollment_date) AS enrollment_day,
    DAYNAME(enrollment_date) AS day_of_week
FROM enrollments;

-- Question: How do you use conditional expressions (CASE)?
SELECT 
    student_id,
    first_name,
    last_name,
    cgpa,
    CASE 
        WHEN cgpa >= 9.0 THEN 'Excellent'
        WHEN cgpa >= 8.0 THEN 'Very Good'
        WHEN cgpa >= 7.0 THEN 'Good'
        WHEN cgpa >= 6.0 THEN 'Average'
        ELSE 'Below Average'
    END AS performance
FROM students;

-- Question: How do you use conditional expressions in aggregate functions?
SELECT 
    COUNT(*) AS total_students,
    COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS male_count,
    COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS female_count,
    AVG(CASE WHEN gender = 'Male' THEN cgpa END) AS male_avg_cgpa,
    AVG(CASE WHEN gender = 'Female' THEN cgpa END) AS female_avg_cgpa
FROM students;

-- =========================
-- 📌 SECTION 12: VIEWS
-- =========================

-- Question: How do you create a virtual table based on a SELECT query?
CREATE OR REPLACE VIEW student_course_view AS
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_id,
    c.course_name,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Question: How do you query from a view?
SELECT * FROM student_course_view
WHERE grade = 'A';

-- Question: How do you create a view with calculations?
CREATE OR REPLACE VIEW student_performance_view AS
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(e.course_id) AS courses_taken,
    AVG(
        CASE
            WHEN e.grade = 'A+' THEN 10.0
            WHEN e.grade = 'A' THEN 9.0
            WHEN e.grade = 'A-' THEN 8.5
            WHEN e.grade = 'B+' THEN 8.0
            WHEN e.grade = 'B' THEN 7.0
            WHEN e.grade = 'B-' THEN 6.0
            ELSE 5.0
        END
    ) AS calculated_gpa
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

-- Question: How do you create a view that allows updates?
CREATE OR REPLACE VIEW active_students AS
SELECT student_id, first_name, last_name, email, phone, cgpa
FROM students
WHERE is_active = TRUE
WITH CHECK OPTION;  -- Prevents updates that would make rows invisible to the view

-- Question: How do you update data through a view?
UPDATE active_students
SET phone = '8888888888'
WHERE student_id = 2;

-- =========================
-- 📌 SECTION 13: STORED PROCEDURES
-- =========================

-- Question: How do you create a reusable SQL code block?
DELIMITER //
CREATE PROCEDURE GetAllStudents()
BEGIN
    SELECT * FROM students;
END //
DELIMITER ;

-- Question: How do you execute a stored procedure?
CALL GetAllStudents();

-- Question: How do you create a procedure with input parameters?
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

-- Question: How do you call a procedure with parameters?
CALL GetStudentsByGrade('A');

-- Question: How do you create a procedure with output parameters?
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

-- Question: How do you retrieve output parameters from a procedure?
CALL GetDepartmentStats(1, @count, @avg);
SELECT @count AS course_count, @avg AS average_credits;

-- Question: How do you implement conditional logic in a procedure?
DELIMITER //
CREATE PROCEDURE UpdateStudentStatus(IN student_id_param INT)
BEGIN
    DECLARE student_cgpa DECIMAL(3,2);
    
    -- Get student's CGPA
    SELECT cgpa INTO student_cgpa
    FROM students
    WHERE student_id = student_id_param;
    
    -- Update status based on CGPA
    IF student_cgpa < 5.0 THEN
        UPDATE students
        SET is_active = FALSE
        WHERE student_id = student_id_param;
        
        SELECT 'Student status updated to inactive due to low CGPA' AS message;
    ELSE
        SELECT 'No status change needed' AS message;
    END IF;
END //
DELIMITER ;

-- Question: How do you implement error handling in procedures?
DELIMITER //
CREATE PROCEDURE EnrollStudent(
    IN student_id_param INT,
    IN course_id_param INT
)
BEGIN
    DECLARE student_exists INT DEFAULT 0;
    DECLARE course_exists INT DEFAULT 0;
    DECLARE already_enrolled INT DEFAULT 0;
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    
    -- Error handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET exit_handler = TRUE;
    
    -- Validate inputs through existence checks
    SELECT COUNT(*) INTO student_exists
    FROM students
    WHERE student_id = student_id_param;
    
    SELECT COUNT(*) INTO course_exists
    FROM courses
    WHERE course_id = course_id_param;
    
    SELECT COUNT(*) INTO already_enrolled
    FROM enrollments
    WHERE student_id = student_id_param AND course_id = course_id_param;
    
    -- Validation logic
    IF student_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Student does not exist';
    ELSEIF course_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Course does not exist';
    ELSEIF already_enrolled > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Student already enrolled in this course';
    ELSE
        -- Enroll the student
        INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
        VALUES (student_id_param, course_id_param, CURDATE(), NULL);
        
        -- Check for errors
        IF exit_handler THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Failed to enroll student';
        ELSE
            SELECT 'Student successfully enrolled' AS message;
        END IF;
    END IF;
END //
DELIMITER ;

-- Question: How do you use cursors and loops in procedures?
DELIMITER //
CREATE PROCEDURE GenerateReportCards()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE student_id_var INT;
    DECLARE first_name_var VARCHAR(50);
    DECLARE last_name_var VARCHAR(50);
    
    -- Cursor for iterating through students
    DECLARE student_cursor CURSOR FOR
        SELECT student_id, first_name, last_name FROM students;
    
    -- Handler for when no more rows to fetch
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Open cursor
    OPEN student_cursor;
    
    -- Start loop
    student_loop: LOOP
        -- Fetch student data
        FETCH student_cursor INTO student_id_var, first_name_var, last_name_var;
        
        -- Exit loop if no more data
        IF done THEN
            LEAVE student_loop;
        END IF;
        
        -- Generate report header
        SELECT CONCAT('Report Card for: ', first_name_var, ' ', last_name_var) AS '';
        
        -- Generate report body
        SELECT 
            c.course_name,
            e.grade
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = student_id_var;
        
        -- Add separator
        SELECT '------------------------' AS '';
    END LOOP;
    
    -- Close cursor
    CLOSE student_cursor;
END //
DELIMITER ;

-- =========================
-- 📌 SECTION 14: FUNCTIONS
-- =========================

-- Question: How do you create a custom function that returns a value?
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
    ELSEIF score >= 65 THEN
        SET grade = 'B-';
    ELSEIF score >= 60 THEN
        SET grade = 'C+';
    ELSE
        SET grade = 'C';
    END IF;
    
    RETURN grade;
END //
DELIMITER ;

-- Question: How do you call a function in a SELECT statement?
SELECT CalculateGrade(92) AS grade;

-- Question: How do you create a function that uses table data?
DELIMITER //
CREATE FUNCTION GetStudentFullName(student_id_param INT) 
RETURNS VARCHAR(101)
READS SQL DATA
BEGIN
    DECLARE full_name VARCHAR(101);
    
    SELECT CONCAT(first_name, ' ', last_name) INTO full_name
    FROM students
    WHERE student_id = student_id_param;
    
    RETURN IFNULL(full_name, 'Unknown Student');
END //
DELIMITER ;

-- Question: How do you use a function in a query?
SELECT 
    student_id,
    GetStudentFullName(student_id) AS full_name,
    cgpa
FROM students;

-- Question: How do you create a function for calculations?
DELIMITER //
CREATE FUNCTION CalculateAge(birth_date DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
END //
DELIMITER ;

-- Question: How do you use a calculation function?
SELECT 
    student_id,
    first_name,
    last_name,
    date_of_birth,
    CalculateAge(date_of_birth) AS age
FROM students
WHERE date_of_birth IS NOT NULL;

-- =========================
-- 📌 SECTION 15: TRIGGERS
-- =========================

-- Question: How do you create an audit trail for database changes?
CREATE TABLE student_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    action_type VARCHAR(10) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSON,
    new_data JSON
);

-- Question: How do you create an AFTER INSERT trigger?
DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_audit (student_id, action_type, new_data)
    VALUES (
        NEW.student_id,
        'INSERT',
        JSON_OBJECT(
            'first_name', NEW.first_name,
            'last_name', NEW.last_name,
            'email', NEW.email,
            'cgpa', NEW.cgpa
        )
    );
END //
DELIMITER ;

-- Question: How do you create an AFTER UPDATE trigger?
DELIMITER //
CREATE TRIGGER after_student_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_audit (student_id, action_type, old_data, new_data)
    VALUES (
        NEW.student_id,
        'UPDATE',
        JSON_OBJECT(
            'first_name', OLD.first_name,
            'last_name', OLD.last_name,
            'email', OLD.email,
            'cgpa', OLD.cgpa
        ),
        JSON_OBJECT(
            'first_name', NEW.first_name,
            'last_name', NEW.last_name,
            'email', NEW.email,
            'cgpa', NEW.cgpa
        )
    );
END //
DELIMITER ;

-- Question: How do you create an AFTER DELETE trigger?
DELIMITER //
CREATE TRIGGER after_student_delete
AFTER DELETE ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_audit (student_id, action_type, old_data)
    VALUES (
        OLD.student_id,
        'DELETE',
        JSON_OBJECT(
            'first_name', OLD.first_name,
            'last_name', OLD.last_name,
            'email', OLD.email,
            'cgpa', OLD.cgpa
        )
    );
END //
DELIMITER ;

-- Question: How do you create a BEFORE INSERT trigger for validation?
DELIMITER //
CREATE TRIGGER before_enrollment_insert
BEFORE INSERT ON enrollments
FOR EACH ROW
BEGIN
    DECLARE course_count INT;
    
    -- Check if student is already enrolled in too many courses
    SELECT COUNT(*) INTO course_count
    FROM enrollments
    WHERE student_id = NEW.student_id;
    
    IF course_count >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student cannot enroll in more than 5 courses';
    END IF;
END //
DELIMITER ;

-- =========================
-- 📌 SECTION 16: TRANSACTIONS
-- =========================

-- Question: How do you ensure multiple SQL statements execute as a single unit?
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

-- Question: How do you implement transaction error handling?
DELIMITER //
CREATE PROCEDURE TransferStudent(
    IN student_id_param INT,
    IN from_course_id INT,
    IN to_course_id INT
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET exit_handler = TRUE;
    
    START TRANSACTION;
    
    -- Delete enrollment from original course
    DELETE FROM enrollments 
    WHERE student_id = student_id_param AND course_id = from_course_id;
    
    -- Check for errors
    IF exit_handler THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error removing student from original course';
    END IF;
    
    -- Add enrollment to new course
    INSERT INTO enrollments (student_id, course_id, enrollment_date)
    VALUES (student_id_param, to_course_id, CURDATE());
    
    -- Check for errors
    IF exit_handler THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error enrolling student in new course';
    END IF;
    
    -- If everything is successful, commit the transaction
    COMMIT;
    
    SELECT 'Student successfully transferred' AS message;
END //
DELIMITER ;

-- =========================
-- 📌 SECTION 17: INDEXES
-- =========================

-- Question: How do you see existing indexes on a table?
SHOW INDEX FROM students;

-- Question: How do you create a simple index to speed up queries?
CREATE INDEX idx_student_email ON students(email);

-- Question: How do you create an index on multiple columns?
CREATE INDEX idx_enrollment_student_course ON enrollments(student_id, course_id);

-- Question: How do you create a unique index?
CREATE UNIQUE INDEX idx_course_code_unique ON courses(course_code);

-- Question: How do you create a fulltext index for text searching?
ALTER TABLE courses ADD FULLTEXT INDEX idx_course_fulltext(course_name, description);

-- Question: How do you use a fulltext index in a query?
SELECT course_id, course_name, description
FROM courses
WHERE MATCH(course_name, description) AGAINST('database' IN NATURAL LANGUAGE MODE);

-- =========================
-- 📌 SECTION 18: DATABASE ADMINISTRATION
-- =========================

-- Question: How do you create a database user?
-- CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'student_password';

-- Question: How do you grant privileges to a user?
-- GRANT SELECT ON cdac_tutorial.* TO 'student_user'@'localhost';
-- GRANT SELECT, INSERT, UPDATE ON cdac_tutorial.students TO 'student_user'@'localhost';

-- Question: How do you revoke privileges from a user?
-- REVOKE INSERT ON cdac_tutorial.students FROM 'student_user'@'localhost';

-- Question: How do you check the status of database tables?
SHOW TABLE STATUS FROM cdac_tutorial;

-- Question: How do you optimize tables for better performance?
OPTIMIZE TABLE students, enrollments;

-- Question: How do you view database server variables?
SHOW VARIABLES LIKE 'max_connections';

-- Question: How do you view currently running processes?
SHOW PROCESSLIST;

-- =========================
-- 📌 SECTION 19: ADVANCED SQL FEATURES
-- =========================

-- Question: How do you use window functions for analytical queries?
-- First, let's create a table for this demonstration
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
('Headphones', 'Electronics', '2023-01-18', 8500.00),
('Monitor', 'Electronics', '2023-01-25', 15000.00),
('Office Chair', 'Furniture', '2023-01-08', 12000.00),
('Desk', 'Furniture', '2023-01-15', 25000.00),
('Bookshelf', 'Furniture', '2023-01-22', 18000.00),
('Coffee Machine', 'Appliances', '2023-01-10', 9500.00),
('Microwave', 'Appliances', '2023-01-20', 12500.00),
('Blender', 'Appliances', '2023-01-28', 4500.00);

-- Window function examples
SELECT 
    sale_id,
    product_name,
    category,
    amount,
    -- Simple window functions
    SUM(amount) OVER() AS total_sales,
    AVG(amount) OVER() AS avg_sale,
    
    -- Partitioned window functions
    SUM(amount) OVER(PARTITION BY category) AS category_total,
    AVG(amount) OVER(PARTITION BY category) AS category_avg,
    
    -- Ranking functions
    ROW_NUMBER() OVER(ORDER BY amount DESC) AS overall_rank,
    RANK() OVER(PARTITION BY category ORDER BY amount DESC) AS category_rank,
    DENSE_RANK() OVER(PARTITION BY category ORDER BY amount DESC) AS category_dense_rank,
    
    -- Running totals (cumulative sum)
    SUM(amount) OVER(ORDER BY sale_date) AS running_total,
    
    -- Moving averages
    AVG(amount) OVER(ORDER BY sale_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_3
FROM sales;

-- Question: How do you work with JSON data in MySQL?
-- Add a JSON column to students
ALTER TABLE students ADD COLUMN preferences JSON;

-- Update with JSON data
UPDATE students
SET preferences = '{"theme": "dark", "notifications": true, "language": "en"}'
WHERE student_id = 1;

-- Query JSON data
SELECT 
    student_id,
    first_name,
    last_name,
    JSON_EXTRACT(preferences, '$.theme') AS theme,
    JSON_EXTRACT(preferences, '$.notifications') AS notifications,
    JSON_EXTRACT(preferences, '$.language') AS language
FROM students
WHERE preferences IS NOT NULL;

-- Question: How do you create pivot tables in SQL?
SELECT 
    category,
    SUM(CASE WHEN MONTH(sale_date) = 1 THEN amount ELSE 0 END) AS January,
    SUM(CASE WHEN MONTH(sale_date) = 2 THEN amount ELSE 0 END) AS February,
    SUM(CASE WHEN MONTH(sale_date) = 3 THEN amount ELSE 0 END) AS March,
    SUM(CASE WHEN MONTH(sale_date) = 4 THEN amount ELSE 0 END) AS April,
    SUM(amount) AS Total
FROM sales
GROUP BY category;

-- =========================
-- 📌 SECTION 20: PERFORMANCE OPTIMIZATION
-- =========================

-- Question: How do you analyze query execution plans?
EXPLAIN
SELECT 
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.cgpa > 8.0;

-- Question: How do you create indexes for better performance?
CREATE INDEX idx_student_cgpa ON students(cgpa);

-- Question: How do you optimize a query with multiple JOINs?
-- Original query
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

-- Add index to improve performance
CREATE INDEX idx_department_name ON departments(department_name);

-- Question: How do you limit the size of result sets for better performance?
SELECT * FROM students LIMIT 10;

-- Question: How do you avoid selecting unnecessary columns?
-- Instead of:
-- SELECT * FROM students;
-- Use:
SELECT student_id, first_name, last_name, email, cgpa FROM students;

-- =========================
-- 📌 SECTION 21: DATABASE BACKUP AND RECOVERY
-- =========================

-- Question: How would you document a database backup strategy?
DELIMITER //
CREATE PROCEDURE DocumentBackupStrategy()
BEGIN
    -- Create a backup documentation table
    CREATE TABLE IF NOT EXISTS backup_documentation (
        id INT AUTO_INCREMENT PRIMARY KEY,
        backup_type VARCHAR(50),
        frequency VARCHAR(50),
        retention_period VARCHAR(50),
        command_example TEXT,
        description TEXT
    );
    
    -- Insert backup strategies
    INSERT INTO backup_documentation (backup_type, frequency, retention_period, command_example, description) VALUES
    ('Full Database Backup', 'Daily (at midnight)', '30 days', 
     'mysqldump -u admin -p --all-databases > full_backup_$(date +%Y%m%d).sql', 
     'Complete backup of all databases, tables, and data. Used for complete recovery scenarios.'),
     
    ('Incremental Backup', 'Every 6 hours', '7 days', 
     'mysqldump -u admin -p --all-databases --single-transaction --flush-logs --master-data=2 > incremental_backup_$(date +%Y%m%d_%H%M%S).sql', 
     'Captures changes since the last backup. Requires binary logging to be enabled.'),
     
    ('Differential Backup', 'Every 12 hours', '14 days', 
     'mysqldump -u admin -p --all-databases --where="last_updated >= CURDATE()" > differential_backup_$(date +%Y%m%d_%H%M%S).sql', 
     'Captures all changes since the last full backup.');
    
    -- Display the documentation
    SELECT * FROM backup_documentation;
END //
DELIMITER ;

-- Question: How would you simulate a point-in-time recovery?
DELIMITER //
CREATE PROCEDURE SimulatePointInTimeRecovery(IN recovery_timestamp DATETIME)
BEGIN
    -- This is a simulation - in reality, you would use actual MySQL recovery commands
    
    -- Step 1: Document the recovery plan
    SELECT 'Point-in-Time Recovery Plan' AS step, 'Planning phase' AS status;
    
    -- Step 2: Identify the closest full backup before the recovery timestamp
    SELECT 
        CONCAT('Identified backup file: full_backup_', DATE_FORMAT(DATE(recovery_timestamp), '%Y%m%d'), '.sql') AS step, 
        'Found backup file' AS status;
    
    -- Step 3: Calculate which binary logs would be needed
    SELECT 
        CONCAT('Binary logs needed from ', DATE_FORMAT(DATE(recovery_timestamp), '%Y-%m-%d'), 
               ' to ', DATE_FORMAT(recovery_timestamp, '%Y-%m-%d %H:%i:%s')) AS step,
        'Binary logs identified' AS status;
    
    -- Step 4: Simulate the restoration commands
    SELECT 
        CONCAT('Command: mysql -u admin -p < full_backup_', DATE_FORMAT(DATE(recovery_timestamp), '%Y%m%d'), '.sql') AS step,
        'Full backup restored' AS status;
    
    -- Step 5: Simulate applying binary logs
    SELECT 
        CONCAT('Command: mysqlbinlog --start-datetime="', DATE_FORMAT(DATE(recovery_timestamp), '%Y-%m-%d 00:00:00'),
               '" --stop-datetime="', DATE_FORMAT(recovery_timestamp, '%Y-%m-%d %H:%i:%s'), 
               '" /var/lib/mysql/binlog.* | mysql -u admin -p') AS step,
        'Binary logs applied' AS status;
END //
DELIMITER ;

-- =========================
-- 📌 SECTION 22: PRACTICAL CASE STUDIES
-- =========================

-- Question: How would you generate a comprehensive student transcript?
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
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
        WHEN e.grade = 'B-' THEN 6.0
        ELSE 5.0
    END AS grade_points,
    c.credits * CASE 
        WHEN e.grade = 'A+' THEN 10.0
        WHEN e.grade = 'A' THEN 9.0
        WHEN e.grade = 'A-' THEN 8.5
        WHEN e.grade = 'B+' THEN 8.0
        WHEN e.grade = 'B' THEN 7.0
        WHEN e.grade = 'B-' THEN 6.0
        ELSE 5.0
    END AS weighted_points
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
LEFT JOIN departments d ON c.department_id = d.department_id
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
                WHEN e.grade = 'B-' THEN 6.0
                ELSE 5.0
            END
        ) AS avg_grade_points
    FROM departments d
    LEFT JOIN courses c ON d.department_id = c.department_id
    LEFT JOIN enrollments e ON c.course_id = e.course_id
    GROUP BY d.department_id, d.department_name
)
SELECT 
    department_id,
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

-- Question: How would you find students who need academic help?
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email,
    COUNT(e.course_id) AS total_courses,
    COUNT(CASE WHEN e.grade IN ('C', 'D', 'F') THEN 1 END) AS low_grade_count,
    ROUND(COUNT(CASE WHEN e.grade IN ('C', 'D', 'F') THEN 1 END) / COUNT(e.course_id) * 100, 2) AS low_grade_percentage
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, student_name, s.email
HAVING low_grade_count > 0
ORDER BY low_grade_percentage DESC;

-- Question: How would you generate a comprehensive student analytics report?
WITH StudentFeatures AS (
    SELECT 
        s.student_id,
        s.cgpa,
        d.department_id,
        TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) AS age,
        CASE WHEN s.country = 'India' THEN 1 ELSE 0 END AS is_from_india,
        COUNT(e.course_id) AS courses_taken,
        AVG(CASE 
            WHEN e.grade = 'A+' THEN 10.0
            WHEN e.grade = 'A' THEN 9.0
            WHEN e.grade = 'A-' THEN 8.5
            WHEN e.grade = 'B+' THEN 8.0
            WHEN e.grade = 'B' THEN 7.0
            WHEN e.grade = 'B-' THEN 6.5
            WHEN e.grade = 'C+' THEN 6.0
            ELSE 5.0
        END) AS avg_grade_points
    FROM students s
    LEFT JOIN departments d ON s.department_id = d.department_id
    LEFT JOIN enrollments e ON s.student_id = e.student_id
    GROUP BY s.student_id, s.cgpa, d.department_id, age, is_from_india
)
SELECT 
    department_id,
    ROUND(AVG(age), 1) AS avg_age,
    SUM(is_from_india) AS india_students_count,
    COUNT(*) AS total_students,
    ROUND(SUM(is_from_india) * 100.0 / COUNT(*), 2) AS india_students_percentage,
    ROUND(AVG(cgpa), 2) AS avg_cgpa,
    ROUND(AVG(avg_grade_points), 2) AS avg_grade_points,
    ROUND(AVG(courses_taken), 1) AS avg_courses_taken,
    CASE 
        WHEN AVG(cgpa) > 8.5 THEN 'High Performer'
        WHEN AVG(cgpa) > 7.5 THEN 'Above Average'
        WHEN AVG(cgpa) > 6.5 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_segment
FROM StudentFeatures
GROUP BY department_id
ORDER BY department_id, avg_cgpa DESC;

-- Question: How would you analyze course popularity and performance?
SELECT 
    c.course_id,
    c.course_name,
    c.course_code,
    d.department_name,
    COUNT(e.enrollment_id) AS enrollment_count,
    COUNT(CASE WHEN e.grade IS NOT NULL THEN 1 END) AS completed_count,
    ROUND(COUNT(CASE WHEN e.grade IS NOT NULL THEN 1 END) * 100.0 / COUNT(e.enrollment_id), 2) AS completion_rate,
    ROUND(AVG(CASE
        WHEN e.grade = 'A+' THEN 10.0
        WHEN e.grade = 'A' THEN 9.0
        WHEN e.grade = 'A-' THEN 8.5
        WHEN e.grade = 'B+' THEN 8.0
        WHEN e.grade = 'B' THEN 7.0
        WHEN e.grade = 'B-' THEN 6.0
        ELSE 5.0
    END), 2) AS avg_grade,
    COUNT(CASE WHEN e.grade IN ('A+', 'A', 'A-') THEN 1 END) AS a_grades,
    ROUND(COUNT(CASE WHEN e.grade IN ('A+', 'A', 'A-') THEN 1 END) * 100.0 / 
          COUNT(CASE WHEN e.grade IS NOT NULL THEN 1 END), 2) AS a_grade_percentage
FROM courses c
LEFT JOIN departments d ON c.department_id = d.department_id
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE c.is_active = TRUE
GROUP BY c.course_id, c.course_name, c.course_code, d.department_name
ORDER BY enrollment_count DESC, avg_grade DESC;

-- ======== END OF SQL TUTORIAL ========