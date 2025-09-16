```sql
-- =============================================
-- COMPREHENSIVE SQL LEARNING SCRIPT
-- For CDAC DBDA Course - MySQL
-- =============================================

-- ===========================================
-- SECTION 1: DATABASE CREATION AND SELECTION
-- ===========================================

-- Create a new database
CREATE DATABASE IF NOT EXISTS cdac_learning_db;

-- Select the database for use
USE cdac_learning_db;

-- ========================================
-- SECTION 2: TABLE CREATION & DATA TYPES
-- ========================================

-- Create department table (will be referenced by other tables)
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    hod_name VARCHAR(100),
    office_location VARCHAR(50),
    budget DECIMAL(12,2) DEFAULT 0.00,
    established_date DATE,
    contact_number VARCHAR(15),
    email VARCHAR(100),
    website VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create instructor table
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    hire_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    qualification VARCHAR(100),
    specialization VARCHAR(200),
    salary DECIMAL(10,2),
    is_permanent BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

-- Create course table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    credits INT DEFAULT 3,
    hours_per_week INT,
    instructor_id INT,
    max_students INT DEFAULT 30,
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    CHECK (credits BETWEEN 1 AND 6),
    CHECK (hours_per_week > 0)
);

-- Create student table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(10),
    country VARCHAR(50) DEFAULT 'India',
    enrollment_date DATE NOT NULL,
    graduation_date DATE,
    department_id INT,
    cgpa DECIMAL(3,2),
    is_active BOOLEAN DEFAULT TRUE,
    profile_picture BLOB,
    emergency_contact VARCHAR(100),
    emergency_phone VARCHAR(15),
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL,
    INDEX idx_student_name (last_name, first_name), -- Adding an index for faster name searches
    CHECK (cgpa BETWEEN 0 AND 10)
);

-- Create enrollments table (junction table for many-to-many relationship)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade VARCHAR(2),
    status ENUM('Active', 'Completed', 'Dropped', 'Waitlisted') DEFAULT 'Active',
    feedback TEXT,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, course_id) -- Prevent duplicate enrollments
);

-- Create assignments table
CREATE TABLE assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    due_date DATETIME NOT NULL,
    max_score INT DEFAULT 100,
    weight_percentage DECIMAL(5,2) DEFAULT 10.00,
    assignment_type ENUM('Quiz', 'Project', 'Homework', 'Exam', 'Lab') NOT NULL,
    is_group_work BOOLEAN DEFAULT FALSE,
    submission_type ENUM('Online', 'Hardcopy', 'Presentation'),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- Create submissions table
CREATE TABLE submissions (
    submission_id INT AUTO_INCREMENT PRIMARY KEY,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    submission_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    content TEXT,
    file_path VARCHAR(255),
    score DECIMAL(5,2),
    feedback TEXT,
    is_late BOOLEAN GENERATED ALWAYS AS (submission_date > (SELECT due_date FROM assignments WHERE assignment_id = assignment_id)) STORED,
    graded_by INT,
    graded_date DATETIME,
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (graded_by) REFERENCES instructors(instructor_id) ON DELETE SET NULL
);

-- Create attendance table
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late', 'Excused') NOT NULL DEFAULT 'Present',
    remarks VARCHAR(255),
    recorded_by INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (recorded_by) REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    UNIQUE KEY unique_attendance (student_id, course_id, attendance_date)
);

-- Create events table
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    description TEXT,
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME NOT NULL,
    location VARCHAR(100),
    organizer_id INT,
    department_id INT,
    max_participants INT,
    registration_deadline DATE,
    event_type ENUM('Workshop', 'Seminar', 'Conference', 'Cultural', 'Sports', 'Other'),
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (organizer_id) REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE,
    CHECK (end_datetime > start_datetime)
);

-- Create event_registrations table
CREATE TABLE event_registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    student_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    attended BOOLEAN DEFAULT FALSE,
    feedback TEXT,
    FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    UNIQUE KEY unique_registration (event_id, student_id)
);

-- Create library_books table
CREATE TABLE library_books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publisher VARCHAR(100),
    publication_year INT,
    category VARCHAR(50),
    subject VARCHAR(50),
    pages INT,
    available_copies INT NOT NULL DEFAULT 1,
    total_copies INT NOT NULL DEFAULT 1,
    location_shelf VARCHAR(50),
    added_date DATE DEFAULT (CURRENT_DATE),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CHECK (available_copies <= total_copies)
);

-- Create book_borrowings table
CREATE TABLE book_borrowings (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    student_id INT NOT NULL,
    borrow_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(6,2) DEFAULT 0.00,
    status ENUM('Borrowed', 'Returned', 'Overdue', 'Lost') DEFAULT 'Borrowed',
    FOREIGN KEY (book_id) REFERENCES library_books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- Create payments table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('Cash', 'Credit Card', 'Debit Card', 'Net Banking', 'UPI', 'Other'),
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Pending',
    transaction_id VARCHAR(100),
    payment_purpose ENUM('Tuition', 'Library Fine', 'Event Registration', 'Other'),
    semester VARCHAR(20),
    academic_year VARCHAR(9),
    remarks TEXT,
    receipt_number VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- Table to track student login history
CREATE TABLE login_history (
    login_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    instructor_id INT,
    login_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    logout_datetime DATETIME,
    ip_address VARCHAR(45),
    device_info VARCHAR(255),
    session_duration INT GENERATED ALWAYS AS 
        (TIMESTAMPDIFF(MINUTE, login_datetime, logout_datetime)) STORED,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE SET NULL,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    CHECK (student_id IS NOT NULL OR instructor_id IS NOT NULL) -- Either student or instructor must be provided
);

-- ======================================
-- SECTION 3: INSERTING DATA (DML - INSERT)
-- ======================================

-- Insert data into departments
INSERT INTO departments (department_name, hod_name, office_location, budget, established_date, contact_number, email, website, is_active) VALUES 
('Computer Science', 'Dr. Rajesh Kumar', 'Block A, Room 101', 5000000.00, '2010-06-15', '9876543210', 'cs@cdac.edu', 'www.cdac.edu/cs', TRUE),
('Data Science', 'Dr. Priya Singh', 'Block B, Room 201', 6000000.00, '2015-07-20', '9876543211', 'ds@cdac.edu', 'www.cdac.edu/ds', TRUE),
('Information Technology', 'Dr. Amit Verma', 'Block A, Room 105', 4500000.00, '2012-04-10', '9876543212', 'it@cdac.edu', 'www.cdac.edu/it', TRUE),
('Artificial Intelligence', 'Dr. Sneha Patel', 'Block C, Room 301', 7000000.00, '2018-08-05', '9876543213', 'ai@cdac.edu', 'www.cdac.edu/ai', TRUE),
('Database Management', 'Dr. Vikram Singh', 'Block B, Room 205', 4000000.00, '2014-03-15', '9876543214', 'dbms@cdac.edu', 'www.cdac.edu/dbms', TRUE);

-- Insert data into instructors
INSERT INTO instructors (department_id, first_name, last_name, date_of_birth, gender, hire_date, email, phone, address, qualification, specialization, salary, is_permanent) VALUES
(1, 'Anand', 'Sharma', '1975-05-15', 'Male', '2012-07-01', 'anand.sharma@cdac.edu', '9898989801', '123 Faculty Housing, Mumbai', 'PhD in Computer Science', 'Machine Learning', 85000.00, TRUE),
(1, 'Divya', 'Gupta', '1980-11-20', 'Female', '2015-06-15', 'divya.gupta@cdac.edu', '9898989802', '456 Professors Colony, Mumbai', 'PhD in Computer Engineering', 'Computer Networks', 78000.00, TRUE),
(2, 'Rahul', 'Verma', '1978-03-10', 'Male', '2016-08-01', 'rahul.verma@cdac.edu', '9898989803', '789 Faculty Quarters, Mumbai', 'PhD in Statistics', 'Big Data Analytics', 82000.00, TRUE),
(3, 'Neha', 'Patel', '1982-07-22', 'Female', '2014-01-10', 'neha.patel@cdac.edu', '9898989804', '234 Tech Villa, Mumbai', 'PhD in Information Systems', 'Cybersecurity', 80000.00, TRUE),
(4, 'Karan', 'Malhotra', '1979-09-15', 'Male', '2019-02-15', 'karan.malhotra@cdac.edu', '9898989805', '567 AI Avenue, Mumbai', 'PhD in AI', 'Deep Learning', 90000.00, TRUE),
(5, 'Meera', 'Joshi', '1977-12-05', 'Female', '2015-05-01', 'meera.joshi@cdac.edu', '9898989806', '890 Database Road, Mumbai', 'PhD in Database Systems', 'Data Warehousing', 82000.00, TRUE),
(2, 'Suresh', 'Kumar', '1983-04-18', 'Male', '2017-07-01', 'suresh.kumar@cdac.edu', '9898989807', '123 Analytics Building, Mumbai', 'PhD in Data Science', 'Predictive Analytics', 76000.00, TRUE),
(3, 'Priyanka', 'Reddy', '1981-08-30', 'Female', '2018-01-15', 'priyanka.reddy@cdac.edu', '9898989808', '456 Software Enclave, Mumbai', 'PhD in Software Engineering', 'Web Technologies', 75000.00, TRUE),
(4, 'Varun', 'Singh', '1976-06-25', 'Male', '2020-03-01', 'varun.singh@cdac.edu', '9898989809', '789 Neural Networks Lane, Mumbai', 'PhD in Cognitive Science', 'NLP', 88000.00, TRUE),
(5, 'Anjali', 'Desai', '1984-02-12', 'Female', '2016-04-01', 'anjali.desai@cdac.edu', '9898989810', '234 SQL Street, Mumbai', 'PhD in Information Management', 'NoSQL Databases', 79000.00, TRUE);

-- Insert data into courses
INSERT INTO courses (department_id, course_code, course_name, description, credits, hours_per_week, instructor_id, max_students, start_date, end_date, is_active) VALUES
(1, 'CS101', 'Introduction to Programming', 'Fundamentals of programming using C and Python', 4, 6, 1, 40, '2023-01-15', '2023-05-30', TRUE),
(1, 'CS201', 'Data Structures', 'Study of fundamental data structures and algorithms', 4, 6, 1, 35, '2023-01-15', '2023-05-30', TRUE),
(1, 'CS301', 'Object-Oriented Programming', 'Advanced programming concepts using Java', 3, 5, 2, 30, '2023-01-15', '2023-05-30', TRUE),
(2, 'DS101', 'Fundamentals of Data Science', 'Introduction to data science concepts and tools', 4, 6, 3, 35, '2023-01-15', '2023-05-30', TRUE),
(2, 'DS201', 'Statistical Methods for Data Science', 'Statistical foundations for data analysis', 3, 5, 7, 30, '2023-01-15', '2023-05-30', TRUE),
(3, 'IT101', 'Computer Networks', 'Principles of computer networking and protocols', 3, 5, 4, 35, '2023-01-15', '2023-05-30', TRUE),
(3, 'IT201', 'Web Development', 'Modern web development technologies and frameworks', 4, 6, 8, 30, '2023-01-15', '2023-05-30', TRUE),
(4, 'AI101', 'Introduction to Artificial Intelligence', 'Foundations of AI and intelligent systems', 4, 6, 5, 35, '2023-01-15', '2023-05-30', TRUE),
(4, 'AI201', 'Machine Learning', 'Principles and applications of machine learning algorithms', 4, 6, 9, 30, '2023-01-15', '2023-05-30', TRUE),
(5, 'DB101', 'Database Management Systems', 'Fundamentals of database design and SQL', 4, 6, 6, 40, '2023-01-15', '2023-05-30', TRUE),
(5, 'DB201', 'Advanced Database Concepts', 'Advanced topics in database management', 3, 5, 10, 30, '2023-01-15', '2023-05-30', TRUE),
(5, 'DB301', 'Data Warehousing and Mining', 'Principles of data warehousing and data mining', 4, 6, 6, 25, '2023-01-15', '2023-05-30', TRUE);

-- Insert data into students
INSERT INTO students (first_name, last_name, date_of_birth, gender, email, phone, address, city, state, postal_code, country, enrollment_date, department_id, cgpa, is_active) VALUES
('Aditya', 'Sharma', '2000-05-15', 'Male', 'aditya.sharma@student.cdac.edu', '9876123401', '123 Student Housing, Sector 1', 'Mumbai', 'Maharashtra', '400001', 'India', '2022-07-15', 1, 8.5, TRUE),
('Sneha', 'Patel', '2001-03-22', 'Female', 'sneha.patel@student.cdac.edu', '9876123402', '456 College Road, Sector 2', 'Mumbai', 'Maharashtra', '400002', 'India', '2022-07-15', 1, 9.2, TRUE),
('Rahul', 'Verma', '1999-11-10', 'Male', 'rahul.verma@student.cdac.edu', '9876123403', '789 Education Street, Sector 3', 'Pune', 'Maharashtra', '411001', 'India', '2022-07-15', 2, 7.8, TRUE),
('Priya', 'Singh', '2000-07-05', 'Female', 'priya.singh@student.cdac.edu', '9876123404', '234 Knowledge Avenue, Sector 4', 'Pune', 'Maharashtra', '411002', 'India', '2022-07-15', 2, 8.9, TRUE),
('Vikram', 'Malhotra', '1998-09-18', 'Male', 'vikram.malhotra@student.cdac.edu', '9876123405', '567 Learning Lane, Sector 5', 'Mumbai', 'Maharashtra', '400003', 'India', '2022-07-15', 3, 8.1, TRUE),
('Neha', 'Gupta', '2001-01-30', 'Female', 'neha.gupta@student.cdac.edu', '9876123406', '890 Student Way, Sector 6', 'Mumbai', 'Maharashtra', '400004', 'India', '2022-07-15', 3, 9.0, TRUE),
('Arjun', 'Reddy', '1999-04-12', 'Male', 'arjun.reddy@student.cdac.edu', '9876123407', '123 AI Building, Sector 7', 'Pune', 'Maharashtra', '411003', 'India', '2022-07-15', 4, 8.4, TRUE),
('Kavita', 'Joshi', '2000-12-15', 'Female', 'kavita.joshi@student.cdac.edu', '9876123408', '456 Tech Park, Sector 8', 'Pune', 'Maharashtra', '411004', 'India', '2022-07-15', 4, 9.5, TRUE),
('Rohan', 'Kumar', '1998-06-20', 'Male', 'rohan.kumar@student.cdac.edu', '9876123409', '789 Database Colony, Sector 9', 'Mumbai', 'Maharashtra', '400005', 'India', '2022-07-15', 5, 7.5, TRUE),
('Ananya', 'Desai', '2001-08-25', 'Female', 'ananya.desai@student.cdac.edu', '9876123410', '234 SQL Street, Sector 10', 'Mumbai', 'Maharashtra', '400006', 'India', '2022-07-15', 5, 8.7, TRUE),
('Ishaan', 'Mehta', '1999-02-14', 'Male', 'ishaan.mehta@student.cdac.edu', '9876123411', '567 Programming Lane, Sector 11', 'Pune', 'Maharashtra', '411005', 'India', '2022-07-15', 1, 8.2, TRUE),
('Riya', 'Saxena', '2000-10-08', 'Female', 'riya.saxena@student.cdac.edu', '9876123412', '890 Code Avenue, Sector 12', 'Pune', 'Maharashtra', '411006', 'India', '2022-07-15', 1, 9.1, TRUE),
('Vishal', 'Yadav', '1998-07-17', 'Male', 'vishal.yadav@student.cdac.edu', '9876123413', '123 Analytics Road, Sector 13', 'Mumbai', 'Maharashtra', '400007', 'India', '2022-07-15', 2, 8.0, TRUE),
('Meera', 'Kapoor', '2001-04-03', 'Female', 'meera.kapoor@student.cdac.edu', '9876123414', '456 Data Science Path, Sector 14', 'Mumbai', 'Maharashtra', '400008', 'India', '2022-07-15', 2, 9.3, TRUE),
('Kunal', 'Singh', '1999-12-22', 'Male', 'kunal.singh@student.cdac.edu', '9876123415', '789 Network Street, Sector 15', 'Pune', 'Maharashtra', '411007', 'India', '2022-07-15', 3, 7.9, TRUE);

-- Insert data into enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade, status) VALUES
(1, 1, '2023-01-10', 'A', 'Active'),
(1, 2, '2023-01-10', 'A-', 'Active'),
(2, 1, '2023-01-10', 'A+', 'Active'),
(2, 2, '2023-01-10', 'B+', 'Active'),
(3, 4, '2023-01-10', 'B', 'Active'),
(3, 5, '2023-01-10', 'B-', 'Active'),
(4, 4, '2023-01-10', 'A', 'Active'),
(4, 5, '2023-01-10', 'A-', 'Active'),
(5, 6, '2023-01-10', 'B+', 'Active'),
(5, 7, '2023-01-10', 'A-', 'Active'),
(6, 6, '2023-01-10', 'A', 'Active'),
(6, 7, '2023-01-10', 'B', 'Active'),
(7, 8, '2023-01-10', 'A+', 'Active'),
(7, 9, '2023-01-10', 'A', 'Active'),
(8, 8, '2023-01-10', 'A', 'Active'),
(8, 9, '2023-01-10', 'B+', 'Active'),
(9, 10, '2023-01-10', 'B', 'Active'),
(9, 11, '2023-01-10', 'C+', 'Active'),
(10, 10, '2023-01-10', 'A-', 'Active'),
(10, 11, '2023-01-10', 'B+', 'Active'),
(11, 1, '2023-01-10', 'B+', 'Active'),
(11, 3, '2023-01-10', 'A-', 'Active'),
(12, 2, '2023-01-10', 'A', 'Active'),
(12, 3, '2023-01-10', 'A+', 'Active'),
(13, 4, '2023-01-10', 'B', 'Active'),
(14, 5, '2023-01-10', 'A', 'Active'),
(15, 6, '2023-01-10', 'B+', 'Active');

-- Insert data into assignments
INSERT INTO assignments (course_id, title, description, due_date, max_score, weight_percentage, assignment_type, is_group_work, submission_type) VALUES
(1, 'Introduction to C Programming', 'Write a C program to implement a simple calculator', '2023-02-15 23:59:59', 100, 10.00, 'Homework', FALSE, 'Online'),
(1, 'Python Basics', 'Create a Python script to process and analyze text files', '2023-03-01 23:59:59', 100, 15.00, 'Project', FALSE, 'Online'),
(2, 'Linked List Implementation', 'Implement a doubly linked list with all basic operations', '2023-02-20 23:59:59', 100, 20.00, 'Lab', FALSE, 'Online'),
(2, 'Sorting Algorithms', 'Implement and compare the performance of 3 sorting algorithms', '2023-03-10 23:59:59', 100, 20.00, 'Project', TRUE, 'Presentation'),
(4, 'Data Exploration with Pandas', 'Analyze a given dataset using pandas and create visualizations', '2023-02-25 23:59:59', 100, 15.00, 'Lab', FALSE, 'Online'),
(4, 'Statistical Analysis Project', 'Perform comprehensive statistical analysis on a real-world dataset', '2023-03-15 23:59:59', 100, 25.00, 'Project', TRUE, 'Presentation'),
(6, 'Network Protocols Analysis', 'Analyze different network protocols using Wireshark', '2023-02-18 23:59:59', 100, 15.00, 'Lab', FALSE, 'Online'),
(8, 'AI Search Algorithms', 'Implement BFS, DFS, and A* search algorithms for a maze-solving problem', '2023-02-22 23:59:59', 100, 20.00, 'Homework', FALSE, 'Online'),
(10, 'SQL Database Design', 'Design and implement a normalized database for a retail management system', '2023-03-05 23:59:59', 100, 25.00, 'Project', TRUE, 'Presentation'),
(10, 'SQL Queries', 'Write complex SQL queries to extract specific information from a database', '2023-02-28 23:59:59', 100, 15.00, 'Lab', FALSE, 'Online');

-- Insert data into submissions
INSERT INTO submissions (assignment_id, student_id, submission_date, content, file_path, score, feedback, graded_by, graded_date) VALUES
(1, 1, '2023-02-14 14:30:00', 'Implemented a calculator with basic arithmetic operations', '/submissions/CS101/HW1/student1.c', 92.5, 'Well-structured code. Could improve error handling.', 1, '2023-02-16 10:15:00'),
(1, 2, '2023-02-15 09:45:00', 'Calculator with additional scientific functions', '/submissions/CS101/HW1/student2.c', 98.0, 'Excellent work! Very comprehensive implementation.', 1, '2023-02-16 11:30:00'),
(2, 1, '2023-02-28 18:20:00', 'Text analyzer that counts words, sentences, and performs sentiment analysis', '/submissions/CS101/Project1/student1.py', 88.0, 'Good implementation but could be more efficient.', 1, '2023-03-03 14:00:00'),
(2, 2, '2023-02-27 16:15:00', 'Advanced text analyzer with visualization capabilities', '/submissions/CS101/Project1/student2.py', 95.5, 'Excellent work with the visualizations!', 1, '2023-03-03 14:30:00'),
(3, 1, '2023-02-19 20:10:00', 'Complete doubly linked list implementation with all required operations', '/submissions/CS201/Lab1/student1.cpp', 90.0, 'Well implemented. Memory management could be improved.', 1, '2023-02-22 09:45:00'),
(3, 2, '2023-02-20 10:30:00', 'Doubly linked list with additional functionality', '/submissions/CS201/Lab1/student2.cpp', 94.0, 'Very clean and efficient implementation.', 1, '2023-02-22 10:15:00'),
(5, 3, '2023-02-24 19:15:00', 'Data analysis with pandas showing various insights through visualizations', '/submissions/DS101/Lab1/student3.ipynb', 87.5, 'Good analysis but could include more in-depth insights.', 3, '2023-02-26 15:30:00'),
(5, 4, '2023-02-25 14:40:00', 'Comprehensive data analysis with advanced visualizations', '/submissions/DS101/Lab1/student4.ipynb', 96.0, 'Excellent work! Very thorough analysis.', 3, '2023-02-26 16:00:00'),
(9, 9, '2023-03-04 22:15:00', 'Retail management system database with complete normalization', '/submissions/DB101/Project1/student9.sql', 85.0, 'Good design but some normalization issues in inventory tables.', 6, '2023-03-07 11:20:00'),
(9, 10, '2023-03-05 16:50:00', 'Fully normalized retail database with stored procedures and triggers', '/submissions/DB101/Project1/student10.sql', 97.5, 'Excellent work! Very comprehensive and well-documented.', 6, '2023-03-07 12:00:00');

-- Insert data into attendance
INSERT INTO attendance (student_id, course_id, attendance_date, status, remarks, recorded_by) VALUES
(1, 1, '2023-01-16', 'Present', NULL, 1),
(2, 1, '2023-01-16', 'Present', NULL, 1),
(11, 1, '2023-01-16', 'Present', NULL, 1),
(1, 1, '2023-01-18', 'Present', NULL, 1),
(2, 1, '2023-01-18', 'Absent', 'Medical leave', 1),
(11, 1, '2023-01-18', 'Present', NULL, 1),
(3, 4, '2023-01-17', 'Present', NULL, 3),
(4, 4, '2023-01-17', 'Present', NULL, 3),
(13, 4, '2023-01-17', 'Late', 'Arrived 15 minutes late', 3),
(3, 4, '2023-01-19', 'Present', NULL, 3),
(4, 4, '2023-01-19', 'Present', NULL, 3),
(13, 4, '2023-01-19', 'Present', NULL, 3),
(9, 10, '2023-01-16', 'Present', NULL, 6),
(10, 10, '2023-01-16', 'Present', NULL, 6),
(9, 10, '2023-01-18', 'Absent', 'Personal reasons', 6),
(10, 10, '2023-01-18', 'Present', NULL, 6);

-- Insert data into library_books
INSERT INTO library_books (title, author, isbn, publisher, publication_year, category, subject, pages, available_copies, total_copies, location_shelf) VALUES
('Database System Concepts', 'Abraham Silberschatz, Henry F. Korth, S. Sudarshan', '9780073523323', 'McGraw-Hill Education', 2019, 'Textbook', 'Database', 1376, 5, 5, 'DB-01-A'),
('Introduction to Algorithms', 'Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein', '9780262033848', 'MIT Press', 2009, 'Textbook', 'Algorithms', 1312, 3, 3, 'CS-02-B'),
('Artificial Intelligence: A Modern Approach', 'Stuart Russell, Peter Norvig', '9780134610993', 'Pearson', 2020, 'Textbook', 'Artificial Intelligence', 1152, 4, 5, 'AI-01-C'),
('Python for Data Analysis', 'Wes McKinney', '9781491957660', "O'Reilly Media", 2017, 'Reference', 'Data Science', 544, 2, 3, 'DS-03-A'),
('Computer Networks', 'Andrew S. Tanenbaum, David J. Wetherall', '9780132126953', 'Pearson', 2010, 'Textbook', 'Computer Networks', 960, 3, 3, 'CN-01-B'),
('Machine Learning: A Probabilistic Perspective', 'Kevin P. Murphy', '9780262018029', 'MIT Press', 2012, 'Advanced', 'Machine Learning', 1104, 1, 2, 'ML-02-C'),
('Clean Code: A Handbook of Agile Software Craftsmanship', 'Robert C. Martin', '9780132350884', 'Prentice Hall', 2008, 'Professional', 'Software Engineering', 464, 0, 2, 'SE-01-A'),
('The Pragmatic Programmer', 'Andrew Hunt, David Thomas', '9780201616224', 'Addison-Wesley Professional', 1999, 'Professional', 'Software Engineering', 352, 1, 1, 'SE-01-B'),
('Data Science for Business', 'Foster Provost, Tom Fawcett', '9781449361327', "O'Reilly Media", 2013, 'Business', 'Data Science', 414, 2, 2, 'DS-01-C'),
('SQL Cookbook', 'Anthony Molinaro', '9780596009762', "O'Reilly Media", 2005, 'Reference', 'Database', 636, 1, 2, 'DB-02-A');

-- Insert data into book_borrowings
INSERT INTO book_borrowings (book_id, student_id, borrow_date, due_date, return_date, fine_amount, status) VALUES
(1, 9, '2023-01-20', '2023-02-03', '2023-02-02', 0.00, 'Returned'),
(1, 10, '2023-02-05', '2023-02-19', NULL, 0.00, 'Borrowed'),
(2, 1, '2023-01-15', '2023-01-29', '2023-01-28', 0.00, 'Returned'),
(2, 2, '2023-02-01', '2023-02-15', '2023-02-20', 100.00, 'Returned'),
(3, 7, '2023-01-25', '2023-02-08', '2023-02-07', 0.00, 'Returned'),
(3, 8, '2023-02-10', '2023-02-24', NULL, 0.00, 'Borrowed'),
(4, 3, '2023-01-18', '2023-02-01', '2023-02-05', 80.00, 'Returned'),
(4, 4, '2023-02-07', '2023-02-21', NULL, 0.00, 'Borrowed'),
(7, 5, '2023-01-22', '2023-02-05', NULL, 210.00, 'Overdue'),
(8, 6, '2023-01-30', '2023-02-13', '2023-02-13', 0.00, 'Returned');

-- Insert data into events
INSERT INTO events (event_name, description, start_datetime, end_datetime, location, organizer_id, department_id, max_participants, registration_deadline, event_type, is_public) VALUES
('Database Workshop', 'Hands-on workshop on advanced SQL and NoSQL databases', '2023-03-15 10:00:00', '2023-03-15 16:00:00', 'Lab 101, Block B', 6, 5, 30, '2023-03-10', 'Workshop', TRUE),
('AI Conference', 'Annual conference on the latest developments in AI and Machine Learning', '2023-04-20 09:00:00', '2023-04-21 17:00:00', 'Main Auditorium', 5, 4, 200, '2023-04-10', 'Conference', TRUE),
('Programming Contest', 'Competitive programming contest for students', '2023-03-25 14:00:00', '2023-03-25 18:00:00', 'Lab Complex, Block A', 1, 1, 50, '2023-03-20', 'Other', TRUE),
('Data Science Seminar', 'Industry experts sharing insights on data science careers', '2023-04-05 15:00:00', '2023-04-05 17:00:00', 'Seminar Hall 2', 3, 2, 100, '2023-04-01', 'Seminar', TRUE),
('Tech Fest', 'Annual technology festival with various competitions and events', '2023-05-01 09:00:00', '2023-05-03 18:00:00', 'Entire Campus', 4, 3, 500, '2023-04-25', 'Cultural', TRUE);

-- Insert data into event_registrations
INSERT INTO event_registrations (event_id, student_id, registration_date, attended) VALUES
(1, 9, '2023-03-01 10:15:00', TRUE),
(1, 10, '2023-03-01 11:30:00', TRUE),
(1, 14, '2023-03-02 09:45:00', FALSE),
(2, 7, '2023-03-25 14:20:00', NULL),
(2, 8, '2023-03-26 16:10:00', NULL),
(2, 13, '2023-03-27 10:30:00', NULL),
(3, 1, '2023-03-15 09:00:00', NULL),
(3, 2, '2023-03-15 09:15:00', NULL),
(3, 11, '2023-03-16 10:45:00', NULL),
(3, 12, '2023-03-16 11:30:00', NULL),
(4, 3, '2023-03-20 15:40:00', NULL),
(4, 4, '2023-03-21 14:25:00', NULL),
(5, 5, '2023-04-10 10:15:00', NULL),
(5, 6, '2023-04-10 11:30:00', NULL),
(5, 15, '2023-04-11 09:45:00', NULL);

-- Insert data into payments
INSERT INTO payments (student_id, amount, payment_date, payment_method, payment_status, transaction_id, payment_purpose, semester, academic_year, remarks, receipt_number) VALUES
(1, 45000.00, '2023-01-05 10:15:00', 'Net Banking', 'Completed', 'TXN123456789', 'Tuition', 'Spring', '2022-2023', 'Full semester payment', 'RCP001'),
(2, 45000.00, '2023-01-06 11:30:00', 'Credit Card', 'Completed', 'TXN123456790', 'Tuition', 'Spring', '2022-2023', 'Full semester payment', 'RCP002'),
(3, 45000.00, '2023-01-05 14:20:00', 'UPI', 'Completed', 'TXN123456791', 'Tuition', 'Spring', '2022-2023', 'Full semester payment', 'RCP003'),
(4, 45000.00, '2023-01-06 09:45:00', 'Debit Card', 'Completed', 'TXN123456792', 'Tuition', 'Spring', '2022-2023', 'Full semester payment', 'RCP004'),
(5, 45000.00, '2023-01-07 10:30:00', 'Net Banking', 'Completed', 'TXN123456793', 'Tuition', 'Spring', '2022-2023', 'Full semester payment', 'RCP005'),
(2, 100.00, '2023-02-21 15:10:00', 'Cash', 'Completed', 'TXN123456794', 'Library Fine', 'Spring', '2022-2023', 'Late book return', 'RCP006'),
(3, 80.00, '2023-02-06 14:30:00', 'UPI', 'Completed', 'TXN123456795', 'Library Fine', 'Spring', '2022-2023', 'Late book return', 'RCP007'),
(9, 500.00, '2023-03-01 09:15:00', 'Credit Card', 'Completed', 'TXN123456796', 'Event Registration', 'Spring', '2022-2023', 'Database Workshop registration fee', 'RCP008'),
(10, 500.00, '2023-03-01 11:45:00', 'UPI', 'Completed', 'TXN123456797', 'Event Registration', 'Spring', '2022-2023', 'Database Workshop registration fee', 'RCP009'),
(14, 500.00, '2023-03-02 10:20:00', 'Debit Card', 'Completed', 'TXN123456798', 'Event Registration', 'Spring', '2022-2023', 'Database Workshop registration fee', 'RCP010');

-- Insert data into login_history
INSERT INTO login_history (student_id, instructor_id, login_datetime, logout_datetime, ip_address, device_info) VALUES
(1, NULL, '2023-02-01 09:15:00', '2023-02-01 10:30:00', '192.168.1.101', 'Windows 10, Chrome 98.0.4758.102'),
(2, NULL, '2023-02-01 10:45:00', '2023-02-01 12:15:00', '192.168.1.102', 'macOS 12.2, Safari 15.3'),
(NULL, 1, '2023-02-01 08:30:00', '2023-02-01 16:45:00', '192.168.1.201', 'Windows 11, Edge 98.0.1108.50'),
(NULL, 6, '2023-02-01 09:00:00', '2023-02-01 17:00:00', '192.168.1.202', 'Ubuntu 20.04, Firefox 97.0'),
(3, NULL, '2023-02-02 11:30:00', '2023-02-02 13:45:00', '192.168.1.103', 'Android 12, Chrome Mobile 98.0.4758.101'),
(4, NULL, '2023-02-02 14:15:00', '2023-02-02 15:30:00', '192.168.1.104', 'iOS 15.3, Safari Mobile'),
(NULL, 3, '2023-02-02 08:45:00', '2023-02-02 16:30:00', '192.168.1.203', 'macOS 12.2, Chrome 98.0.4758.102'),
(5, NULL, '2023-02-03 09:30:00', '2023-02-03 11:00:00', '192.168.1.105', 'Windows 10, Firefox 97.0'),
(NULL, 5, '2023-02-03 08:15:00', '2023-02-03 17:15:00', '192.168.1.204', 'Windows 10, Chrome 98.0.4758.102'),
(1, NULL, '2023-02-04 10:00:00', '2023-02-04 12:30:00', '192.168.1.106', 'Windows 10, Chrome 98.0.4758.102');

-- ========================================
-- SECTION 4: BASIC QUERIES (DML - SELECT)
-- ========================================

-- Simple SELECT with conditions
SELECT student_id, first_name, last_name, email
FROM students
WHERE department_id = 1 AND cgpa > 8.5;

-- ORDER BY example
SELECT course_id, course_name, credits
FROM courses
ORDER BY credits DESC, course_name ASC;

-- LIMIT and OFFSET example
SELECT * FROM students
ORDER BY cgpa DESC
LIMIT 5 OFFSET 0; -- Top 5 students by CGPA

-- Aggregate functions (COUNT, AVG, SUM, MIN, MAX)
SELECT 
    department_id,
    COUNT(*) AS total_students,
    AVG(cgpa) AS average_cgpa,
    MIN(cgpa) AS min_cgpa,
    MAX(cgpa) AS max_cgpa
FROM students
GROUP BY department_id;

-- HAVING clause (filtering after grouping)
SELECT 
    department_id,
    COUNT(*) AS student_count,
    AVG(cgpa) AS average_cgpa
FROM students
GROUP BY department_id
HAVING AVG(cgpa) > 8.0
ORDER BY average_cgpa DESC;

-- ============================================
-- SECTION 5: JOINS AND RELATIONSHIP QUERIES
-- ============================================

-- INNER JOIN (students and their departments)
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    d.department_name
FROM students s
INNER JOIN departments d ON s.department_id = d.department_id;

-- LEFT JOIN (all students and their enrollments, if any)
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    e.course_id,
    e.grade
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
ORDER BY s.student_id, e.course_id;

-- RIGHT JOIN (all courses and their enrollments, if any)
SELECT 
    c.course_id,
    c.course_name,
    e.student_id,
    e.grade
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
ORDER BY c.course_id, e.student_id;

-- Multiple table join (students, courses, and instructors)
SELECT 
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    c.course_name,
    i.first_name AS instructor_first_name,
    i.last_name AS instructor_last_name,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN instructors i ON c.instructor_id = i.instructor_id
WHERE e.status = 'Active'
ORDER BY c.course_name, s.last_name, s.first_name;

-- Joining multiple tables with aggregation
SELECT 
    d.department_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    COUNT(DISTINCT c.course_id) AS total_courses,
    COUNT(DISTINCT i.instructor_id) AS total_instructors
FROM departments d
LEFT JOIN students s ON d.department_id = s.department_id
LEFT JOIN courses c ON d.department_id = c.department_id
LEFT JOIN instructors i ON d.department_id = i.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_students DESC;

-- Self join (finding instructors in the same department)
SELECT 
    i1.instructor_id,
    CONCAT(i1.first_name, ' ', i1.last_name) AS instructor_name,
    i2.instructor_id AS colleague_id,
    CONCAT(i2.first_name, ' ', i2.last_name) AS colleague_name,
    d.department_name
FROM instructors i1
JOIN instructors i2 ON i1.department_id = i2.department_id AND i1.instructor_id < i2.instructor_id
JOIN departments d ON i1.department_id = d.department_id
ORDER BY d.department_name, instructor_name;

-- ==========================================
-- SECTION 6: SUBQUERIES
-- ==========================================

-- Subquery in WHERE clause
SELECT student_id, first_name, last_name, cgpa
FROM students
WHERE cgpa > (SELECT AVG(cgpa) FROM students);

-- Subquery with IN operator
SELECT first_name, last_name, email
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE grade = 'A+'
);

-- Subquery in FROM clause (derived table)
SELECT dept_stats.department_name, dept_stats.avg_salary
FROM (
    SELECT 
        d.department_name,
        AVG(i.salary) AS avg_salary
    FROM departments d
    JOIN instructors i ON d.department_id = i.department_id
    GROUP BY d.department_id, d.department_name
) AS dept_stats
WHERE dept_stats.avg_salary > 80000
ORDER BY dept_stats.avg_salary DESC;

-- Correlated subquery
SELECT 
    c.course_id,
    c.course_name,
    c.credits,
    (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id) AS student_count
FROM courses c
ORDER BY student_count DESC;

-- EXISTS operator with subquery
SELECT 
    d.department_id,
    d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM courses c
    WHERE c.department_id = d.department_id
    AND c.credits > 3
);

-- ==========================================
-- SECTION 7: ADVANCED QUERIES
-- ==========================================

-- CASE statement
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
FROM students
ORDER BY cgpa DESC;

-- Window functions (ROW_NUMBER, RANK, DENSE_RANK)
SELECT 
    student_id,
    first_name,
    last_name,
    department_id,
    cgpa,
    ROW_NUMBER() OVER (ORDER BY cgpa DESC) AS overall_rank,
    RANK() OVER (PARTITION BY department_id ORDER BY cgpa DESC) AS dept_rank,
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY cgpa DESC) AS dept_dense_rank
FROM students;

-- Window functions with aggregate
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    d.department_name,
    s.cgpa,
    AVG(s.cgpa) OVER (PARTITION BY s.department_id) AS dept_avg_cgpa,
    s.cgpa - AVG(s.cgpa) OVER (PARTITION BY s.department_id) AS diff_from_dept_avg
FROM students s
JOIN departments d ON s.department_id = d.department_id
ORDER BY d.department_name, s.cgpa DESC;

-- Common Table Expressions (CTE)
WITH StudentGradeCounts AS (
    SELECT 
        student_id,
        COUNT(CASE WHEN grade = 'A+' THEN 1 END) AS a_plus_count,
        COUNT(CASE WHEN grade = 'A' THEN 1 END) AS a_count,
        COUNT(CASE WHEN grade = 'A-' THEN 1 END) AS a_minus_count,
        COUNT(CASE WHEN grade LIKE 'B%' THEN 1 END) AS b_grades_count,
        COUNT(*) AS total_courses
    FROM enrollments
    GROUP BY student_id
)
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    gc.a_plus_count,
    gc.a_count,
    gc.a_minus_count,
    gc.b_grades_count,
    gc.total_courses
FROM students s
JOIN StudentGradeCounts gc ON s.student_id = gc.student_id
ORDER BY gc.a_plus_count DESC, gc.a_count DESC;

-- Recursive CTE
-- Simulating a course prerequisite hierarchy
WITH RECURSIVE CourseHierarchy AS (
    -- Base case: Start with Database Management Systems course
    SELECT course_id, course_name, 0 AS level
    FROM courses
    WHERE course_code = 'DB101'
    
    UNION ALL
    
    -- Recursive case: Add subsequent courses (simulating prerequisites)
    SELECT c.course_id, c.course_name, ch.level + 1
    FROM courses c
    JOIN CourseHierarchy ch ON c.course_code = 
        CASE 
            WHEN ch.course_name = 'Database Management Systems' THEN 'DB201'
            WHEN ch.course_name = 'Advanced Database Concepts' THEN 'DB301'
            ELSE NULL
        END
    WHERE c.course_code IN ('DB201', 'DB301') AND ch.level < 5
)
SELECT level, course_id, course_name
FROM CourseHierarchy
ORDER BY level;

-- String functions
SELECT 
    student_id,
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    UPPER(first_name) AS upper_first_name,
    LOWER(last_name) AS lower_last_name,
    LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length,
    SUBSTRING(first_name, 1, 1) AS first_initial,
    CONCAT(SUBSTRING(first_name, 1, 1), '. ', last_name) AS formatted_name
FROM students
LIMIT 10;

-- Date and time functions
SELECT 
    enrollment_id,
    student_id,
    course_id,
    enrollment_date,
    YEAR(enrollment_date) AS enrollment_year,
    MONTH(enrollment_date) AS enrollment_month,
    DAY(enrollment_date) AS enrollment_day,
    DATE_ADD(enrollment_date, INTERVAL 6 MONTH) AS six_months_later,
    DATEDIFF(CURRENT_DATE, enrollment_date) AS days_since_enrollment
FROM enrollments
LIMIT 10;

-- Pivoting data with conditional aggregation
SELECT 
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS total_students,
    SUM(CASE WHEN e.grade = 'A+' THEN 1 ELSE 0 END) AS a_plus_count,
    SUM(CASE WHEN e.grade = 'A' THEN 1 ELSE 0 END) AS a_count,
    SUM(CASE WHEN e.grade = 'A-' THEN 1 ELSE 0 END) AS a_minus_count,
    SUM(CASE WHEN e.grade = 'B+' THEN 1 ELSE 0 END) AS b_plus_count,
    SUM(CASE WHEN e.grade = 'B' THEN 1 ELSE 0 END) AS b_count,
    SUM(CASE WHEN e.grade = 'B-' THEN 1 ELSE 0 END) AS b_minus_count,
    SUM(CASE WHEN e.grade = 'C+' THEN 1 ELSE 0 END) AS c_plus_count
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_id;

-- UNION, INTERSECT, EXCEPT operations
-- Students who are enrolled in both Database and AI courses
SELECT s.student_id, s.first_name, s.last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.department_id = 5  -- Database department
INTERSECT
SELECT s.student_id, s.first_name, s.last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.department_id = 4;  -- AI department

-- ==========================================
-- SECTION 8: DATABASE UPDATES (DML - UPDATE/DELETE)
-- ==========================================

-- UPDATE single record
UPDATE students
SET phone = '9876543216', address = '123 New Address, Mumbai'
WHERE student_id = 1;

-- UPDATE multiple records
UPDATE courses
SET max_students = 40
WHERE department_id = 1 AND credits = 4;

-- UPDATE with JOIN
UPDATE enrollments e
JOIN submissions s ON e.student_id = s.student_id AND e.course_id = (
    SELECT course_id FROM assignments WHERE assignment_id = s.assignment_id
)
SET e.grade = 'A+'
WHERE s.score > 95;

-- DELETE single record
DELETE FROM attendance 
WHERE student_id = 2 AND course_id = 1 AND attendance_date = '2023-01-18';

-- DELETE with JOIN
DELETE e
FROM event_registrations e
JOIN events ev ON e.event_id = ev.event_id
WHERE ev.event_type = 'Workshop' AND e.attended = FALSE;

-- ==========================================
-- SECTION 9: VIEWS
-- ==========================================

-- Create a simple view
CREATE OR REPLACE VIEW student_department_view AS
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    s.phone,
    s.cgpa,
    d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id;

-- Query from the view
SELECT * FROM student_department_view WHERE cgpa > 8.5;

-- Create a complex view with calculations
CREATE OR REPLACE VIEW student_performance_view AS
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
    COUNT(e.course_id) AS courses_enrolled,
    AVG(CASE 
        WHEN e.grade = 'A+' THEN 10.0
        WHEN e.grade = 'A' THEN 9.0
        WHEN e.grade = 'A-' THEN 8.5
        WHEN e.grade = 'B+' THEN 8.0
        WHEN e.grade = 'B' THEN 7.0
        WHEN e.grade = 'B-' THEN 6.5
        WHEN e.grade = 'C+' THEN 6.0
        ELSE 5.0
    END) AS grade_point_average,
    s.cgpa AS cumulative_gpa
FROM students s
JOIN departments d ON s.department_id = d.department_id
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, student_name, d.department_name, s.cgpa;

-- Query from the complex view
SELECT * FROM student_performance_view ORDER BY grade_point_average DESC;

-- Continuing from where we left off...

-- Complete the instructor_workload_view that was cut off
CREATE OR REPLACE VIEW instructor_workload_view AS
SELECT 
    i.instructor_id,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor_name,
    d.department_name,
    COUNT(DISTINCT c.course_id) AS courses_teaching,
    SUM(c.hours_per_week) AS total_teaching_hours,
    COUNT(DISTINCT e.student_id) AS total_students,
    ROUND(AVG(s.score), 2) AS avg_assignment_score
FROM instructors i
JOIN departments d ON i.department_id = d.department_id
LEFT JOIN courses c ON i.instructor_id = c.instructor_id
LEFT JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN assignments a ON c.course_id = a.course_id
LEFT JOIN submissions s ON a.assignment_id = s.assignment_id AND s.student_id = e.student_id
GROUP BY i.instructor_id, instructor_name, d.department_name;

-- Query the instructor workload view
SELECT * FROM instructor_workload_view ORDER BY total_teaching_hours DESC;

-- Updatable view (simple view that can be updated)
CREATE OR REPLACE VIEW active_students AS
SELECT student_id, first_name, last_name, email, phone, cgpa, is_active
FROM students
WHERE is_active = TRUE
WITH CHECK OPTION;

-- You can update through this view (only active students)
UPDATE active_students SET phone = '9999999999' WHERE student_id = 1;

-- ==========================================
-- SECTION 10: STORED PROCEDURES
-- ==========================================

-- Basic stored procedure with no parameters
DELIMITER //
CREATE PROCEDURE GetAllDepartments()
BEGIN
    SELECT * FROM departments ORDER BY department_name;
END //
DELIMITER ;

-- Call the procedure
CALL GetAllDepartments();

-- Stored procedure with input parameters
DELIMITER //
CREATE PROCEDURE GetStudentsByDepartment(IN dept_id INT)
BEGIN
    SELECT 
        s.student_id,
        s.first_name,
        s.last_name,
        s.email,
        s.cgpa,
        d.department_name
    FROM students s
    JOIN departments d ON s.department_id = d.department_id
    WHERE s.department_id = dept_id
    ORDER BY s.cgpa DESC;
END //
DELIMITER ;

-- Call procedure with parameters
CALL GetStudentsByDepartment(1);

-- Stored procedure with output parameters
DELIMITER //
CREATE PROCEDURE GetDepartmentStats(
    IN dept_id INT,
    OUT student_count INT,
    OUT avg_cgpa DECIMAL(3,2),
    OUT course_count INT
)
BEGIN
    -- Get student count and average CGPA
    SELECT 
        COUNT(*),
        AVG(cgpa)
    INTO student_count, avg_cgpa
    FROM students
    WHERE department_id = dept_id;
    
    -- Get course count
    SELECT COUNT(*)
    INTO course_count
    FROM courses
    WHERE department_id = dept_id;
END //
DELIMITER ;

-- Call procedure with output parameters
CALL GetDepartmentStats(1, @students, @avg_cgpa, @courses);
SELECT @students AS student_count, @avg_cgpa AS average_cgpa, @courses AS course_count;

-- Stored procedure with conditional logic
DELIMITER //
CREATE PROCEDURE AssignGrade(
    IN student_id_param INT,
    IN course_id_param INT,
    IN score DECIMAL(5,2)
)
BEGIN
    DECLARE grade_value VARCHAR(2);
    
    -- Determine grade based on score
    IF score >= 95 THEN
        SET grade_value = 'A+';
    ELSEIF score >= 90 THEN
        SET grade_value = 'A';
    ELSEIF score >= 85 THEN
        SET grade_value = 'A-';
    ELSEIF score >= 80 THEN
        SET grade_value = 'B+';
    ELSEIF score >= 75 THEN
        SET grade_value = 'B';
    ELSEIF score >= 70 THEN
        SET grade_value = 'B-';
    ELSEIF score >= 65 THEN
        SET grade_value = 'C+';
    ELSE
        SET grade_value = 'C';
    END IF;
    
    -- Update the enrollment record
    UPDATE enrollments
    SET grade = grade_value
    WHERE student_id = student_id_param AND course_id = course_id_param;
    
    -- Return the assigned grade
    SELECT CONCAT('Assigned grade: ', grade_value) AS result;
END //
DELIMITER ;

-- Call the grade assignment procedure
CALL AssignGrade(1, 1, 92.5);

-- Stored procedure with error handling
DELIMITER //
CREATE PROCEDURE EnrollStudent(
    IN student_id_param INT,
    IN course_id_param INT
)
BEGIN
    DECLARE student_exists INT DEFAULT 0;
    DECLARE course_exists INT DEFAULT 0;
    DECLARE already_enrolled INT DEFAULT 0;
    DECLARE current_count INT DEFAULT 0;
    DECLARE max_students_allowed INT DEFAULT 0;
    
    -- Check if student exists
    SELECT COUNT(*) INTO student_exists
    FROM students
    WHERE student_id = student_id_param;
    
    -- Check if course exists and get max_students
    SELECT COUNT(*), max_students INTO course_exists, max_students_allowed
    FROM courses
    WHERE course_id = course_id_param;
    
    -- Check if already enrolled
    SELECT COUNT(*) INTO already_enrolled
    FROM enrollments
    WHERE student_id = student_id_param AND course_id = course_id_param;
    
    -- Get current enrollment count
    SELECT COUNT(*) INTO current_count
    FROM enrollments
    WHERE course_id = course_id_param;
    
    -- Handle possible errors
    IF student_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Student does not exist';
    ELSEIF course_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Course does not exist';
    ELSEIF already_enrolled > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Student already enrolled in this course';
    ELSEIF current_count >= max_students_allowed THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Course has reached maximum enrollment';
    ELSE
        -- Enroll the student
        INSERT INTO enrollments (student_id, course_id, enrollment_date, status)
        VALUES (student_id_param, course_id_param, CURDATE(), 'Active');
        
        SELECT 'Student successfully enrolled' AS result;
    END IF;
END //
DELIMITER ;

-- Call the enrollment procedure
CALL EnrollStudent(5, 3);

-- Stored procedure with loops
DELIMITER //
CREATE PROCEDURE GenerateAttendanceRecords(
    IN course_id_param INT,
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    DECLARE current_date DATE;
    DECLARE done INT DEFAULT 0;
    DECLARE student_id_var INT;
    DECLARE student_cursor CURSOR FOR
        SELECT student_id
        FROM enrollments
        WHERE course_id = course_id_param AND status = 'Active';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Set current date to start date
    SET current_date = start_date;
    
    -- Loop through dates
    WHILE current_date <= end_date DO
        -- Skip weekends (Saturday=6, Sunday=0)
        IF DAYOFWEEK(current_date) != 1 AND DAYOFWEEK(current_date) != 7 THEN
            -- Open cursor
            OPEN student_cursor;
            
            student_loop: LOOP
                FETCH student_cursor INTO student_id_var;
                IF done THEN
                    LEAVE student_loop;
                END IF;
                
                -- Insert attendance record (default to 'Present')
                INSERT IGNORE INTO attendance 
                    (student_id, course_id, attendance_date, status, recorded_by)
                VALUES 
                    (student_id_var, course_id_param, current_date, 'Present', 
                     (SELECT instructor_id FROM courses WHERE course_id = course_id_param));
            END LOOP;
            
            -- Close cursor and reset done flag
            CLOSE student_cursor;
            SET done = 0;
        END IF;
        
        -- Move to next day
        SET current_date = DATE_ADD(current_date, INTERVAL 1 DAY);
    END WHILE;
    
    SELECT CONCAT('Attendance records generated from ', start_date, ' to ', end_date) AS result;
END //
DELIMITER ;

-- Call the attendance generation procedure
CALL GenerateAttendanceRecords(1, '2023-03-01', '2023-03-10');

-- ==========================================
-- SECTION 11: FUNCTIONS
-- ==========================================

-- Create a scalar function to calculate GPA from score
DELIMITER //
CREATE FUNCTION CalculateGPA(score DECIMAL(5,2)) 
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE gpa DECIMAL(3,2);
    
    IF score >= 95 THEN
        SET gpa = 10.0;
    ELSEIF score >= 90 THEN
        SET gpa = 9.0;
    ELSEIF score >= 85 THEN
        SET gpa = 8.5;
    ELSEIF score >= 80 THEN
        SET gpa = 8.0;
    ELSEIF score >= 75 THEN
        SET gpa = 7.0;
    ELSEIF score >= 70 THEN
        SET gpa = 6.5;
    ELSEIF score >= 65 THEN
        SET gpa = 6.0;
    ELSE
        SET gpa = 5.0;
    END IF;
    
    RETURN gpa;
END //
DELIMITER ;

-- Use the function in a query
SELECT 
    submission_id,
    student_id,
    score,
    CalculateGPA(score) AS gpa
FROM submissions
WHERE score IS NOT NULL;

-- Function to get student full name
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

-- Use the function
SELECT 
    e.enrollment_id,
    e.student_id,
    GetStudentFullName(e.student_id) AS student_name,
    c.course_name,
    e.grade
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
LIMIT 10;

-- Function to calculate age
DELIMITER //
CREATE FUNCTION CalculateAge(birth_date DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
END //
DELIMITER ;

-- Use the age function
SELECT 
    student_id,
    first_name,
    last_name,
    date_of_birth,
    CalculateAge(date_of_birth) AS age
FROM students
ORDER BY age DESC;

-- ==========================================
-- SECTION 12: TRIGGERS
-- ==========================================

-- Trigger to update available copies when a book is borrowed
DELIMITER //
CREATE TRIGGER after_book_borrowed
AFTER INSERT ON book_borrowings
FOR EACH ROW
BEGIN
    -- Decrease available copies when book is borrowed
    UPDATE library_books
    SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id;
END //
DELIMITER ;

-- Trigger to update available copies when a book is returned
DELIMITER //
CREATE TRIGGER after_book_returned
AFTER UPDATE ON book_borrowings
FOR EACH ROW
BEGIN
    -- Increase available copies when book is returned
    IF NEW.return_date IS NOT NULL AND OLD.return_date IS NULL THEN
        UPDATE library_books
        SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id;
    END IF;
END //
DELIMITER ;

-- Trigger to automatically calculate fine amount when returning a book late
DELIMITER //
CREATE TRIGGER before_book_return
BEFORE UPDATE ON book_borrowings
FOR EACH ROW
BEGIN
    -- Calculate fine if book is returned late
    IF NEW.return_date IS NOT NULL AND OLD.return_date IS NULL THEN
        IF NEW.return_date > NEW.due_date THEN
            SET NEW.fine_amount = DATEDIFF(NEW.return_date, NEW.due_date) * 10.00; -- ₹10 per day
            SET NEW.status = 'Returned';
        ELSE
            SET NEW.fine_amount = 0.00;
            SET NEW.status = 'Returned';
        END IF;
    END IF;
END //
DELIMITER ;

-- Trigger to prevent enrolling in more than 5 courses
DELIMITER //
CREATE TRIGGER before_enrollment
BEFORE INSERT ON enrollments
FOR EACH ROW
BEGIN
    DECLARE course_count INT;
    
    SELECT COUNT(*) INTO course_count
    FROM enrollments
    WHERE student_id = NEW.student_id AND status = 'Active';
    
    IF course_count >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student cannot enroll in more than 5 active courses';
    END IF;
END //
DELIMITER ;

-- Trigger to log database changes
CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(10) NOT NULL,
    table_name VARCHAR(50) NOT NULL,
    record_id INT NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSON,
    new_data JSON
);

-- Example of an audit trigger
DELIMITER //
CREATE TRIGGER students_audit_trigger
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
        action_type, 
        table_name, 
        record_id, 
        user_name,
        old_data,
        new_data
    )
    VALUES (
        'UPDATE',
        'students',
        NEW.student_id,
        CURRENT_USER(),
        JSON_OBJECT(
            'first_name', OLD.first_name,
            'last_name', OLD.last_name,
            'email', OLD.email,
            'phone', OLD.phone,
            'cgpa', OLD.cgpa,
            'is_active', OLD.is_active
        ),
        JSON_OBJECT(
            'first_name', NEW.first_name,
            'last_name', NEW.last_name,
            'email', NEW.email,
            'phone', NEW.phone,
            'cgpa', NEW.cgpa,
            'is_active', NEW.is_active
        )
    );
END //
DELIMITER ;

-- ==========================================
-- SECTION 13: TRANSACTIONS
-- ==========================================

-- Simple transaction example
START TRANSACTION;

    -- Insert a new student
    INSERT INTO students (
        first_name, last_name, date_of_birth, gender, email, 
        phone, address, city, state, postal_code, country, 
        enrollment_date, department_id, cgpa, is_active
    ) 
    VALUES (
        'Vaibhav', 'Mittal', '2000-01-30', 'Male', 'vaibhav.mittal@student.cdac.edu',
        '9876123416', '789 Student Hostel, Sector 16', 'Mumbai', 'Maharashtra', 
        '400009', 'India', CURDATE(), 3, 8.3, TRUE
    );
    
    SET @new_student_id = LAST_INSERT_ID();
    
    -- Enroll the student in courses
    INSERT INTO enrollments (student_id, course_id, enrollment_date, status)
    VALUES 
        (@new_student_id, 6, CURDATE(), 'Active'),
        (@new_student_id, 7, CURDATE(), 'Active');

COMMIT;  -- Or ROLLBACK if there's an error

-- Transaction with error handling using savepoints
DELIMITER //
CREATE PROCEDURE TransferCourseEnrollment(
    IN student_from INT,
    IN student_to INT,
    IN course_id_param INT
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET exit_handler = TRUE;
    
    START TRANSACTION;
    
    -- Save initial state
    SAVEPOINT initial_state;
    
    -- Check if student_from is enrolled in the course
    IF NOT EXISTS (
        SELECT 1 FROM enrollments 
        WHERE student_id = student_from AND course_id = course_id_param
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Source student is not enrolled in this course';
        ROLLBACK;
    END IF;
    
    -- Check if student_to already enrolled in the course
    IF EXISTS (
        SELECT 1 FROM enrollments 
        WHERE student_id = student_to AND course_id = course_id_param
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Target student is already enrolled in this course';
        ROLLBACK;
    END IF;
    
    -- Unenroll student_from
    DELETE FROM enrollments 
    WHERE student_id = student_from AND course_id = course_id_param;
    
    -- If any errors, rollback to savepoint
    IF exit_handler THEN
        ROLLBACK TO SAVEPOINT initial_state;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error removing source student from course';
        ROLLBACK;
    END IF;
    
    -- Create another savepoint
    SAVEPOINT after_delete;
    
    -- Enroll student_to
    INSERT INTO enrollments (student_id, course_id, enrollment_date, status)
    VALUES (student_to, course_id_param, CURDATE(), 'Active');
    
    -- If any errors, rollback to previous savepoint
    IF exit_handler THEN
        ROLLBACK TO SAVEPOINT after_delete;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error enrolling target student in course';
        ROLLBACK;
    END IF;
    
    -- If everything is successful, commit the transaction
    COMMIT;
    
    SELECT 'Course enrollment successfully transferred' AS result;
END //
DELIMITER ;

-- Call the transaction procedure
CALL TransferCourseEnrollment(1, 3, 1);

-- ==========================================
-- SECTION 14: INDEXES
-- ==========================================

-- Creating a basic index
CREATE INDEX idx_course_name ON courses(course_name);

-- Creating a composite index
CREATE INDEX idx_student_name_composite ON students(last_name, first_name);

-- Creating a unique index
CREATE UNIQUE INDEX idx_course_code_unique ON courses(course_code);

-- Creating a fulltext index
CREATE FULLTEXT INDEX idx_course_description ON courses(description);

-- Using the fulltext index
SELECT course_id, course_name, description
FROM courses
WHERE MATCH(description) AGAINST('database' IN NATURAL LANGUAGE MODE);

-- Functional index
CREATE INDEX idx_enrollment_year ON enrollments((YEAR(enrollment_date)));

-- Showing indexes on a table
SHOW INDEX FROM students;

-- ==========================================
-- SECTION 15: DATABASE SECURITY
-- ==========================================

-- Create users (NOTE: Actual implementation requires proper security considerations)
CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'student_password';
CREATE USER 'instructor_user'@'localhost' IDENTIFIED BY 'instructor_password';
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin_password';

-- Grant permissions to student user (read-only access to certain tables)
GRANT SELECT ON cdac_learning_db.courses TO 'student_user'@'localhost';
GRANT SELECT ON cdac_learning_db.departments TO 'student_user'@'localhost';
GRANT SELECT ON cdac_learning_db.instructors TO 'student_user'@'localhost';
GRANT SELECT ON cdac_learning_db.student_department_view TO 'student_user'@'localhost';

-- Allow students to view and update their own records only
GRANT SELECT, UPDATE ON cdac_learning_db.students TO 'student_user'@'localhost';
GRANT SELECT, UPDATE ON cdac_learning_db.enrollments TO 'student_user'@'localhost';

-- Create a procedure with definer rights
DELIMITER //
CREATE DEFINER = 'admin_user'@'localhost' 
PROCEDURE UpdateStudentInfo(
    IN student_id_param INT,
    IN phone_param VARCHAR(15),
    IN address_param TEXT,
    IN current_user_id INT
)
SQL SECURITY DEFINER
BEGIN
    -- Only allow update if the current_user_id matches the student_id_param
    IF current_user_id = student_id_param THEN
        UPDATE students
        SET 
            phone = phone_param,
            address = address_param
        WHERE student_id = student_id_param;
        
        SELECT 'Information updated successfully' AS result;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You can only update your own information';
    END IF;
END //
DELIMITER ;

-- Grant instructors more permissions
GRANT SELECT, INSERT, UPDATE ON cdac_learning_db.* TO 'instructor_user'@'localhost';
GRANT EXECUTE ON PROCEDURE cdac_learning_db.AssignGrade TO 'instructor_user'@'localhost';
GRANT EXECUTE ON PROCEDURE cdac_learning_db.GenerateAttendanceRecords TO 'instructor_user'@'localhost';

-- Grant admin full permissions
GRANT ALL PRIVILEGES ON cdac_learning_db.* TO 'admin_user'@'localhost';

-- Column-level security using views
CREATE OR REPLACE VIEW student_public_info AS
SELECT student_id, first_name, last_name, department_id
FROM students;

GRANT SELECT ON cdac_learning_db.student_public_info TO 'student_user'@'localhost';

-- Revoke permissions example
REVOKE INSERT, UPDATE ON cdac_learning_db.courses FROM 'instructor_user'@'localhost';

-- ==========================================
-- SECTION 16: ADVANCED SQL FEATURES
-- ==========================================

-- JSON data handling
ALTER TABLE students 
ADD COLUMN additional_info JSON;

-- Update with JSON data
UPDATE students
SET additional_info = '{"hobbies": ["reading", "swimming"], "languages": ["Hindi", "English"], "emergency_contact": {"name": "Parent Name", "relation": "Father", "phone": "9876543210"}}'
WHERE student_id = 1;

-- Query JSON data
SELECT 
    student_id, 
    first_name, 
    last_name,
    JSON_EXTRACT(additional_info, '$.hobbies') AS hobbies,
    JSON_EXTRACT(additional_info, '$.emergency_contact.name') AS emergency_contact_name
FROM students
WHERE JSON_CONTAINS(JSON_EXTRACT(additional_info, '$.hobbies'), '"reading"');

-- Using JSON_TABLE to normalize JSON data
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    h.hobby
FROM students s,
JSON_TABLE(
    JSON_EXTRACT(s.additional_info, '$.hobbies'),
    '$[*]' COLUMNS (hobby VARCHAR(50) PATH '$')
) AS h
WHERE s.additional_info IS NOT NULL;

-- Temporal tables (MySQL 8.0+)
CREATE TABLE course_offerings (
    offering_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    max_seats INT NOT NULL,
    instructor_id INT,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
) WITH SYSTEM VERSIONING;

-- Insert into temporal table
INSERT INTO course_offerings 
(course_id, semester, start_date, end_date, max_seats, instructor_id, is_active)
VALUES
(1, 'Fall 2023', '2023-08-15', '2023-12-15', 40, 1, TRUE),
(2, 'Fall 2023', '2023-08-15', '2023-12-15', 35, 1, TRUE),
(3, 'Fall 2023', '2023-08-15', '2023-12-15', 30, 2, TRUE);

-- Update temporal table
UPDATE course_offerings
SET max_seats = 45
WHERE offering_id = 1;

-- Query temporal data at a specific point in time
SELECT * FROM course_offerings FOR SYSTEM_TIME AS OF TIMESTAMP '2023-03-15 12:00:00';

-- Window functions with frames
SELECT 
    student_id,
    first_name,
    last_name,
    cgpa,
    AVG(cgpa) OVER () AS overall_avg,
    AVG(cgpa) OVER (PARTITION BY department_id) AS dept_avg,
    cgpa - AVG(cgpa) OVER (PARTITION BY department_id) AS diff_from_dept_avg,
    RANK() OVER (ORDER BY cgpa DESC) AS overall_rank,
    RANK() OVER (PARTITION BY department_id ORDER BY cgpa DESC) AS dept_rank,
    -- Running average of CGPA by department (ordered by student_id)
    AVG(cgpa) OVER (
        PARTITION BY department_id 
        ORDER BY student_id 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_dept_avg,
    -- Moving average of 3 students by department
    AVG(cgpa) OVER (
        PARTITION BY department_id 
        ORDER BY student_id 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3
FROM students;

-- Common Table Expressions with recursion
WITH RECURSIVE DateSeries AS (
    SELECT '2023-01-01' AS date
    UNION ALL
    SELECT DATE_ADD(date, INTERVAL 1 DAY)
    FROM DateSeries
    WHERE date < '2023-01-31'
)
SELECT 
    date,
    DAYNAME(date) AS day_of_week,
    CASE WHEN DAYOFWEEK(date) IN (1, 7) THEN 'Weekend' ELSE 'Weekday' END AS day_type
FROM DateSeries;

-- ==========================================
-- SECTION 17: DATABASE ADMINISTRATION TASKS
-- ==========================================

-- Backup database (these would be run at command line, not in MySQL client)
-- mysqldump -u root -p cdac_learning_db > cdac_learning_db_backup.sql

-- Restore database
-- mysql -u root -p cdac_learning_db < cdac_learning_db_backup.sql

-- Check table status
SHOW TABLE STATUS FROM cdac_learning_db;

-- Optimize tables
OPTIMIZE TABLE students, courses, enrollments;

-- Analyze tables to update statistics
ANALYZE TABLE students, courses, enrollments;

-- Check and repair tables
CHECK TABLE students, courses, enrollments;
REPAIR TABLE students, courses, enrollments;

-- Show process list
SHOW PROCESSLIST;

-- Kill a specific process if needed
-- KILL process_id;

-- Show storage engine for tables
SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'cdac_learning_db';

-- Change storage engine
ALTER TABLE students ENGINE = InnoDB;

-- ==========================================
-- SECTION 18: PRACTICAL SCENARIOS
-- ==========================================

-- 1. Find students who haven't submitted any assignments
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN assignments a ON c.course_id = a.course_id
LEFT JOIN submissions sub ON a.assignment_id = sub.assignment_id AND sub.student_id = s.student_id
WHERE sub.submission_id IS NULL
ORDER BY s.student_id, c.course_name;

-- 2. Calculate grade distribution by department
SELECT 
    d.department_name,
    COUNT(CASE WHEN e.grade = 'A+' THEN 1 END) AS a_plus_count,
    COUNT(CASE WHEN e.grade = 'A' THEN 1 END) AS a_count,
    COUNT(CASE WHEN e.grade = 'A-' THEN 1 END) AS a_minus_count,
    COUNT(CASE WHEN e.grade LIKE 'B%' THEN 1 END) AS b_grades_count,
    COUNT(CASE WHEN e.grade LIKE 'C%' THEN 1 END) AS c_grades_count,
    COUNT(e.grade) AS total_grades,
    ROUND(COUNT(CASE WHEN e.grade = 'A+' THEN 1 END) / COUNT(e.grade) * 100, 2) AS a_plus_percentage
FROM departments d
JOIN students s ON d.department_id = s.department_id
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY d.department_name
ORDER BY a_plus_percentage DESC;

-- 3. Find instructors with highest student ratings (assuming we add a ratings table)
CREATE TABLE instructor_ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    instructor_id INT NOT NULL,
    course_id INT NOT NULL,
    rating_score INT NOT NULL CHECK (rating_score BETWEEN 1 AND 5),
    comments TEXT,
    rating_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE KEY (student_id, instructor_id, course_id)
);

-- Insert sample ratings
INSERT INTO instructor_ratings (student_id, instructor_id, course_id, rating_score, comments) VALUES
(1, 1, 1, 5, 'Excellent teaching methods'),
(2, 1, 1, 4, 'Very helpful and clear explanations'),
(3, 3, 4, 5, 'Makes complex topics easy to understand'),
(4, 3, 4, 5, 'Best data science instructor'),
(5, 4, 6, 3, 'Good but could explain concepts better'),
(6, 4, 6, 4, 'Knowledgeable instructor'),
(7, 5, 8, 5, 'Very passionate about AI'),
(8, 5, 8, 5, 'Amazing instructor, great practical examples'),
(9, 6, 10, 4, 'Clear explanations of database concepts'),
(10, 6, 10, 4, 'Helpful and supportive');

-- Query to find instructors with highest ratings
SELECT 
    i.instructor_id,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor_name,
    d.department_name,
    ROUND(AVG(r.rating_score), 2) AS avg_rating,
    COUNT(r.rating_id) AS total_ratings,
    STRING_AGG(DISTINCT c.course_name, ', ') AS courses_taught
FROM instructors i
JOIN departments d ON i.department_id = d.department_id
JOIN instructor_ratings r ON i.instructor_id = r.instructor_id
JOIN courses c ON r.course_id = c.course_id
GROUP BY i.instructor_id, instructor_name, d.department_name
HAVING COUNT(r.rating_id) >= 2
ORDER BY avg_rating DESC, total_ratings DESC;

-- 4. Identify courses with low completion rates
SELECT 
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS enrolled_students,
    SUM(CASE WHEN e.status = 'Completed' THEN 1 ELSE 0 END) AS completed_students,
    ROUND(SUM(CASE WHEN e.status = 'Completed' THEN 1 ELSE 0 END) / COUNT(e.student_id) * 100, 2) AS completion_rate
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) > 0
ORDER BY completion_rate ASC;

-- 5. Find overdue library books and calculate fines
SELECT 
    b.borrow_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    lb.title AS book_title,
    lb.author,
    b.borrow_date,
    b.due_date,
    DATEDIFF(CURRENT_DATE, b.due_date) AS days_overdue,
    DATEDIFF(CURRENT_DATE, b.due_date) * 10.00 AS estimated_fine
FROM book_borrowings b
JOIN students s ON b.student_id = s.student_id
JOIN library_books lb ON b.book_id = lb.book_id
WHERE b.return_date IS NULL AND b.due_date < CURRENT_DATE
ORDER BY days_overdue DESC;

-- 6. Generate comprehensive student transcripts
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email,
    d.department_name,
    s.enrollment_date,
    c.course_id,
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
        WHEN e.grade = 'B-' THEN 6.5
        WHEN e.grade = 'C+' THEN 6.0
        ELSE 5.0
    END AS grade_points,
    c.credits * CASE 
        WHEN e.grade = 'A+' THEN 10.0
        WHEN e.grade = 'A' THEN 9.0
        WHEN e.grade = 'A-' THEN 8.5
        WHEN e.grade = 'B+' THEN 8.0
        WHEN e.grade = 'B' THEN 7.0
        WHEN e.grade = 'B-' THEN 6.5
        WHEN e.grade = 'C+' THEN 6.0
        ELSE 5.0
    END AS weighted_points
FROM students s
JOIN departments d ON s.department_id = d.department_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = 1  -- Change to get transcript for a specific student
ORDER BY c.course_code;

-- 7. Create a stored procedure to generate a full transcript as a report
DELIMITER //
CREATE PROCEDURE GenerateTranscript(IN student_id_param INT)
BEGIN
    DECLARE student_name VARCHAR(101);
    DECLARE dept_name VARCHAR(100);
    DECLARE enroll_date DATE;
    DECLARE total_credits INT DEFAULT 0;
    DECLARE gpa DECIMAL(3,2) DEFAULT 0.0;
    DECLARE total_points DECIMAL(10,2) DEFAULT 0.0;
    
    -- Get student details
    SELECT 
        CONCAT(first_name, ' ', last_name),
        d.department_name,
        s.enrollment_date
    INTO 
        student_name,
        dept_name,
        enroll_date
    FROM students s
    JOIN departments d ON s.department_id = d.department_id
    WHERE s.student_id = student_id_param;
    
    -- Print header
    SELECT CONCAT('TRANSCRIPT FOR: ', student_name) AS '';
    SELECT CONCAT('DEPARTMENT: ', dept_name) AS '';
    SELECT CONCAT('ENROLLMENT DATE: ', enroll_date) AS '';
    SELECT '' AS '';
    
    -- Print column headers
    SELECT 'COURSE CODE', 'COURSE NAME', 'CREDITS', 'GRADE', 'GRADE POINTS';
    
    -- Print course details
    SELECT 
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
            WHEN e.grade = 'B-' THEN 6.5
            WHEN e.grade = 'C+' THEN 6.0
            ELSE 5.0
        END AS grade_points
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.student_id = student_id_param
    ORDER BY c.course_code;
    
    -- Calculate GPA
    SELECT 
        SUM(c.credits) AS total_credits,
        SUM(c.credits * CASE 
            WHEN e.grade = 'A+' THEN 10.0
            WHEN e.grade = 'A' THEN 9.0
            WHEN e.grade = 'A-' THEN 8.5
            WHEN e.grade = 'B+' THEN 8.0
            WHEN e.grade = 'B' THEN 7.0
            WHEN e.grade = 'B-' THEN 6.5
            WHEN e.grade = 'C+' THEN 6.0
            ELSE 5.0
        END) AS total_points
    INTO
        total_credits,
        total_points
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.student_id = student_id_param;
    
    SET gpa = ROUND(total_points / total_credits, 2);
    
    -- Print summary
    SELECT '' AS '';
    SELECT 'SUMMARY' AS '';
    SELECT CONCAT('TOTAL CREDITS: ', total_credits) AS '';
    SELECT CONCAT('CUMULATIVE GPA: ', gpa) AS '';
    
END //
DELIMITER ;

-- Call the transcript procedure
CALL GenerateTranscript(1);



-- =====================================================================
-- 🎓 COMPREHENSIVE SQL TUTORIAL - CDAC DBDA COURSE
-- =====================================================================
-- Author: Database Instructor
-- Version: 1.0
-- Purpose: Learn SQL from basics to advanced concepts
-- =====================================================================

-- =========================
-- 📌 SECTION 1: DATABASE FUNDAMENTALS
-- =========================

-- 1.1 Creating a new database
-- A database is like a container for all your related tables and data
CREATE DATABASE IF NOT EXISTS cdac_tutorial;

-- 1.2 Select which database to use
-- This tells MySQL which database you'll be working with
USE cdac_tutorial;

-- 1.3 View all databases on the server
SHOW DATABASES;

-- 1.4 Delete a database (BE VERY CAREFUL!)
-- This will permanently delete the database and all its contents
-- DROP DATABASE database_name;  -- Commented out for safety

-- =========================
-- 📌 SECTION 2: TABLE CREATION (DDL - Data Definition Language)
-- =========================

-- 2.1 Create a simple table
-- Tables store data in rows and columns, like a spreadsheet
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary key - unique identifier
    first_name VARCHAR(50) NOT NULL,  -- NOT NULL means this field must have a value
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,  -- Stores date values
    email VARCHAR(100) UNIQUE,  -- UNIQUE means no two students can have the same email
    phone VARCHAR(15),
    gender ENUM('Male', 'Female', 'Other'),  -- ENUM restricts to specific values
    enrollment_date DATE DEFAULT (CURRENT_DATE),  -- DEFAULT gives a fallback value
    is_active BOOLEAN DEFAULT TRUE,  -- Boolean values (TRUE/FALSE)
    cgpa DECIMAL(3,2),  -- DECIMAL(3,2) means 3 digits total, 2 after decimal (e.g., 9.45)
    address TEXT,  -- TEXT can store longer strings
    profile_picture BLOB,  -- BLOB stores binary data like images
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically set to current time
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Auto-updates on changes
);

-- 2.2 Create a departments table
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,  -- Department names must be unique
    hod_name VARCHAR(100),  -- HOD = Head of Department
    office_location VARCHAR(50),
    contact_email VARCHAR(100),
    established_date DATE,
    budget DECIMAL(12,2) DEFAULT 0.00  -- Large decimal for money values
);

-- 2.3 Create a courses table (with foreign key relationship)
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT DEFAULT 3,
    department_id INT,  -- This will reference departments table
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    
    -- FOREIGN KEY links this table to another table
    -- If a department is deleted, set department_id to NULL here
    FOREIGN KEY (department_id) REFERENCES departments(department_id) 
        ON DELETE SET NULL
);

-- 2.4 Create an enrollments table (many-to-many relationship)
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade VARCHAR(2),
    
    -- If a student is deleted, delete their enrollments too
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
        
    -- If a course is deleted, delete related enrollments
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE,
        
    -- Prevent duplicate enrollments (student can't enroll in same course twice)
    UNIQUE KEY (student_id, course_id)
);

-- 2.5 View table structure
DESCRIBE students;
DESCRIBE departments;
DESCRIBE courses;
DESCRIBE enrollments;

-- 2.6 Show create statement for a table
SHOW CREATE TABLE students;

-- 2.7 Modify table structure - add a new column
ALTER TABLE students 
ADD COLUMN nationality VARCHAR(50) DEFAULT 'Indian';

-- 2.8 Modify table structure - modify existing column
ALTER TABLE students
MODIFY COLUMN phone VARCHAR(20);  -- Changed from VARCHAR(15) to VARCHAR(20)

-- 2.9 Modify table structure - rename column
ALTER TABLE students
CHANGE COLUMN nationality country VARCHAR(50) DEFAULT 'India';

-- 2.10 Modify table structure - drop column
ALTER TABLE students
DROP COLUMN profile_picture;  -- Removing the BLOB column

-- 2.11 Add a check constraint
ALTER TABLE students
ADD CONSTRAINT check_cgpa CHECK (cgpa >= 0 AND cgpa <= 10);

-- 2.12 Rename a table
-- RENAME TABLE old_table_name TO new_table_name;

-- 2.13 Drop a table (BE CAREFUL!)
-- DROP TABLE table_name;  -- Commented out for safety

-- =========================
-- 📌 SECTION 3: INSERTING DATA (DML - Data Manipulation Language)
-- =========================

-- 3.1 Insert a single row
INSERT INTO departments (department_name, hod_name, office_location, established_date, budget)
VALUES ('Computer Science', 'Dr. Rajesh Kumar', 'Block A, Room 101', '2010-06-15', 5000000.00);

-- 3.2 Insert multiple rows at once
INSERT INTO departments (department_name, hod_name, office_location, established_date, budget) VALUES 
('Data Science', 'Dr. Priya Singh', 'Block B, Room 201', '2015-07-20', 6000000.00),
('Information Technology', 'Dr. Amit Verma', 'Block A, Room 105', '2012-04-10', 4500000.00),
('Artificial Intelligence', 'Dr. Sneha Patel', 'Block C, Room 301', '2018-08-05', 7000000.00),
('Database Management', 'Dr. Vikram Singh', 'Block B, Room 205', '2014-03-15', 4000000.00);

-- 3.3 Insert data into the courses table
INSERT INTO courses (course_code, course_name, credits, department_id, description) VALUES
('CS101', 'Introduction to Programming', 4, 1, 'Fundamentals of programming using C and Python'),
('DS101', 'Fundamentals of Data Science', 4, 2, 'Introduction to data science concepts and tools'),
('IT101', 'Computer Networks', 3, 3, 'Principles of computer networking and protocols'),
('AI101', 'Introduction to Artificial Intelligence', 4, 4, 'Foundations of AI and intelligent systems'),
('DB101', 'Database Management Systems', 4, 5, 'Fundamentals of database design and SQL'),
('CS201', 'Data Structures', 4, 1, 'Study of fundamental data structures and algorithms'),
('DS201', 'Statistical Methods for Data Science', 3, 2, 'Statistical foundations for data analysis'),
('DB201', 'Advanced Database Concepts', 3, 5, 'Advanced topics in database management');

-- 3.4 Insert student data
INSERT INTO students (first_name, last_name, date_of_birth, email, phone, gender, cgpa, address) VALUES
('Rahul', 'Sharma', '2000-05-15', 'rahul.sharma@example.com', '9876543210', 'Male', 8.5, 'Mumbai, Maharashtra'),
('Priya', 'Patel', '2001-03-22', 'priya.patel@example.com', '9876543211', 'Female', 9.2, 'Pune, Maharashtra'),
('Amit', 'Kumar', '1999-11-10', 'amit.kumar@example.com', '9876543212', 'Male', 7.8, 'Delhi, Delhi'),
('Neha', 'Singh', '2000-07-05', 'neha.singh@example.com', '9876543213', 'Female', 8.9, 'Bangalore, Karnataka'),
('Vikram', 'Joshi', '1998-09-18', 'vikram.joshi@example.com', '9876543214', 'Male', 8.1, 'Chennai, Tamil Nadu');

-- 3.5 Insert enrollment data
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

-- 3.6 Insert with SELECT (insert data from another table or query)
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

-- Now insert from temp_students into students
INSERT INTO students (first_name, last_name, email, cgpa, gender)
SELECT 
    first_name, 
    last_name, 
    email, 
    cgpa,
    'Male' -- Default gender for all (just for demonstration)
FROM temp_students;

-- Clean up the temporary table
DROP TABLE temp_students;

-- =========================
-- 📌 SECTION 4: BASIC QUERIES (DQL - Data Query Language)
-- =========================

-- 4.1 SELECT all columns from a table
SELECT * FROM students;

-- 4.2 SELECT specific columns
SELECT first_name, last_name, email, cgpa FROM students;

-- 4.3 SELECT with aliasing (renaming columns in results)
SELECT 
    first_name AS "First Name", 
    last_name AS "Last Name",
    cgpa AS "CGPA Score"
FROM students;

-- 4.4 SELECT with simple WHERE conditions
SELECT * FROM students WHERE gender = 'Female';

-- 4.5 WHERE with comparison operators
SELECT * FROM students WHERE cgpa > 8.5;
SELECT * FROM students WHERE date_of_birth >= '2000-01-01';

-- 4.6 WHERE with multiple conditions (AND, OR)
SELECT * FROM students 
WHERE gender = 'Male' AND cgpa > 8.0;

SELECT * FROM students 
WHERE cgpa > 9.0 OR date_of_birth > '2000-01-01';

-- 4.7 WHERE with IN operator (matching multiple values)
SELECT * FROM students 
WHERE student_id IN (1, 3, 5);

-- 4.8 WHERE with BETWEEN operator (range of values)
SELECT * FROM students 
WHERE cgpa BETWEEN 8.0 AND 9.0;

-- 4.9 WHERE with LIKE operator (pattern matching)
-- % = wildcard for any number of characters
-- _ = wildcard for exactly one character
SELECT * FROM students 
WHERE first_name LIKE 'A%';  -- Names starting with 'A'

SELECT * FROM students 
WHERE email LIKE '%@example.com';  -- Emails ending with @example.com

SELECT * FROM students 
WHERE last_name LIKE 'S_____';  -- Last names starting with S and exactly 6 letters

-- 4.10 WHERE with NULL checks
SELECT * FROM students 
WHERE date_of_birth IS NULL;

SELECT * FROM students 
WHERE date_of_birth IS NOT NULL;

-- 4.11 ORDER BY (sorting results)
SELECT * FROM students 
ORDER BY cgpa DESC;  -- Descending order (highest to lowest)

SELECT * FROM students 
ORDER BY last_name ASC, first_name ASC;  -- Sort by last name, then first name

-- 4.12 LIMIT (restricting number of rows returned)
SELECT * FROM students 
ORDER BY cgpa DESC
LIMIT 3;  -- Top 3 students by CGPA

-- 4.13 LIMIT with OFFSET (pagination)
SELECT * FROM students 
ORDER BY student_id
LIMIT 2 OFFSET 2;  -- Skip first 2 students, show next 2

-- 4.14 DISTINCT (removing duplicates)
SELECT DISTINCT gender FROM students;

-- =========================
-- 📌 SECTION 5: AGGREGATE FUNCTIONS
-- =========================

-- 5.1 COUNT (counting rows)
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(date_of_birth) AS students_with_dob FROM students;  -- NULL values not counted

-- 5.2 COUNT with WHERE
SELECT COUNT(*) AS male_students FROM students WHERE gender = 'Male';

-- 5.3 SUM (adding numeric values)
SELECT SUM(credits) AS total_credits FROM courses;

-- 5.4 AVG (average of numeric values)
SELECT AVG(cgpa) AS average_cgpa FROM students;

-- 5.5 MIN and MAX (minimum and maximum values)
SELECT 
    MIN(cgpa) AS lowest_cgpa,
    MAX(cgpa) AS highest_cgpa
FROM students;

-- 5.6 GROUP BY (grouping rows for aggregation)
SELECT gender, COUNT(*) AS count
FROM students
GROUP BY gender;

SELECT 
    department_id, 
    COUNT(*) AS course_count,
    SUM(credits) AS total_credits
FROM courses
GROUP BY department_id;

-- 5.7 HAVING (filtering on aggregate results)
SELECT 
    department_id, 
    COUNT(*) AS course_count
FROM courses
GROUP BY department_id
HAVING COUNT(*) > 1;  -- Only departments with more than 1 course

-- 5.8 GROUP BY with ORDER BY
SELECT 
    department_id, 
    AVG(credits) AS avg_credits
FROM courses
GROUP BY department_id
ORDER BY avg_credits DESC;

-- =========================
-- 📌 SECTION 6: JOINS AND RELATIONSHIPS
-- =========================

-- 6.1 INNER JOIN (only matching rows in both tables)
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

-- 6.2 LEFT JOIN (all rows from left table, matching from right)
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

-- 6.3 RIGHT JOIN (all rows from right table, matching from left)
SELECT 
    c.course_id,
    c.course_name,
    e.student_id,
    s.first_name,
    s.last_name
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
LEFT JOIN students s ON e.student_id = s.student_id;

-- 6.4 FULL JOIN (all rows from both tables)
-- MySQL doesn't support FULL JOIN directly, but you can simulate it with UNION
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

-- 6.5 CROSS JOIN (cartesian product - every row from first table with every row from second)
-- Be careful! This can produce very large result sets
SELECT 
    s.first_name,
    c.course_name
FROM students s
CROSS JOIN courses c
LIMIT 10;  -- Limiting results for demonstration

-- 6.6 SELF JOIN (joining a table to itself)
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

-- 7.1 Subquery in WHERE clause
-- Find students with above-average CGPA
SELECT first_name, last_name, cgpa
FROM students
WHERE cgpa > (SELECT AVG(cgpa) FROM students);

-- 7.2 Subquery with IN operator
-- Find all courses taken by student with ID 1
SELECT course_code, course_name
FROM courses
WHERE course_id IN (
    SELECT course_id
    FROM enrollments
    WHERE student_id = 1
);

-- 7.3 Subquery in FROM clause (derived table)
SELECT avg_cgpa_by_gender.gender, avg_cgpa_by_gender.average_cgpa
FROM (
    SELECT gender, AVG(cgpa) AS average_cgpa
    FROM students
    GROUP BY gender
) AS avg_cgpa_by_gender
WHERE avg_cgpa_by_gender.average_cgpa > 8.0;

-- 7.4 Correlated subquery (inner query references outer query)
-- Find students who have at least one grade of 'A+'
SELECT s.student_id, s.first_name, s.last_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id AND e.grade = 'A+'
);

-- 7.5 Subquery in SELECT clause
SELECT 
    d.department_id,
    d.department_name,
    (SELECT COUNT(*) FROM courses c WHERE c.department_id = d.department_id) AS course_count
FROM departments d;

-- 7.6 Multiple level subqueries
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

-- 8.1 Basic CTE (temporary result set)
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

-- 8.2 Multiple CTEs
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

-- 8.3 Recursive CTE
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

-- 8.4 Using recursive CTE for hierarchical data (employees example)
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

-- 9.1 Basic UPDATE statement
UPDATE students
SET phone = '9999999999'
WHERE student_id = 1;

-- 9.2 UPDATE multiple columns
UPDATE students
SET 
    cgpa = 9.0,
    address = 'New Mumbai Address'
WHERE student_id = 1;

-- 9.3 UPDATE with calculations
UPDATE students
SET cgpa = cgpa + 0.5
WHERE cgpa < 8.0;

-- 9.4 UPDATE with JOIN
UPDATE courses c
JOIN departments d ON c.department_id = d.department_id
SET c.is_active = FALSE
WHERE d.department_name = 'Database Management' AND c.course_code = 'DB101';

-- 9.5 UPDATE with subquery
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

-- 10.1 Basic DELETE statement
-- First, add a test student
INSERT INTO students (first_name, last_name, email, cgpa)
VALUES ('Test', 'Student', 'test.student@example.com', 5.0);

-- Then delete the test student
DELETE FROM students
WHERE first_name = 'Test' AND last_name = 'Student';

-- 10.2 DELETE with JOIN
-- Insert test data
INSERT INTO courses (course_code, course_name, department_id)
VALUES ('TEST101', 'Test Course', 5);

-- Delete using JOIN
DELETE c
FROM courses c
JOIN departments d ON c.department_id = d.department_id
WHERE c.course_code = 'TEST101' AND d.department_name = 'Database Management';

-- 10.3 DELETE with subquery
-- Insert test data first
INSERT INTO enrollments (student_id, course_id, grade)
VALUES (1, 5, 'F');

-- Delete enrollments with 'F' grades
DELETE FROM enrollments
WHERE grade = 'F' AND student_id IN (
    SELECT student_id FROM students WHERE cgpa > 8.0
);

-- 10.4 TRUNCATE TABLE (delete all rows quickly)
-- CREATE TABLE temp_demo (id INT, name VARCHAR(50));
-- INSERT INTO temp_demo VALUES (1, 'Test'), (2, 'Test2');
-- TRUNCATE TABLE temp_demo;  -- Deletes all rows, faster than DELETE

-- =========================
-- 📌 SECTION 11: FUNCTIONS AND EXPRESSIONS
-- =========================

-- 11.1 String functions
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

-- 11.2 Numeric functions
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

-- 11.3 Date and time functions
SELECT 
    enrollment_date,
    DATE_ADD(enrollment_date, INTERVAL 6 MONTH) AS six_months_later,
    DATEDIFF(CURRENT_DATE, enrollment_date) AS days_enrolled,
    YEAR(enrollment_date) AS enrollment_year,
    MONTH(enrollment_date) AS enrollment_month,
    DAY(enrollment_date) AS enrollment_day,
    DAYNAME(enrollment_date) AS day_of_week
FROM enrollments;

-- 11.4 Conditional expressions (CASE)
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

-- 11.5 Conditional expressions in aggregate functions
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

-- 12.1 Create a simple view
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

-- 12.2 Query from a view
SELECT * FROM student_course_view
WHERE grade = 'A';

-- 12.3 Create a view with calculations
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

-- 12.4 Create an updatable view
CREATE OR REPLACE VIEW active_students AS
SELECT student_id, first_name, last_name, email, phone, cgpa
FROM students
WHERE is_active = TRUE
WITH CHECK OPTION;  -- Prevents updates that would make rows invisible to the view

-- 12.5 Update through a view
UPDATE active_students
SET phone = '8888888888'
WHERE student_id = 2;

-- 12.6 Drop a view
-- DROP VIEW student_course_view;

-- =========================
-- 📌 SECTION 13: STORED PROCEDURES
-- =========================

-- 13.1 Create a simple stored procedure
DELIMITER //
CREATE PROCEDURE GetAllStudents()
BEGIN
    SELECT * FROM students;
END //
DELIMITER ;

-- 13.2 Call a stored procedure
CALL GetAllStudents();

-- 13.3 Procedure with input parameters
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

-- 13.4 Call procedure with parameters
CALL GetStudentsByGrade('A');

-- 13.5 Procedure with output parameters
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

-- 13.6 Call procedure with output parameters
CALL GetDepartmentStats(1, @count, @avg);
SELECT @count AS course_count, @avg AS average_credits;

-- 13.7 Procedure with conditional logic
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

-- 13.8 Procedure with error handling
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
    
    -- Check if student exists
    SELECT COUNT(*) INTO student_exists
    FROM students
    WHERE student_id = student_id_param;
    
    -- Check if course exists
    SELECT COUNT(*) INTO course_exists
    FROM courses
    WHERE course_id = course_id_param;
    
    -- Check if already enrolled
    SELECT COUNT(*) INTO already_enrolled
    FROM enrollments
    WHERE student_id = student_id_param AND course_id = course_id_param;
    
    -- Validate inputs
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

-- 13.9 Procedure with loops
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

-- 14.1 Create a simple scalar function
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

-- 14.2 Use the function
SELECT CalculateGrade(92) AS grade;

-- 14.3 Function with table data
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

-- 14.4 Use the function in a query
SELECT 
    student_id,
    GetStudentFullName(student_id) AS full_name,
    cgpa
FROM students;

-- 14.5 Function to calculate age
DELIMITER //
CREATE FUNCTION CalculateAge(birth_date DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
END //
DELIMITER ;

-- 14.6 Use the age function
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

-- 15.1 Create an audit table
CREATE TABLE student_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    action_type VARCHAR(10) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSON,
    new_data JSON
);

-- 15.2 Create an AFTER INSERT trigger
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

-- 15.3 Create an AFTER UPDATE trigger
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

-- 15.4 Create an AFTER DELETE trigger
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

-- 15.5 Create a BEFORE INSERT trigger (data validation)
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

-- 15.6 Test triggers
-- Insert a new student to trigger after_student_insert
INSERT INTO students (first_name, last_name, email, cgpa)
VALUES ('Trigger', 'Test', 'trigger.test@example.com', 7.5);

-- Update a student to trigger after_student_update
UPDATE students
SET cgpa = 8.0
WHERE first_name = 'Trigger';

-- Delete the student to trigger after_student_delete
DELETE FROM students
WHERE first_name = 'Trigger';

-- Check the audit table
SELECT * FROM student_audit;

-- =========================
-- 📌 SECTION 16: TRANSACTIONS
-- =========================

-- 16.1 Simple transaction
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

-- 16.2 Transaction with error handling
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

-- 16.3 Call the transaction procedure
CALL TransferStudent(1, 1, 5);

-- =========================
-- 📌 SECTION 17: INDEXES
-- =========================

-- 17.1 View existing indexes
SHOW INDEX FROM students;

-- 17.2 Create a simple index
CREATE INDEX idx_student_email ON students(email);

-- 17.3 Create a composite index
CREATE INDEX idx_enrollment_student_course ON enrollments(student_id, course_id);

-- 17.4 Create a unique index
CREATE UNIQUE INDEX idx_course_code_unique ON courses(course_code);

-- 17.5 Create a fulltext index
ALTER TABLE courses ADD FULLTEXT INDEX idx_course_fulltext(course_name, description);

-- 17.6 Use a fulltext index
SELECT course_id, course_name, description
FROM courses
WHERE MATCH(course_name, description) AGAINST('database' IN NATURAL LANGUAGE MODE);

-- 17.7 Drop an index
-- DROP INDEX idx_student_email ON students;

-- =========================
-- 📌 SECTION 18: DATABASE ADMINISTRATION
-- =========================

-- 18.1 Create a user
-- CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'student_password';

-- 18.2 Grant privileges
-- GRANT SELECT ON cdac_tutorial.* TO 'student_user'@'localhost';
-- GRANT SELECT, INSERT, UPDATE ON cdac_tutorial.students TO 'student_user'@'localhost';

-- 18.3 Revoke privileges
-- REVOKE INSERT ON cdac_tutorial.students FROM 'student_user'@'localhost';

-- 18.4 Drop a user
-- DROP USER 'student_user'@'localhost';

-- 18.5 Check database status
SHOW TABLE STATUS FROM cdac_tutorial;

-- 18.6 Optimize tables
OPTIMIZE TABLE students, enrollments;

-- 18.7 View server variables
SHOW VARIABLES LIKE 'max_connections';

-- 18.8 View process list
SHOW PROCESSLIST;

-- =========================
-- 📌 SECTION 19: ADVANCED SQL FEATURES
-- =========================

-- 19.1 Window functions
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

-- 19.2 JSON data
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

-- 19.3 Pivot tables (using conditional aggregation)
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

-- 20.1 EXPLAIN to analyze query execution plan
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

-- 20.2 Using indexes effectively
CREATE INDEX idx_student_cgpa ON students(cgpa);

-- 20.3 Rewriting queries for better performance
-- Original query
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

-- Optimized query (if department_name is used frequently)
CREATE INDEX idx_department_name ON departments(department_name);

-- 20.4 Using appropriate JOINs
-- Use INNER JOIN when you only need matching rows
-- Use LEFT JOIN when you need all rows from the left table

-- 20.5 Limiting result sets
SELECT * FROM students LIMIT 10;

-- 20.6 Avoiding SELECT *
-- Instead of:
-- SELECT * FROM students;
-- Use:
SELECT student_id, first_name, last_name, email, cgpa FROM students;

-- =========================
-- 📌 SECTION 21: BEST PRACTICES
-- =========================

-- 21.1 Naming conventions
-- Use meaningful, consistent names
-- table_name (plural, lowercase with underscores)
-- column_name (singular, lowercase with underscores)

-- 21.2 Comments for documentation
-- Use comments to explain complex queries
-- Comments start with -- in SQL

-- 21.3 Security best practices
-- Use prepared statements to prevent SQL injection
-- Limit user privileges to only what's necessary

-- 21.4 Database backup
-- Regular database backups are essential
-- Command line: mysqldump -u username -p database_name > backup.sql

-- 21.5 Code organization
-- Group related tables and operations
-- Use schema diagrams to visualize relationships

-- 21.6 Version control
-- Keep track of database schema changes
-- Use migration scripts for deployment

-- =========================
-- 📌 SECTION 22: PRACTICAL EXERCISES
-- =========================

-- 22.1 Create a comprehensive student transcript
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
JOIN departments d ON s.department_id = d.department_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = 1  -- Change to the student you want
ORDER BY c.course_code;

-- 22.2 Department performance analysis
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

-- 22.3 Find students who need academic help (low grades)
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

-- ======== END OF SQL TUTORIAL ========



-- =====================================================================
-- 🎓 COMPREHENSIVE SQL TUTORIAL PART 2 - ADVANCED TOPICS
-- =====================================================================
-- Author: Database Instructor
-- Version: 1.0
-- Purpose: Advanced SQL concepts for CDAC DBDA Course
-- =====================================================================

-- ==================================================
-- 📌 SECTION 23: CROSS-DATABASE OPERATIONS
-- ==================================================

-- 23.1 Create a secondary database for demonstration
CREATE DATABASE IF NOT EXISTS cdac_analytics_db;

-- 23.2 Use the new database
USE cdac_analytics_db;

-- 23.3 Create a sample table in the new database
CREATE TABLE student_analytics (
    analytics_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    login_count INT DEFAULT 0,
    assignment_completion_rate DECIMAL(5,2),
    avg_session_time_minutes INT,
    last_active_date DATE,
    preferred_device ENUM('Desktop', 'Laptop', 'Tablet', 'Mobile')
);

-- 23.4 Insert some data
INSERT INTO student_analytics (student_id, login_count, assignment_completion_rate, avg_session_time_minutes, last_active_date, preferred_device) VALUES
(1, 45, 92.5, 65, CURDATE() - INTERVAL 1 DAY, 'Laptop'),
(2, 38, 88.0, 55, CURDATE() - INTERVAL 2 DAY, 'Desktop'),
(3, 27, 76.5, 40, CURDATE() - INTERVAL 5 DAY, 'Mobile'),
(4, 52, 95.0, 75, CURDATE(), 'Laptop'),
(5, 31, 84.0, 50, CURDATE() - INTERVAL 3 DAY, 'Tablet');

-- 23.5 Cross-database query (referencing tables from both databases)
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email,
    sa.login_count,
    sa.assignment_completion_rate,
    sa.avg_session_time_minutes,
    sa.preferred_device
FROM cdac_tutorial.students s
JOIN cdac_analytics_db.student_analytics sa ON s.student_id = sa.student_id
ORDER BY sa.login_count DESC;

-- 23.6 Create a view that spans databases
CREATE OR REPLACE VIEW cross_db_student_performance AS
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.cgpa,
    d.department_name,
    sa.assignment_completion_rate,
    sa.login_count,
    COUNT(e.course_id) AS enrolled_courses,
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
FROM cdac_tutorial.students s
JOIN cdac_tutorial.departments d ON s.department_id = d.department_id
LEFT JOIN cdac_tutorial.enrollments e ON s.student_id = e.student_id
LEFT JOIN cdac_analytics_db.student_analytics sa ON s.student_id = sa.student_id
GROUP BY s.student_id, student_name, s.cgpa, d.department_name, sa.assignment_completion_rate, sa.login_count;

-- 23.7 Query the cross-database view
SELECT * FROM cross_db_student_performance
ORDER BY enrolled_courses DESC, avg_grade_points DESC;

-- 23.8 Create a stored procedure that works across databases
DELIMITER //
CREATE PROCEDURE GenerateStudentAnalyticsReport(IN student_id_param INT)
BEGIN
    -- Get student details from main database
    SELECT 
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        s.email,
        s.phone,
        s.cgpa,
        d.department_name
    FROM cdac_tutorial.students s
    JOIN cdac_tutorial.departments d ON s.department_id = d.department_id
    WHERE s.student_id = student_id_param;
    
    -- Get course enrollments from main database
    SELECT 
        c.course_code,
        c.course_name,
        e.grade,
        CASE 
            WHEN e.grade = 'A+' THEN 10.0
            WHEN e.grade = 'A' THEN 9.0
            WHEN e.grade = 'A-' THEN 8.5
            WHEN e.grade = 'B+' THEN 8.0
            WHEN e.grade = 'B' THEN 7.0
            WHEN e.grade = 'B-' THEN 6.5
            WHEN e.grade = 'C+' THEN 6.0
            ELSE 5.0
        END AS grade_points
    FROM cdac_tutorial.enrollments e
    JOIN cdac_tutorial.courses c ON e.course_id = c.course_id
    WHERE e.student_id = student_id_param;
    
    -- Get analytics data from analytics database
    SELECT 
        login_count,
        assignment_completion_rate,
        avg_session_time_minutes,
        last_active_date,
        preferred_device
    FROM cdac_analytics_db.student_analytics
    WHERE student_id = student_id_param;
END //
DELIMITER ;

-- 23.9 Call the cross-database procedure
CALL GenerateStudentAnalyticsReport(1);

-- 23.10 Foreign keys across databases (requires InnoDB)
CREATE TABLE student_extended_profile (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL UNIQUE,
    linkedin_profile VARCHAR(255),
    github_profile VARCHAR(255),
    skills JSON,
    certifications JSON,
    CONSTRAINT fk_student_id_cross_db
    FOREIGN KEY (student_id) REFERENCES cdac_tutorial.students(student_id)
);

-- ==================================================
-- 📌 SECTION 24: PARTITIONING
-- ==================================================

-- 24.1 Create a table with RANGE partitioning
-- First switch back to the tutorial database
USE cdac_tutorial;

-- Create a table to log student activities
CREATE TABLE student_activity_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    activity_type ENUM('Login', 'Assignment_Submit', 'Quiz_Attempt', 'Forum_Post', 'Resource_View'),
    activity_date DATE NOT NULL,
    activity_time TIME NOT NULL,
    ip_address VARCHAR(45),
    device_info VARCHAR(255),
    details JSON,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
) 
PARTITION BY RANGE (YEAR(activity_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- 24.2 Insert sample activity logs
INSERT INTO student_activity_logs (student_id, activity_type, activity_date, activity_time, ip_address, device_info, details) VALUES
(1, 'Login', '2023-01-10', '09:15:00', '192.168.1.101', 'Windows 10, Chrome', '{"session_id": "abc123", "success": true}'),
(2, 'Assignment_Submit', '2023-01-11', '14:30:00', '192.168.1.102', 'macOS, Safari', '{"assignment_id": 3, "on_time": true}'),
(3, 'Quiz_Attempt', '2023-01-12', '10:45:00', '192.168.1.103', 'Ubuntu, Firefox', '{"quiz_id": 5, "score": 85}'),
(4, 'Forum_Post', '2023-01-13', '16:20:00', '192.168.1.104', 'Windows 11, Edge', '{"topic_id": 12, "post_id": 45}'),
(5, 'Resource_View', '2023-01-14', '11:30:00', '192.168.1.105', 'Android, Chrome Mobile', '{"resource_id": 28, "time_spent_mins": 15}'),
(1, 'Assignment_Submit', '2022-12-15', '13:45:00', '192.168.1.101', 'Windows 10, Chrome', '{"assignment_id": 2, "on_time": true}'),
(2, 'Quiz_Attempt', '2022-12-18', '09:30:00', '192.168.1.102', 'macOS, Safari', '{"quiz_id": 4, "score": 92}'),
(3, 'Login', '2022-12-20', '08:15:00', '192.168.1.103', 'Ubuntu, Firefox', '{"session_id": "def456", "success": true}');

-- 24.3 Query a specific partition
-- This will only search in the 2022 partition, making it more efficient
EXPLAIN SELECT * FROM student_activity_logs PARTITION (p2022)
WHERE activity_type = 'Login';

-- 24.4 Create a table with LIST partitioning
CREATE TABLE course_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    review_date DATE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    department_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
)
PARTITION BY LIST (department_id) (
    PARTITION p_comp_sci VALUES IN (1),
    PARTITION p_data_sci VALUES IN (2),
    PARTITION p_info_tech VALUES IN (3),
    PARTITION p_ai VALUES IN (4),
    PARTITION p_database VALUES IN (5)
);

-- 24.5 Insert sample course reviews
INSERT INTO course_reviews (course_id, student_id, review_date, rating, review_text, department_id) VALUES
(1, 2, '2023-02-15', 5, 'Excellent course, very informative and well-structured', 1),
(4, 1, '2023-02-16', 4, 'Good introduction to AI concepts', 4),
(5, 3, '2023-02-17', 5, 'Great database course, learned a lot about SQL', 5),
(2, 4, '2023-02-18', 3, 'Decent content but could use more practical examples', 2),
(6, 5, '2023-02-19', 4, 'Good coverage of data structures', 1);

-- 24.6 Create a table with HASH partitioning
CREATE TABLE payment_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    transaction_date DATETIME NOT NULL,
    payment_method VARCHAR(50),
    status ENUM('Completed', 'Pending', 'Failed', 'Refunded'),
    reference_number VARCHAR(100),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
)
PARTITION BY HASH (student_id)
PARTITIONS 4;

-- 24.7 Insert sample payment transactions
INSERT INTO payment_transactions (student_id, amount, transaction_date, payment_method, status, reference_number) VALUES
(1, 5000.00, '2023-01-05 10:30:00', 'Credit Card', 'Completed', 'TRX-001-2023'),
(2, 5000.00, '2023-01-06 11:45:00', 'Net Banking', 'Completed', 'TRX-002-2023'),
(3, 5000.00, '2023-01-07 09:15:00', 'UPI', 'Completed', 'TRX-003-2023'),
(4, 5000.00, '2023-01-08 14:20:00', 'Debit Card', 'Completed', 'TRX-004-2023'),
(5, 5000.00, '2023-01-09 12:10:00', 'Credit Card', 'Completed', 'TRX-005-2023'),
(1, 2000.00, '2023-02-10 10:30:00', 'UPI', 'Completed', 'TRX-006-2023'),
(2, 1500.00, '2023-02-11 11:45:00', 'Credit Card', 'Completed', 'TRX-007-2023'),
(3, 1800.00, '2023-02-12 09:15:00', 'Net Banking', 'Failed', 'TRX-008-2023'),
(3, 1800.00, '2023-02-13 10:20:00', 'Net Banking', 'Completed', 'TRX-009-2023');

-- 24.8 REORGANIZE partition (add a new partition)
ALTER TABLE student_activity_logs REORGANIZE PARTITION p_future INTO (
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- 24.9 Drop a partition (only if you don't need the data anymore)
-- ALTER TABLE student_activity_logs DROP PARTITION p2020;

-- ==================================================
-- 📌 SECTION 25: ADVANCED DATABASE SECURITY
-- ==================================================

-- 25.1 Create users with different privilege levels
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'faculty_user'@'localhost' IDENTIFIED BY 'faculty123';
CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'student123';

-- 25.2 Grant specific privileges
-- Admin user gets all privileges
GRANT ALL PRIVILEGES ON cdac_tutorial.* TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON cdac_analytics_db.* TO 'admin_user'@'localhost';

-- Faculty user gets read on all tables, write on specific tables
GRANT SELECT ON cdac_tutorial.* TO 'faculty_user'@'localhost';
GRANT INSERT, UPDATE ON cdac_tutorial.assignments TO 'faculty_user'@'localhost';
GRANT INSERT, UPDATE ON cdac_tutorial.submissions TO 'faculty_user'@'localhost';
GRANT INSERT, UPDATE ON cdac_tutorial.attendance TO 'faculty_user'@'localhost';

-- Student user gets very limited access
GRANT SELECT ON cdac_tutorial.student_course_view TO 'student_user'@'localhost';
GRANT SELECT ON cdac_tutorial.student_performance_view TO 'student_user'@'localhost';
GRANT SELECT, INSERT ON cdac_tutorial.submissions TO 'student_user'@'localhost';

-- 25.3 Row-level security using views
CREATE OR REPLACE VIEW student_personal_data AS
SELECT student_id, first_name, last_name, email, phone, date_of_birth, address
FROM students
WHERE student_id = (SELECT SUBSTRING_INDEX(CURRENT_USER(), '@', 1));

-- 25.4 Creating a stored procedure with DEFINER and INVOKER security context
DELIMITER //
CREATE DEFINER = 'admin_user'@'localhost' 
PROCEDURE UpdateStudentPhone(
    IN student_id_param INT,
    IN new_phone VARCHAR(20)
)
SQL SECURITY DEFINER
BEGIN
    -- Admin can update any student's phone
    UPDATE students
    SET phone = new_phone
    WHERE student_id = student_id_param;
    
    SELECT 'Phone updated successfully' AS message;
END //
DELIMITER ;

DELIMITER //
CREATE DEFINER = 'admin_user'@'localhost' 
PROCEDURE UpdateMyPhone(
    IN new_phone VARCHAR(20)
)
SQL SECURITY INVOKER
BEGIN
    -- Users can only update their own phone
    DECLARE current_user_id INT;
    
    -- Extract user ID from username (assuming username = student_id)
    SET current_user_id = CAST(SUBSTRING_INDEX(CURRENT_USER(), '@', 1) AS UNSIGNED);
    
    UPDATE students
    SET phone = new_phone
    WHERE student_id = current_user_id;
    
    SELECT 'Phone updated successfully' AS message;
END //
DELIMITER ;

-- 25.5 Column-level encryption
-- First, create a table to store sensitive data with encryption
CREATE TABLE student_financial_aid (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    aid_type VARCHAR(100),
    amount DECIMAL(10,2),
    bank_account_number VARBINARY(255),  -- Encrypted field
    routing_number VARBINARY(255),       -- Encrypted field
    tax_id_number VARBINARY(255),        -- Encrypted field
    application_date DATE,
    status ENUM('Applied', 'Approved', 'Rejected', 'Disbursed'),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 25.6 Create functions to encrypt and decrypt data
DELIMITER //
CREATE FUNCTION EncryptData(p_plaintext VARCHAR(255)) 
RETURNS VARBINARY(255)
DETERMINISTIC
NO SQL
BEGIN
    -- This is a simple example - in production, use proper encryption methods
    -- MySQL provides AES_ENCRYPT for this purpose
    RETURN AES_ENCRYPT(p_plaintext, 'secret_key_should_be_properly_managed');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION DecryptData(p_ciphertext VARBINARY(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
BEGIN
    -- Corresponding decryption function
    RETURN AES_DECRYPT(p_ciphertext, 'secret_key_should_be_properly_managed');
END //
DELIMITER ;

-- 25.7 Insert encrypted data
INSERT INTO student_financial_aid (
    student_id, 
    aid_type, 
    amount, 
    bank_account_number, 
    routing_number, 
    tax_id_number, 
    application_date, 
    status
) VALUES (
    1, 
    'Merit Scholarship', 
    25000.00, 
    EncryptData('1234567890'), 
    EncryptData('987654321'), 
    EncryptData('123-45-6789'), 
    '2023-01-15', 
    'Approved'
);

-- 25.8 Query with decryption for authorized users
-- Only privileged users would have access to this query
SELECT 
    record_id,
    student_id,
    aid_type,
    amount,
    DecryptData(bank_account_number) AS bank_account_number,
    DecryptData(routing_number) AS routing_number,
    DecryptData(tax_id_number) AS tax_id_number,
    application_date,
    status
FROM student_financial_aid;

-- 25.9 Create view that masks sensitive data for regular users
CREATE OR REPLACE VIEW masked_financial_aid_view AS
SELECT 
    record_id,
    student_id,
    aid_type,
    amount,
    CONCAT('XXXX-XXXX-XXXX-', RIGHT(CAST(DecryptData(bank_account_number) AS CHAR), 4)) AS masked_account,
    '***-**-****' AS masked_tax_id,
    application_date,
    status
FROM student_financial_aid;

-- 25.10 Revoke privileges when no longer needed
-- REVOKE INSERT, UPDATE ON cdac_tutorial.submissions FROM 'student_user'@'localhost';

-- ==================================================
-- 📌 SECTION 26: ADVANCED ANALYTICAL QUERIES
-- ==================================================

-- 26.1 Analyzing student performance trends with window functions
WITH StudentGradeHistory AS (
    SELECT 
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        c.course_id,
        c.course_name,
        e.grade,
        CASE 
            WHEN e.grade = 'A+' THEN 10.0
            WHEN e.grade = 'A' THEN 9.0
            WHEN e.grade = 'A-' THEN 8.5
            WHEN e.grade = 'B+' THEN 8.0
            WHEN e.grade = 'B' THEN 7.0
            WHEN e.grade = 'B-' THEN 6.5
            WHEN e.grade = 'C+' THEN 6.0
            ELSE 5.0
        END AS grade_points,
        c.credits,
        c.department_id,
        d.department_name,
        ROW_NUMBER() OVER (PARTITION BY s.student_id ORDER BY e.enrollment_date) AS course_sequence
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
    JOIN departments d ON c.department_id = d.department_id
)
SELECT 
    student_id,
    student_name,
    course_name,
    grade,
    grade_points,
    course_sequence,
    AVG(grade_points) OVER (PARTITION BY student_id ORDER BY course_sequence 
                           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_gpa,
    AVG(grade_points) OVER (PARTITION BY student_id, department_id) AS dept_avg_grade,
    AVG(grade_points) OVER (PARTITION BY student_id) - 
        AVG(grade_points) OVER (PARTITION BY student_id, department_id) AS dept_performance_diff
FROM StudentGradeHistory
ORDER BY student_id, course_sequence;

-- 26.2 Correlation analysis between attendance and grades
WITH AttendanceStats AS (
    SELECT 
        a.student_id,
        a.course_id,
        COUNT(*) AS total_sessions,
        SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS sessions_attended,
        ROUND((SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS attendance_percentage
    FROM attendance a
    GROUP BY a.student_id, a.course_id
)
SELECT 
    ast.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    ast.attendance_percentage,
    e.grade,
    CASE 
        WHEN e.grade = 'A+' THEN 10.0
        WHEN e.grade = 'A' THEN 9.0
        WHEN e.grade = 'A-' THEN 8.5
        WHEN e.grade = 'B+' THEN 8.0
        WHEN e.grade = 'B' THEN 7.0
        WHEN e.grade = 'B-' THEN 6.5
        WHEN e.grade = 'C+' THEN 6.0
        ELSE 5.0
    END AS grade_points,
    CASE 
        WHEN ast.attendance_percentage >= 90 AND CASE 
                                                   WHEN e.grade = 'A+' THEN 10.0
                                                   WHEN e.grade = 'A' THEN 9.0
                                                   WHEN e.grade = 'A-' THEN 8.5
                                                   WHEN e.grade = 'B+' THEN 8.0
                                                   WHEN e.grade = 'B' THEN 7.0
                                                   WHEN e.grade = 'B-' THEN 6.5
                                                   WHEN e.grade = 'C+' THEN 6.0
                                                   ELSE 5.0
                                                END >= 8.5 THEN 'High Attendance, High Grade'
        WHEN ast.attendance_percentage >= 90 AND CASE 
                                                   WHEN e.grade = 'A+' THEN 10.0
                                                   WHEN e.grade = 'A' THEN 9.0
                                                   WHEN e.grade = 'A-' THEN 8.5
                                                   WHEN e.grade = 'B+' THEN 8.0
                                                   WHEN e.grade = 'B' THEN 7.0
                                                   WHEN e.grade = 'B-' THEN 6.5
                                                   WHEN e.grade = 'C+' THEN 6.0
                                                   ELSE 5.0
                                                END < 8.5 THEN 'High Attendance, Average Grade'
        WHEN ast.attendance_percentage < 90 AND ast.attendance_percentage >= 75 THEN 'Average Attendance'
        ELSE 'Low Attendance'
    END AS attendance_grade_correlation
FROM AttendanceStats ast
JOIN students s ON ast.student_id = s.student_id
JOIN courses c ON ast.course_id = c.course_id
JOIN enrollments e ON ast.student_id = e.student_id AND ast.course_id = e.course_id
ORDER BY ast.attendance_percentage DESC, grade_points DESC;

-- 26.3 Cohort analysis (students who enrolled in the same period)
WITH StudentCohorts AS (
    SELECT 
        student_id,
        CONCAT(
            CASE 
                WHEN MONTH(enrollment_date) BETWEEN 1 AND 6 THEN 'Spring'
                ELSE 'Fall'
            END,
            ' ',
            YEAR(enrollment_date)
        ) AS cohort
    FROM students
)
SELECT 
    sc.cohort,
    COUNT(DISTINCT sc.student_id) AS cohort_size,
    AVG(s.cgpa) AS avg_cgpa,
    COUNT(DISTINCT e.course_id) AS total_courses_taken,
    COUNT(DISTINCT e.course_id) / COUNT(DISTINCT sc.student_id) AS avg_courses_per_student,
    SUM(CASE WHEN e.grade IN ('A+', 'A', 'A-') THEN 1 ELSE 0 END) AS a_grades_count,
    ROUND(SUM(CASE WHEN e.grade IN ('A+', 'A', 'A-') THEN 1 ELSE 0 END) * 100.0 / COUNT(e.grade), 2) AS a_grades_percentage
FROM StudentCohorts sc
JOIN students s ON sc.student_id = s.student_id
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY sc.cohort
ORDER BY sc.cohort;

-- 26.4 Predictive analysis - finding correlations between student attributes and performance
WITH StudentFeatures AS (
    SELECT 
        s.student_id,
        s.cgpa,
        d.department_id,
        TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) AS age,
        CASE WHEN s.city = 'Mumbai' THEN 1 ELSE 0 END AS is_from_mumbai,
        CASE WHEN sa.login_count > 40 THEN 'High' 
             WHEN sa.login_count > 20 THEN 'Medium'
             ELSE 'Low' END AS engagement_level,
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
    JOIN departments d ON s.department_id = d.department_id
    LEFT JOIN cdac_analytics_db.student_analytics sa ON s.student_id = sa.student_id
    LEFT JOIN enrollments e ON s.student_id = e.student_id
    GROUP BY s.student_id, s.cgpa, d.department_id, age, is_from_mumbai, engagement_level
)
SELECT 
    department_id,
    engagement_level,
    ROUND(AVG(age), 1) AS avg_age,
    SUM(is_from_mumbai) AS mumbai_students_count,
    COUNT(*) AS total_students,
    ROUND(SUM(is_from_mumbai) * 100.0 / COUNT(*), 2) AS mumbai_students_percentage,
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
GROUP BY department_id, engagement_level
ORDER BY department_id, avg_cgpa DESC;

-- 26.5 Advanced grouping with ROLLUP
SELECT 
    COALESCE(d.department_name, 'All Departments') AS department,
    COALESCE(c.course_name, 'All Courses') AS course,
    COUNT(DISTINCT e.student_id) AS student_count,
    AVG(s.cgpa) AS avg_student_cgpa,
    SUM(CASE WHEN e.grade = 'A+' THEN 1 ELSE 0 END) AS a_plus_count,
    SUM(CASE WHEN e.grade = 'A' THEN 1 ELSE 0 END) AS a_count,
    SUM(CASE WHEN e.grade = 'A-' THEN 1 ELSE 0 END) AS a_minus_count,
    SUM(CASE WHEN e.grade IN ('A+', 'A', 'A-') THEN 1 ELSE 0 END) / COUNT(e.grade) * 100 AS a_grade_percentage
FROM departments d
JOIN courses c ON d.department_id = c.department_id
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
GROUP BY d.department_name, c.course_name WITH ROLLUP
ORDER BY GROUPING(d.department_name), d.department_name, GROUPING(c.course_name), c.course_name;

-- 26.6 Time-based analysis with TIMESTAMPDIFF and date manipulation
WITH StudentSubmissionAnalysis AS (
    SELECT 
        s.student_id,
        sub.assignment_id,
        a.due_date,
        sub.submission_date,
        TIMESTAMPDIFF(HOUR, sub.submission_date, a.due_date) AS hours_before_deadline,
        sub.score,
        CASE 
            WHEN sub.submission_date > a.due_date THEN 'Late'
            WHEN TIMESTAMPDIFF(HOUR, sub.submission_date, a.due_date) <= 24 THEN 'Last Minute'
            WHEN TIMESTAMPDIFF(HOUR, sub.submission_date, a.due_date) <= 72 THEN 'Near Deadline'
            ELSE 'Well Before Deadline'
        END AS submission_timing
    FROM students s
    JOIN submissions sub ON s.student_id = sub.student_id
    JOIN assignments a ON sub.assignment_id = a.assignment_id
)
SELECT 
    submission_timing,
    COUNT(*) AS submission_count,
    ROUND(AVG(score), 2) AS avg_score,
    MIN(score) AS min_score,
    MAX(score) AS max_score,
    STDDEV(score) AS score_stddev,
    ROUND(AVG(CASE WHEN hours_before_deadline < 0 THEN ABS(hours_before_deadline) ELSE NULL END), 1) AS avg_hours_late,
    ROUND(AVG(CASE WHEN hours_before_deadline >= 0 THEN hours_before_deadline ELSE NULL END), 1) AS avg_hours_early
FROM StudentSubmissionAnalysis
GROUP BY submission_timing
ORDER BY FIELD(submission_timing, 'Late', 'Last Minute', 'Near Deadline', 'Well Before Deadline');

-- ==================================================
-- 📌 SECTION 27: DATABASE OPTIMIZATION
-- ==================================================

-- 27.1 Create a stored procedure to analyze and optimize tables
DELIMITER //
CREATE PROCEDURE OptimizeTables()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE table_name VARCHAR(255);
    
    -- Cursor to get all tables in the current database
    DECLARE tables_cursor CURSOR FOR 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = DATABASE();
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Create a temporary table to store optimization results
    CREATE TEMPORARY TABLE IF NOT EXISTS optimization_results (
        table_name VARCHAR(255),
        optimization_status VARCHAR(255),
        rows_count INT,
        data_size VARCHAR(50),
        index_size VARCHAR(50)
    );
    
    OPEN tables_cursor;
    
    table_loop: LOOP
        FETCH tables_cursor INTO table_name;
        IF done THEN
            LEAVE table_loop;
        END IF;
        
        -- Analyze table to update statistics
        SET @analyze_sql = CONCAT('ANALYZE TABLE ', table_name);
        PREPARE analyze_stmt FROM @analyze_sql;
        EXECUTE analyze_stmt;
        DEALLOCATE PREPARE analyze_stmt;
        
        -- Optimize table
        SET @optimize_sql = CONCAT('OPTIMIZE TABLE ', table_name);
        PREPARE optimize_stmt FROM @optimize_sql;
        EXECUTE optimize_stmt;
        DEALLOCATE PREPARE optimize_stmt;
        
        -- Get table statistics
        INSERT INTO optimization_results
        SELECT 
            t.TABLE_NAME,
            'Optimized',
            t.TABLE_ROWS,
            CONCAT(ROUND(t.DATA_LENGTH / (1024 * 1024), 2), ' MB'),
            CONCAT(ROUND(t.INDEX_LENGTH / (1024 * 1024), 2), ' MB')
        FROM information_schema.TABLES t
        WHERE t.TABLE_SCHEMA = DATABASE()
        AND t.TABLE_NAME = table_name;
    END LOOP;
    
    CLOSE tables_cursor;
    
    -- Display results
    SELECT * FROM optimization_results;
    
    -- Clean up
    DROP TEMPORARY TABLE IF EXISTS optimization_results;
END //
DELIMITER ;

-- 27.2 Create a procedure to identify unused indexes
DELIMITER //
CREATE PROCEDURE FindUnusedIndexes()
BEGIN
    SELECT 
        t.TABLE_NAME,
        s.INDEX_NAME,
        s.COLUMN_NAME,
        t.TABLE_ROWS,
        CASE WHEN i.INDEX_NAME IS NULL THEN 'Potentially Unused' ELSE 'Used' END AS usage_status
    FROM information_schema.STATISTICS s
    JOIN information_schema.TABLES t ON s.TABLE_SCHEMA = t.TABLE_SCHEMA AND s.TABLE_NAME = t.TABLE_NAME
    LEFT JOIN (
        -- This would usually be data from performance_schema.table_io_waits_summary_by_index_usage
        -- But we're simulating it with a query that assumes certain indexes are used
        SELECT 'students' AS TABLE_NAME, 'PRIMARY' AS INDEX_NAME UNION ALL
        SELECT 'courses', 'PRIMARY' UNION ALL
        SELECT 'enrollments', 'PRIMARY' UNION ALL
        SELECT 'students', 'idx_student_name'
    ) i ON s.TABLE_NAME = i.TABLE_NAME AND s.INDEX_NAME = i.INDEX_NAME
    WHERE s.TABLE_SCHEMA = DATABASE()
    AND s.INDEX_NAME != 'PRIMARY'  -- Exclude primary keys as they're always needed
    ORDER BY usage_status, t.TABLE_NAME, s.INDEX_NAME;
END //
DELIMITER ;

-- 27.3 Create a procedure to find tables without primary keys
DELIMITER //
CREATE PROCEDURE FindTablesWithoutPK()
BEGIN
    SELECT 
        t.TABLE_NAME,
        t.TABLE_ROWS,
        CONCAT(ROUND(t.DATA_LENGTH / (1024 * 1024), 2), ' MB') AS data_size
    FROM information_schema.TABLES t
    LEFT JOIN information_schema.TABLE_CONSTRAINTS tc ON 
        t.TABLE_SCHEMA = tc.TABLE_SCHEMA AND 
        t.TABLE_NAME = tc.TABLE_NAME AND 
        tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
    WHERE t.TABLE_SCHEMA = DATABASE()
    AND tc.CONSTRAINT_NAME IS NULL
    AND t.TABLE_TYPE = 'BASE TABLE';
END //
DELIMITER ;

-- 27.4 Create a procedure to identify inefficient queries (would require monitoring in a real system)
DELIMITER //
CREATE PROCEDURE SimulateQueryPerformanceAnalysis()
BEGIN
    -- Create a temporary table to simulate query performance data
    CREATE TEMPORARY TABLE query_performance (
        query_id INT AUTO_INCREMENT PRIMARY KEY,
        query_text TEXT,
        execution_count INT,
        avg_execution_time_ms DECIMAL(10,2),
        uses_indexes VARCHAR(3),
        suggested_optimization TEXT
    );
    
    -- Insert sample data
    INSERT INTO query_performance (query_text, execution_count, avg_execution_time_ms, uses_indexes, suggested_optimization) VALUES
    ('SELECT * FROM students WHERE email = "example@email.com"', 150, 12.5, 'Yes', 'Already optimized with email index'),
    ('SELECT * FROM students WHERE first_name LIKE "%a%"', 75, 350.2, 'No', 'Add FULLTEXT index on first_name or avoid LIKE with leading wildcard'),
    ('SELECT * FROM enrollments e JOIN courses c ON e.course_id = c.course_id WHERE c.department_id = 1', 120, 45.3, 'No', 'Add index on courses(department_id)'),
    ('SELECT * FROM students WHERE cgpa > 8.5', 200, 28.7, 'Yes', 'Already optimized with cgpa index'),
    ('SELECT * FROM students s JOIN enrollments e ON s.student_id = e.student_id JOIN courses c ON e.course_id = c.course_id', 50, 120.5, 'Yes', 'Consider adding a covering index or limiting the result set');
    
    -- Return the results
    SELECT * FROM query_performance ORDER BY avg_execution_time_ms DESC;
    
    -- Clean up
    DROP TEMPORARY TABLE IF EXISTS query_performance;
END //
DELIMITER ;

-- 27.5 Create index hints for better query optimization
EXPLAIN
SELECT /*+ INDEX(s idx_student_name) */
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.last_name LIKE 'S%';

-- ==================================================
-- 📌 SECTION 28: DATABASE BACKUP AND RECOVERY
-- ==================================================

-- 28.1 Creating a procedure to document backup strategy
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
        description TEXT,
        last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    -- Clear existing documentation
    TRUNCATE backup_documentation;
    
    -- Insert backup strategies
    INSERT INTO backup_documentation (backup_type, frequency, retention_period, command_example, description) VALUES
    ('Full Database Backup', 'Daily (at midnight)', '30 days', 
     'mysqldump -u admin -p --all-databases > full_backup_$(date +%Y%m%d).sql', 
     'Complete backup of all databases, tables, and data. Used for complete recovery scenarios.'),
     
    ('Incremental Backup', 'Every 6 hours', '7 days', 
     'mysqldump -u admin -p --all-databases --single-transaction --flush-logs --master-data=2 --delete-master-logs > incremental_backup_$(date +%Y%m%d_%H%M%S).sql', 
     'Captures changes since the last backup. Requires binary logging to be enabled.'),
     
    ('Differential Backup', 'Every 12 hours', '14 days', 
     'mysqldump -u admin -p --all-databases --where="last_updated >= CURDATE()" > differential_backup_$(date +%Y%m%d_%H%M%S).sql', 
     'Captures all changes since the last full backup. More efficient for restoration compared to multiple incremental backups.'),
     
    ('Table-Level Backup', 'Weekly', '90 days', 
     'mysqldump -u admin -p cdac_tutorial students enrollments > important_tables_backup_$(date +%Y%m%d).sql', 
     'Backup of specific critical tables. Useful for targeted recovery.'),
     
    ('Logical Backup', 'Daily', '30 days', 
     'mysqldump -u admin -p cdac_tutorial > cdac_tutorial_$(date +%Y%m%d).sql', 
     'SQL statement-based backup that can be used to recreate the database structure and data.'),
     
    ('Physical Backup', 'Weekly', '60 days', 
     'mysqlbackup --user=admin --password=***** --backup-dir=/backup backup', 
     'Direct copy of the database files. Faster for large databases but requires MySQL Enterprise Backup.'),
     
    ('Cold Backup', 'Monthly', '1 year', 
     'service mysql stop && cp -R /var/lib/mysql /backup/mysql_$(date +%Y%m%d) && service mysql start', 
     'Taken while the database is shut down. Guarantees a consistent state but requires downtime.'),
     
    ('Hot Backup', 'Daily', '30 days', 
     'mysqlbackup --user=admin --password=***** --backup-dir=/backup --no-locking backup', 
     'Taken while the database is running. Minimal impact on performance but may require additional consistency checks.');
    
    -- Display the documentation
    SELECT * FROM backup_documentation;
END //
DELIMITER ;

-- 28.2 Creating a recovery test procedure
DELIMITER //
CREATE PROCEDURE TestRecoveryProcedure()
BEGIN
    -- Create a table to document recovery testing
    CREATE TABLE IF NOT EXISTS recovery_test_log (
        test_id INT AUTO_INCREMENT PRIMARY KEY,
        test_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        test_scenario VARCHAR(100),
        steps_performed TEXT,
        recovery_time_minutes INT,
        success BOOLEAN,
        notes TEXT
    );
    
    -- Insert a sample recovery test
    INSERT INTO recovery_test_log (test_scenario, steps_performed, recovery_time_minutes, success, notes) VALUES
    ('Full Database Recovery', 
     '1. Simulated database corruption by deleting key tables\n2. Restored from last night\'s full backup\n3. Applied transaction logs to reach point-in-time recovery\n4. Verified data integrity with validation queries', 
     45, 
     TRUE, 
     'Recovery was successful. All data restored and verified. No data loss detected.');
     
    -- Return the test log
    SELECT * FROM recovery_test_log ORDER BY test_date DESC;
END //
DELIMITER ;

-- 28.3 Create a procedure to simulate point-in-time recovery
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
    
    -- Step 6: Verification
    SELECT 
        'Command: Run data verification queries to ensure consistency' AS step,
        'Verification completed' AS status;
    
    -- Return summary
    SELECT 
        CONCAT('Database successfully recovered to point-in-time: ', DATE_FORMAT(recovery_timestamp, '%Y-%m-%d %H:%i:%s')) AS summary,
        'Recovery simulation completed' AS result;
END //
DELIMITER ;

-- ==================================================
-- 📌 SECTION 29: CROSS-DATABASE STATISTICS GENERATION
-- ==================================================

-- 29.1 Create a procedure to generate comprehensive database statistics
DELIMITER //
CREATE PROCEDURE GenerateDatabaseStats()
BEGIN
    -- Create a summary table
    CREATE TABLE IF NOT EXISTS database_statistics (
        stat_id INT AUTO_INCREMENT PRIMARY KEY,
        database_name VARCHAR(100),
        total_tables INT,
        total_views INT,
        total_stored_procedures INT,
        total_functions INT,
        total_triggers INT,
        total_rows BIGINT,
        total_data_size_mb DECIMAL(10,2),
        total_index_size_mb DECIMAL(10,2),
        largest_table VARCHAR(100),
        largest_table_rows INT,
        largest_table_size_mb DECIMAL(10,2),
        stat_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    -- Insert statistics for cdac_tutorial database
    INSERT INTO database_statistics (
        database_name, total_tables, total_views, total_stored_procedures, 
        total_functions, total_triggers, total_rows, total_data_size_mb, 
        total_index_size_mb, largest_table, largest_table_rows, largest_table_size_mb
    )
    SELECT 
        'cdac_tutorial' AS database_name,
        SUM(CASE WHEN t.TABLE_TYPE = 'BASE TABLE' THEN 1 ELSE 0 END) AS total_tables,
        SUM(CASE WHEN t.TABLE_TYPE = 'VIEW' THEN 1 ELSE 0 END) AS total_views,
        (SELECT COUNT(*) FROM information_schema.ROUTINES WHERE ROUTINE_SCHEMA = 'cdac_tutorial' AND ROUTINE_TYPE = 'PROCEDURE') AS total_stored_procedures,
        (SELECT COUNT(*) FROM information_schema.ROUTINES WHERE ROUTINE_SCHEMA = 'cdac_tutorial' AND ROUTINE_TYPE = 'FUNCTION') AS total_functions,
        (SELECT COUNT(*) FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA = 'cdac_tutorial') AS total_triggers,
        SUM(t.TABLE_ROWS) AS total_rows,
        ROUND(SUM(t.DATA_LENGTH) / (1024 * 1024), 2) AS total_data_size_mb,
        ROUND(SUM(t.INDEX_LENGTH) / (1024 * 1024), 2) AS total_index_size_mb,
        (SELECT TABLE_NAME FROM information_schema.TABLES 
         WHERE TABLE_SCHEMA = 'cdac_tutorial' AND TABLE_TYPE = 'BASE TABLE' 
         ORDER BY DATA_LENGTH DESC LIMIT 1) AS largest_table,
        (SELECT TABLE_ROWS FROM information_schema.TABLES 
         WHERE TABLE_SCHEMA = 'cdac_tutorial' AND TABLE_TYPE = 'BASE TABLE' 
         ORDER BY DATA_LENGTH DESC LIMIT 1) AS largest_table_rows,
        (SELECT ROUND(DATA_LENGTH / (1024 * 1024), 2) FROM information_schema.TABLES 
         WHERE TABLE_SCHEMA = 'cdac_tutorial' AND TABLE_TYPE = 'BASE TABLE' 
         ORDER BY DATA_LENGTH DESC LIMIT 1) AS largest_table_size_mb
    FROM information_schema.TABLES t
    WHERE t.TABLE_SCHEMA = 'cdac_tutorial';
    
    -- Insert statistics for cdac_analytics_db database
    INSERT INTO database_statistics (
        database_name, total_tables, total_views, total_stored_procedures, 
        total_functions, total_triggers, total_rows, total_data_size_mb, 
        total_index_size_mb, largest_table, largest_table_rows, largest_table_size_mb
    )
    SELECT 
        'cdac_analytics_db' AS database_name,
        SUM(CASE WHEN t.TABLE_TYPE = 'BASE TABLE' THEN 1 ELSE 0 END) AS total_tables,
        SUM(CASE WHEN t.TABLE_TYPE = 'VIEW' THEN 1 ELSE 0 END) AS total_views,
        (SELECT COUNT(*) FROM information_schema.ROUTINES WHERE ROUTINE_SCHEMA = 'cdac_analytics_db' AND ROUTINE_TYPE = 'PROCEDURE') AS total_stored_procedures,
        (SELECT COUNT(*) FROM information_schema.ROUTINES WHERE ROUTINE_SCHEMA = 'cdac_analytics_db' AND ROUTINE_TYPE = 'FUNCTION') AS total_functions,
        (SELECT COUNT(*) FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA = 'cdac_analytics_db') AS total_triggers,
        SUM(t.TABLE_ROWS) AS total_rows,
        ROUND(SUM(t.DATA_LENGTH) / (1024 * 1024), 2) AS total_data_size_mb,
        ROUND(SUM(t.INDEX_LENGTH) / (1024 * 1024), 2) AS total_index_size_mb,
        (SELECT TABLE_NAME FROM information_schema.TABLES 
         WHERE TABLE_SCHEMA = 'cdac_analytics_db' AND TABLE_TYPE = 'BASE TABLE' 
         ORDER BY DATA_LENGTH DESC LIMIT 1) AS largest_table,
        (SELECT TABLE_ROWS FROM information_schema.TABLES 
         WHERE TABLE_SCHEMA = 'cdac_analytics_db' AND TABLE_TYPE = 'BASE TABLE' 
         ORDER BY DATA_LENGTH DESC LIMIT 1) AS largest_table_rows,
        (SELECT ROUND(DATA_LENGTH / (1024 * 1024), 2) FROM information_schema.TABLES 
         WHERE TABLE_SCHEMA = 'cdac_analytics_db' AND TABLE_TYPE = 'BASE TABLE' 
         ORDER BY DATA_LENGTH DESC LIMIT 1) AS largest_table_size_mb
    FROM information_schema.TABLES t
    WHERE t.TABLE_SCHEMA = 'cdac_analytics_db';
    
    -- Display the statistics
    SELECT * FROM database_statistics ORDER BY stat_date DESC;
END //
DELIMITER ;

-- ==================================================
-- 📌 SECTION 30: DATA ARCHIVING
-- ==================================================

-- 30.1 Create an archive table for old enrollments
CREATE TABLE enrollment_archives (
    archive_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade VARCHAR(2),
    status VARCHAR(20),
    feedback TEXT,
    archive_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    archive_reason VARCHAR(50)
);

-- 30.2 Create a procedure to archive old data
DELIMITER //
CREATE PROCEDURE ArchiveOldEnrollments(IN archive_before_date DATE)
BEGIN
    DECLARE archived_count INT DEFAULT 0;
    
    -- Start a transaction for consistency
    START TRANSACTION;
    
    -- Insert old enrollments into the archive table
    INSERT INTO enrollment_archives (
        enrollment_id, student_id, course_id, enrollment_date, 
        grade, status, feedback, archive_reason
    )
    SELECT 
        enrollment_id, student_id, course_id, enrollment_date,
        grade, status, feedback, 'Aged data archival'
    FROM enrollments
    WHERE enrollment_date < archive_before_date
    AND status IN ('Completed', 'Dropped');
    
    -- Save the count of archived records
    SET archived_count = ROW_COUNT();
    
    -- Delete the archived records from the main table
    DELETE FROM enrollments 
    WHERE enrollment_date < archive_before_date
    AND status IN ('Completed', 'Dropped');
    
    -- Commit the transaction
    COMMIT;
    
    -- Return the results
    SELECT 
        CONCAT(archived_count, ' enrollments archived successfully.') AS archive_summary,
        CONCAT('Data before ', archive_before_date, ' moved to enrollment_archives table.') AS details;
END //
DELIMITER ;

-- 30.3 Create a procedure to retrieve archived data when needed
DELIMITER //
CREATE PROCEDURE RetrieveArchivedEnrollment(IN archived_enrollment_id INT)
BEGIN
    -- Display the archived record
    SELECT * FROM enrollment_archives
    WHERE enrollment_id = archived_enrollment_id;
    
    -- Provide restore command
    SELECT 
        CONCAT('To restore this enrollment, run: INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade, status, feedback) ',
               'SELECT enrollment_id, student_id, course_id, enrollment_date, grade, status, feedback ',
               'FROM enrollment_archives WHERE enrollment_id = ', archived_enrollment_id, ';') AS restore_command;
END //
DELIMITER ;

-- ==================================================
-- 📌 SECTION 31: DATABASE REPLICATION
-- ==================================================

-- 31.1 Document replication setup (commands would be run at MySQL server level, not as SQL)
CREATE TABLE replication_documentation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    replication_type VARCHAR(50),
    server_role VARCHAR(20),
    server_config TEXT,
    setup_command TEXT,
    monitoring_command TEXT,
    description TEXT
);

-- 31.2 Insert documentation for Master-Slave replication
INSERT INTO replication_documentation (replication_type, server_role, server_config, setup_command, monitoring_command, description) VALUES
('Master-Slave', 'Master', 
 '[mysqld]\nserver-id=1\nlog_bin=mysql-bin\nbinlog_format=ROW\nbinlog_do_db=cdac_tutorial\nbinlog_do_db=cdac_analytics_db\n', 
 'CREATE USER \'repl\'@\'%\' IDENTIFIED BY \'password\';\nGRANT REPLICATION SLAVE ON *.* TO \'repl\'@\'%\';\nFLUSH PRIVILEGES;\nFLUSH TABLES WITH READ LOCK;\nSHOW MASTER STATUS;', 
 'SHOW MASTER STATUS;\nSHOW PROCESSLIST;', 
 'The Master server records changes to its databases in its binary log files. These logs are then sent to Slave servers for replication. Master servers handle write operations.'),

('Master-Slave', 'Slave', 
 '[mysqld]\nserver-id=2\nrelay_log=relay-bin\nread_only=1\n', 
 'CHANGE MASTER TO\nMASTER_HOST=\'master_ip\',\nMASTER_USER=\'repl\',\nMASTER_PASSWORD=\'password\',\nMASTER_LOG_FILE=\'mysql-bin.000001\',\nMASTER_LOG_POS=123;\nSTART SLAVE;', 
 'SHOW SLAVE STATUS\\G', 
 'The Slave server connects to the Master and requests updates that have occurred since the last synchronization. Slave servers handle read operations to distribute database load.');

-- 31.3 Insert documentation for Group Replication
INSERT INTO replication_documentation (replication_type, server_role, server_config, setup_command, monitoring_command, description) VALUES
('Group Replication', 'Member', 
 '[mysqld]\nserver_id=1\ngtid_mode=ON\nenforce_gtid_consistency=ON\nbinlog_checksum=NONE\nlog_bin=binlog\nlog_slave_updates=ON\nbinlog_format=ROW\nmaster_info_repository=TABLE\nrelay_log_info_repository=TABLE\ntransaction_write_set_extraction=XXHASH64\nloose-group_replication_group_name="aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"\nloose-group_replication_start_on_boot=off\nloose-group_replication_local_address="server1:33061"\nloose-group_replication_group_seeds="server1:33061,server2:33061,server3:33061"\nloose-group_replication_bootstrap_group=off', 
 'SET SQL_LOG_BIN=0;\nCREATE USER \'repl\'@\'%\' IDENTIFIED BY \'password\';\nGRANT REPLICATION SLAVE ON *.* TO \'repl\'@\'%\';\nFLUSH PRIVILEGES;\nSET SQL_LOG_BIN=1;\nCHANGE MASTER TO MASTER_USER=\'repl\', MASTER_PASSWORD=\'password\' FOR CHANNEL \'group_replication_recovery\';\nINSTALL PLUGIN group_replication SONAME \'group_replication.so\';\nSET GLOBAL group_replication_bootstrap_group=ON;\nSTART GROUP_REPLICATION;\nSET GLOBAL group_replication_bootstrap_group=OFF;', 
 'SELECT * FROM performance_schema.replication_group_members;\nSELECT * FROM performance_schema.replication_group_member_stats\\G', 
 'Group Replication is a multi-master update-everywhere replication plugin for MySQL. It provides highly available and fault-tolerant replicated tables with built-in conflict detection and resolution.');

-- 31.4 Query to display replication documentation
SELECT * FROM replication_documentation;

-- ==================================================
-- 📌 SECTION 32: PRACTICAL CASE STUDIES
-- ==================================================

-- 32.1 Case Study 1: Data Migration Planning
CREATE TABLE data_migration_plan (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    phase VARCHAR(50),
    task_description TEXT,
    estimated_duration VARCHAR(50),
    prerequisites TEXT,
    risk_level ENUM('Low', 'Medium', 'High'),
    mitigation_strategy TEXT,
    responsible_team VARCHAR(100)
);

INSERT INTO data_migration_plan (phase, task_description, estimated_duration, prerequisites, risk_level, mitigation_strategy, responsible_team) VALUES
('Planning', 'Document current database schema and data volume analysis', '3 days', 'Access to source database', 'Low', 'N/A', 'Database Team'),
('Planning', 'Design target database schema with improvements', '5 days', 'Current schema documentation', 'Medium', 'Peer review and testing of new schema design', 'Database Team'),
('Planning', 'Develop data mapping between source and target', '4 days', 'Both source and target schemas', 'Medium', 'Validation with business stakeholders', 'Database Team & Business Analysts'),
('Preparation', 'Set up target database environment', '2 days', 'Hardware and software requirements finalized', 'Medium', 'Use infrastructure as code for reproducibility', 'Infrastructure Team'),
('Preparation', 'Create migration scripts and test with sample data', '7 days', 'Data mapping document', 'High', 'Thorough unit testing and code review', 'Development Team'),
('Testing', 'Perform trial migration with subset of data', '3 days', 'Migration scripts and target environment', 'Medium', 'Automated data validation scripts', 'Database & QA Teams'),
('Testing', 'Validate data integrity and application functionality', '5 days', 'Completed trial migration', 'High', 'Comprehensive test cases covering critical data paths', 'QA Team'),
('Execution', 'Schedule maintenance window and notify stakeholders', '1 day', 'Successful testing phase', 'Low', 'Clear communication plan with escalation paths', 'Project Management'),
('Execution', 'Backup source database', '4 hours', 'Approved maintenance window', 'Medium', 'Verify backup integrity before proceeding', 'Database Team'),
('Execution', 'Execute full data migration', '8




-- =====================================================================
-- 🎓 COMPREHENSIVE SQL TUTORIAL - CDAC DBDA COURSE
-- =====================================================================
-- Author: Database Instructor
-- Version: 1.0
-- Purpose: Learn SQL from basics to advanced concepts
-- =====================================================================

-- =========================
-- 📌 SECTION 1: DATABASE FUNDAMENTALS
-- =========================

-- 1.1 Creating a new database
-- A database is like a container for all your related tables and data
CREATE DATABASE IF NOT EXISTS cdac_tutorial;

-- 1.2 Select which database to use
-- This tells MySQL which database you'll be working with
USE cdac_tutorial;

-- 1.3 View all databases on the server
SHOW DATABASES;

-- 1.4 Delete a database (BE VERY CAREFUL!)
-- This will permanently delete the database and all its contents
-- DROP DATABASE database_name;  -- Commented out for safety

-- =========================
-- 📌 SECTION 2: TABLE CREATION (DDL - Data Definition Language)
-- =========================

-- 2.1 Create a simple table
-- Tables store data in rows and columns, like a spreadsheet
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary key - unique identifier
    first_name VARCHAR(50) NOT NULL,  -- NOT NULL means this field must have a value
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,  -- Stores date values
    email VARCHAR(100) UNIQUE,  -- UNIQUE means no two students can have the same email
    phone VARCHAR(15),
    gender ENUM('Male', 'Female', 'Other'),  -- ENUM restricts to specific values
    enrollment_date DATE DEFAULT (CURRENT_DATE),  -- DEFAULT gives a fallback value
    is_active BOOLEAN DEFAULT TRUE,  -- Boolean values (TRUE/FALSE)
    cgpa DECIMAL(3,2),  -- DECIMAL(3,2) means 3 digits total, 2 after decimal (e.g., 9.45)
    address TEXT,  -- TEXT can store longer strings
    profile_picture BLOB,  -- BLOB stores binary data like images
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically set to current time
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Auto-updates on changes
);

-- 2.2 Create a departments table
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,  -- Department names must be unique
    hod_name VARCHAR(100),  -- HOD = Head of Department
    office_location VARCHAR(50),
    contact_email VARCHAR(100),
    established_date DATE,
    budget DECIMAL(12,2) DEFAULT 0.00  -- Large decimal for money values
);

-- 2.3 Create a courses table (with foreign key relationship)
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT DEFAULT 3,
    department_id INT,  -- This will reference departments table
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    
    -- FOREIGN KEY links this table to another table
    -- If a department is deleted, set department_id to NULL here
    FOREIGN KEY (department_id) REFERENCES departments(department_id) 
        ON DELETE SET NULL
);

-- 2.4 Create an enrollments table (many-to-many relationship)
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade VARCHAR(2),
    
    -- If a student is deleted, delete their enrollments too
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
        
    -- If a course is deleted, delete related enrollments
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE,
        
    -- Prevent duplicate enrollments (student can't enroll in same course twice)
    UNIQUE KEY (student_id, course_id)
);

-- 2.5 View table structure
DESCRIBE students;
DESCRIBE departments;
DESCRIBE courses;
DESCRIBE enrollments;

-- 2.6 Show create statement for a table
SHOW CREATE TABLE students;

-- 2.7 Modify table structure - add a new column
ALTER TABLE students 
ADD COLUMN nationality VARCHAR(50) DEFAULT 'Indian';

-- 2.8 Modify table structure - modify existing column
ALTER TABLE students
MODIFY COLUMN phone VARCHAR(20);  -- Changed from VARCHAR(15) to VARCHAR(20)

-- 2.9 Modify table structure - rename column
ALTER TABLE students
CHANGE COLUMN nationality country VARCHAR(50) DEFAULT 'India';

-- 2.10 Modify table structure - drop column
ALTER TABLE students
DROP COLUMN profile_picture;  -- Removing the BLOB column

-- 2.11 Add a check constraint
ALTER TABLE students
ADD CONSTRAINT check_cgpa CHECK (cgpa >= 0 AND cgpa <= 10);

-- 2.12 Rename a table
-- RENAME TABLE old_table_name TO new_table_name;

-- 2.13 Drop a table (BE CAREFUL!)
-- DROP TABLE table_name;  -- Commented out for safety

-- =========================
-- 📌 SECTION 3: INSERTING DATA (DML - Data Manipulation Language)
-- =========================

-- 3.1 Insert a single row
INSERT INTO departments (department_name, hod_name, office_location, established_date, budget)
VALUES ('Computer Science', 'Dr. Rajesh Kumar', 'Block A, Room 101', '2010-06-15', 5000000.00);

-- 3.2 Insert multiple rows at once
INSERT INTO departments (department_name, hod_name, office_location, established_date, budget) VALUES 
('Data Science', 'Dr. Priya Singh', 'Block B, Room 201', '2015-07-20', 6000000.00),
('Information Technology', 'Dr. Amit Verma', 'Block A, Room 105', '2012-04-10', 4500000.00),
('Artificial Intelligence', 'Dr. Sneha Patel', 'Block C, Room 301', '2018-08-05', 7000000.00),
('Database Management', 'Dr. Vikram Singh', 'Block B, Room 205', '2014-03-15', 4000000.00);

-- 3.3 Insert data into the courses table
INSERT INTO courses (course_code, course_name, credits, department_id, description) VALUES
('CS101', 'Introduction to Programming', 4, 1, 'Fundamentals of programming using C and Python'),
('DS101', 'Fundamentals of Data Science', 4, 2, 'Introduction to data science concepts and tools'),
('IT101', 'Computer Networks', 3, 3, 'Principles of computer networking and protocols'),
('AI101', 'Introduction to Artificial Intelligence', 4, 4, 'Foundations of AI and intelligent systems'),
('DB101', 'Database Management Systems', 4, 5, 'Fundamentals of database design and SQL'),
('CS201', 'Data Structures', 4, 1, 'Study of fundamental data structures and algorithms'),
('DS201', 'Statistical Methods for Data Science', 3, 2, 'Statistical foundations for data analysis'),
('DB201', 'Advanced Database Concepts', 3, 5, 'Advanced topics in database management');

-- 3.4 Insert student data
INSERT INTO students (first_name, last_name, date_of_birth, email, phone, gender, cgpa, address) VALUES
('Rahul', 'Sharma', '2000-05-15', 'rahul.sharma@example.com', '9876543210', 'Male', 8.5, 'Mumbai, Maharashtra'),
('Priya', 'Patel', '2001-03-22', 'priya.patel@example.com', '9876543211', 'Female', 9.2, 'Pune, Maharashtra'),
('Amit', 'Kumar', '1999-11-10', 'amit.kumar@example.com', '9876543212', 'Male', 7.8, 'Delhi, Delhi'),
('Neha', 'Singh', '2000-07-05', 'neha.singh@example.com', '9876543213', 'Female', 8.9, 'Bangalore, Karnataka'),
('Vikram', 'Joshi', '1998-09-18', 'vikram.joshi@example.com', '9876543214', 'Male', 8.1, 'Chennai, Tamil Nadu');

-- 3.5 Insert enrollment data
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

-- 3.6 Insert with SELECT (insert data from another table or query)
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

-- Now insert from temp_students into students
INSERT INTO students (first_name, last_name, email, cgpa, gender)
SELECT 
    first_name, 
    last_name, 
    email, 
    cgpa,
    'Male' -- Default gender for all (just for demonstration)
FROM temp_students;

-- Clean up the temporary table
DROP TABLE temp_students;

-- =========================
-- 📌 SECTION 4: BASIC QUERIES (DQL - Data Query Language)
-- =========================

-- 4.1 SELECT all columns from a table
SELECT * FROM students;

-- 4.2 SELECT specific columns
SELECT first_name, last_name, email, cgpa FROM students;

-- 4.3 SELECT with aliasing (renaming columns in results)
SELECT 
    first_name AS "First Name", 
    last_name AS "Last Name",
    cgpa AS "CGPA Score"
FROM students;

-- 4.4 SELECT with simple WHERE conditions
SELECT * FROM students WHERE gender = 'Female';

-- 4.5 WHERE with comparison operators
SELECT * FROM students WHERE cgpa > 8.5;
SELECT * FROM students WHERE date_of_birth >= '2000-01-01';

-- 4.6 WHERE with multiple conditions (AND, OR)
SELECT * FROM students 
WHERE gender = 'Male' AND cgpa > 8.0;

SELECT * FROM students 
WHERE cgpa > 9.0 OR date_of_birth > '2000-01-01';

-- 4.7 WHERE with IN operator (matching multiple values)
SELECT * FROM students 
WHERE student_id IN (1, 3, 5);

-- 4.8 WHERE with BETWEEN operator (range of values)
SELECT * FROM students 
WHERE cgpa BETWEEN 8.0 AND 9.0;

-- 4.9 WHERE with LIKE operator (pattern matching)
-- % = wildcard for any number of characters
-- _ = wildcard for exactly one character
SELECT * FROM students 
WHERE first_name LIKE 'A%';  -- Names starting with 'A'

SELECT * FROM students 
WHERE email LIKE '%@example.com';  -- Emails ending with @example.com

SELECT * FROM students 
WHERE last_name LIKE 'S_____';  -- Last names starting with S and exactly 6 letters

-- 4.10 WHERE with NULL checks
SELECT * FROM students 
WHERE date_of_birth IS NULL;

SELECT * FROM students 
WHERE date_of_birth IS NOT NULL;

-- 4.11 ORDER BY (sorting results)
SELECT * FROM students 
ORDER BY cgpa DESC;  -- Descending order (highest to lowest)

SELECT * FROM students 
ORDER BY last_name ASC, first_name ASC;  -- Sort by last name, then first name

-- 4.12 LIMIT (restricting number of rows returned)
SELECT * FROM students 
ORDER BY cgpa DESC
LIMIT 3;  -- Top 3 students by CGPA

-- 4.13 LIMIT with OFFSET (pagination)
SELECT * FROM students 
ORDER BY student_id
LIMIT 2 OFFSET 2;  -- Skip first 2 students, show next 2

-- 4.14 DISTINCT (removing duplicates)
SELECT DISTINCT gender FROM students;

-- =========================
-- 📌 SECTION 5: AGGREGATE FUNCTIONS
-- =========================

-- 5.1 COUNT (counting rows)
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(date_of_birth) AS students_with_dob FROM students;  -- NULL values not counted

-- 5.2 COUNT with WHERE
SELECT COUNT(*) AS male_students FROM students WHERE gender = 'Male';

-- 5.3 SUM (adding numeric values)
SELECT SUM(credits) AS total_credits FROM courses;

-- 5.4 AVG (average of numeric values)
SELECT AVG(cgpa) AS average_cgpa FROM students;

-- 5.5 MIN and MAX (minimum and maximum values)
SELECT 
    MIN(cgpa) AS lowest_cgpa,
    MAX(cgpa) AS highest_cgpa
FROM students;

-- 5.6 GROUP BY (grouping rows for aggregation)
SELECT gender, COUNT(*) AS count
FROM students
GROUP BY gender;

SELECT 
    department_id, 
    COUNT(*) AS course_count,
    SUM(credits) AS total_credits
FROM courses
GROUP BY department_id;

-- 5.7 HAVING (filtering on aggregate results)
SELECT 
    department_id, 
    COUNT(*) AS course_count
FROM courses
GROUP BY department_id
HAVING COUNT(*) > 1;  -- Only departments with more than 1 course

-- 5.8 GROUP BY with ORDER BY
SELECT 
    department_id, 
    AVG(credits) AS avg_credits
FROM courses
GROUP BY department_id
ORDER BY avg_credits DESC;

-- =========================
-- 📌 SECTION 6: JOINS AND RELATIONSHIPS
-- =========================

-- 6.1 INNER JOIN (only matching rows in both tables)
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

-- 6.2 LEFT JOIN (all rows from left table, matching from right)
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

-- 6.3 RIGHT JOIN (all rows from right table, matching from left)
SELECT 
    c.course_id,
    c.course_name,
    e.student_id,
    s.first_name,
    s.last_name
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
LEFT JOIN students s ON e.student_id = s.student_id;

-- 6.4 FULL JOIN (all rows from both tables)
-- MySQL doesn't support FULL JOIN directly, but you can simulate it with UNION
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

-- 6.5 CROSS JOIN (cartesian product - every row from first table with every row from second)
-- Be careful! This can produce very large result sets
SELECT 
    s.first_name,
    c.course_name
FROM students s
CROSS JOIN courses c
LIMIT 10;  -- Limiting results for demonstration

-- 6.6 SELF JOIN (joining a table to itself)
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

-- 7.1 Subquery in WHERE clause
-- Find students with above-average CGPA
SELECT first_name, last_name, cgpa
FROM students
WHERE cgpa > (SELECT AVG(cgpa) FROM students);

-- 7.2 Subquery with IN operator
-- Find all courses taken by student with ID 1
SELECT course_code, course_name
FROM courses
WHERE course_id IN (
    SELECT course_id
    FROM enrollments
    WHERE student_id = 1
);

-- 7.3 Subquery in FROM clause (derived table)
SELECT avg_cgpa_by_gender.gender, avg_cgpa_by_gender.average_cgpa
FROM (
    SELECT gender, AVG(cgpa) AS average_cgpa
    FROM students
    GROUP BY gender
) AS avg_cgpa_by_gender
WHERE avg_cgpa_by_gender.average_cgpa > 8.0;

-- 7.4 Correlated subquery (inner query references outer query)
-- Find students who have at least one grade of 'A+'
SELECT s.student_id, s.first_name, s.last_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id AND e.grade = 'A+'
);

-- 7.5 Subquery in SELECT clause
SELECT 
    d.department_id,
    d.department_name,
    (SELECT COUNT(*) FROM courses c WHERE c.department_id = d.department_id) AS course_count
FROM departments d;

-- 7.6 Multiple level subqueries
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

-- 8.1 Basic CTE (temporary result set)
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

-- 8.2 Multiple CTEs
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

-- 8.3 Recursive CTE
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

-- 8.4 Using recursive CTE for hierarchical data (employees example)
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

-- 9.1 Basic UPDATE statement
UPDATE students
SET phone = '9999999999'
WHERE student_id = 1;

-- 9.2 UPDATE multiple columns
UPDATE students
SET 
    cgpa = 9.0,
    address = 'New Mumbai Address'
WHERE student_id = 1;

-- 9.3 UPDATE with calculations
UPDATE students
SET cgpa = cgpa + 0.5
WHERE cgpa < 8.0;

-- 9.4 UPDATE with JOIN
UPDATE courses c
JOIN departments d ON c.department_id = d.department_id
SET c.is_active = FALSE
WHERE d.department_name = 'Database Management' AND c.course_code = 'DB101';

-- 9.5 UPDATE with subquery
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

-- 10.1 Basic DELETE statement
-- First, add a test student
INSERT INTO students (first_name, last_name, email, cgpa)
VALUES ('Test', 'Student', 'test.student@example.com', 5.0);

-- Then delete the test student
DELETE FROM students
WHERE first_name = 'Test' AND last_name = 'Student';

-- 10.2 DELETE with JOIN
-- Insert test data
INSERT INTO courses (course_code, course_name, department_id)
VALUES ('TEST101', 'Test Course', 5);

-- Delete using JOIN
DELETE c
FROM courses c
JOIN departments d ON c.department_id = d.department_id
WHERE c.course_code = 'TEST101' AND d.department_name = 'Database Management';

-- 10.3 DELETE with subquery
-- Insert test data first
INSERT INTO enrollments (student_id, course_id, grade)
VALUES (1, 5, 'F');

-- Delete enrollments with 'F' grades
DELETE FROM enrollments
WHERE grade = 'F' AND student_id IN (
    SELECT student_id FROM students WHERE cgpa > 8.0
);

-- 10.4 TRUNCATE TABLE (delete all rows quickly)
-- CREATE TABLE temp_demo (id INT, name VARCHAR(50));
-- INSERT INTO temp_demo VALUES (1, 'Test'), (2, 'Test2');
-- TRUNCATE TABLE temp_demo;  -- Deletes all rows, faster than DELETE

-- =========================
-- 📌 SECTION 11: FUNCTIONS AND EXPRESSIONS
-- =========================

-- 11.1 String functions
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

-- 11.2 Numeric functions
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

-- 11.3 Date and time functions
SELECT 
    enrollment_date,
    DATE_ADD(enrollment_date, INTERVAL 6 MONTH) AS six_months_later,
    DATEDIFF(CURRENT_DATE, enrollment_date) AS days_enrolled,
    YEAR(enrollment_date) AS enrollment_year,
    MONTH(enrollment_date) AS enrollment_month,
    DAY(enrollment_date) AS enrollment_day,
    DAYNAME(enrollment_date) AS day_of_week
FROM enrollments;

-- 11.4 Conditional expressions (CASE)
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

-- 11.5 Conditional expressions in aggregate functions
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

-- 12.1 Create a simple view
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

-- 12.2 Query from a view
SELECT * FROM student_course_view
WHERE grade = 'A';

-- 12.3 Create a view with calculations
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

-- 12.4 Create an updatable view
CREATE OR REPLACE VIEW active_students AS
SELECT student_id, first_name, last_name, email, phone, cgpa
FROM students
WHERE is_active = TRUE
WITH CHECK OPTION;  -- Prevents updates that would make rows invisible to the view

-- 12.5 Update through a view
UPDATE active_students
SET phone = '8888888888'
WHERE student_id = 2;

-- 12.6 Drop a view
-- DROP VIEW student_course_view;

-- =========================
-- 📌 SECTION 13: STORED PROCEDURES
-- =========================

-- 13.1 Create a simple stored procedure
DELIMITER //
CREATE PROCEDURE GetAllStudents()
BEGIN
    SELECT * FROM students;
END //
DELIMITER ;

-- 13.2 Call a stored procedure
CALL GetAllStudents();

-- 13.3 Procedure with input parameters
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

-- 13.4 Call procedure with parameters
CALL GetStudentsByGrade('A');

-- 13.5 Procedure with output parameters
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

-- 13.6 Call procedure with output parameters
CALL GetDepartmentStats(1, @count, @avg);
SELECT @count AS course_count, @avg AS average_credits;

-- 13.7 Procedure with conditional logic
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

-- 13.8 Procedure with error handling
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
    
    -- Check if student exists
    SELECT COUNT(*) INTO student_exists
    FROM students
    WHERE student_id = student_id_param;
    
    -- Check if course exists
    SELECT COUNT(*) INTO course_exists
    FROM courses
    WHERE course_id = course_id_param;
    
    -- Check if already enrolled
    SELECT COUNT(*) INTO already_enrolled
    FROM enrollments
    WHERE student_id = student_id_param AND course_id = course_id_param;
    
    -- Validate inputs
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

-- 13.9 Procedure with loops
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

-- 14.1 Create a simple scalar function
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

-- 14.2 Use the function
SELECT CalculateGrade(92) AS grade;

-- 14.3 Function with table data
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

-- 14.4 Use the function in a query
SELECT 
    student_id,
    GetStudentFullName(student_id) AS full_name,
    cgpa
FROM students;

-- 14.5 Function to calculate age
DELIMITER //
CREATE FUNCTION CalculateAge(birth_date DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
END //
DELIMITER ;

-- 14.6 Use the age function
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

-- 15.1 Create an audit table
CREATE TABLE student_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    action_type VARCHAR(10) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSON,
    new_data JSON
);

-- 15.2 Create an AFTER INSERT trigger
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

-- 15.3 Create an AFTER UPDATE trigger
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

-- 15.4 Create an AFTER DELETE trigger
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

-- 15.5 Create a BEFORE INSERT trigger (data validation)
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

-- 15.6 Test triggers
-- Insert a new student to trigger after_student_insert
INSERT INTO students (first_name, last_name, email, cgpa)
VALUES ('Trigger', 'Test', 'trigger.test@example.com', 7.5);

-- Update a student to trigger after_student_update
UPDATE students
SET cgpa = 8.0
WHERE first_name = 'Trigger';

-- Delete the student to trigger after_student_delete
DELETE FROM students
WHERE first_name = 'Trigger';

-- Check the audit table
SELECT * FROM student_audit;

-- =========================
-- 📌 SECTION 16: TRANSACTIONS
-- =========================

-- 16.1 Simple transaction
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

-- 16.2 Transaction with error handling
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

-- 16.3 Call the transaction procedure
CALL TransferStudent(1, 1, 5);

-- =========================
-- 📌 SECTION 17: INDEXES
-- =========================

-- 17.1 View existing indexes
SHOW INDEX FROM students;

-- 17.2 Create a simple index
CREATE INDEX idx_student_email ON students(email);

-- 17.3 Create a composite index
CREATE INDEX idx_enrollment_student_course ON enrollments(student_id, course_id);

-- 17.4 Create a unique index
CREATE UNIQUE INDEX idx_course_code_unique ON courses(course_code);

-- 17.5 Create a fulltext index
ALTER TABLE courses ADD FULLTEXT INDEX idx_course_fulltext(course_name, description);

-- 17.6 Use a fulltext index
SELECT course_id, course_name, description
FROM courses
WHERE MATCH(course_name, description) AGAINST('database' IN NATURAL LANGUAGE MODE);

-- 17.7 Drop an index
-- DROP INDEX idx_student_email ON students;

-- =========================
-- 📌 SECTION 18: DATABASE ADMINISTRATION
-- =========================

-- 18.1 Create a user
-- CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'student_password';

-- 18.2 Grant privileges
-- GRANT SELECT ON cdac_tutorial.* TO 'student_user'@'localhost';
-- GRANT SELECT, INSERT, UPDATE ON cdac_tutorial.students TO 'student_user'@'localhost';

-- 18.3 Revoke privileges
-- REVOKE INSERT ON cdac_tutorial.students FROM 'student_user'@'localhost';

-- 18.4 Drop a user
-- DROP USER 'student_user'@'localhost';

-- 18.5 Check database status
SHOW TABLE STATUS FROM cdac_tutorial;

-- 18.6 Optimize tables
OPTIMIZE TABLE students, enrollments;

-- 18.7 View server variables
SHOW VARIABLES LIKE 'max_connections';

-- 18.8 View process list
SHOW PROCESSLIST;

-- =========================
-- 📌 SECTION 19: ADVANCED SQL FEATURES
-- =========================

-- 19.1 Window functions
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

-- 19.2 JSON data
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

-- 19.3 Pivot tables (using conditional aggregation)
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

-- 20.1 EXPLAIN to analyze query execution plan
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

-- 20.2 Using indexes effectively
CREATE INDEX idx_student_cgpa ON students(cgpa);

-- 20.3 Rewriting queries for better performance
-- Original query
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

-- Optimized query (if department_name is used frequently)
CREATE INDEX idx_department_name ON departments(department_name);

-- 20.4 Using appropriate JOINs
-- Use INNER JOIN when you only need matching rows
-- Use LEFT JOIN when you need all rows from the left table

-- 20.5 Limiting result sets
SELECT * FROM students LIMIT 10;

-- 20.6 Avoiding SELECT *
-- Instead of:
-- SELECT * FROM students;
-- Use:
SELECT student_id, first_name, last_name, email, cgpa FROM students;

-- =========================
-- 📌 SECTION 21: BEST PRACTICES
-- =========================

-- 21.1 Naming conventions
-- Use meaningful, consistent names
-- table_name (plural, lowercase with underscores)
-- column_name (singular, lowercase with underscores)

-- 21.2 Comments for documentation
-- Use comments to explain complex queries
-- Comments start with -- in SQL

-- 21.3 Security best practices
-- Use prepared statements to prevent SQL injection
-- Limit user privileges to only what's necessary

-- 21.4 Database backup
-- Regular database backups are essential
-- Command line: mysqldump -u username -p database_name > backup.sql

-- 21.5 Code organization
-- Group related tables and operations
-- Use schema diagrams to visualize relationships

-- 21.6 Version control
-- Keep track of database schema changes
-- Use migration scripts for deployment

-- =========================
-- 📌 SECTION 22: PRACTICAL EXERCISES
-- =========================

-- 22.1 Create a comprehensive student transcript
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
JOIN departments d ON s.department_id = d.department_id
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = 1  -- Change to the student you want
ORDER BY c.course_code;

-- 22.2 Department performance analysis
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

-- 22.3 Find students who need academic help (low grades)
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

-- ======== END OF SQL TUTORIAL ========