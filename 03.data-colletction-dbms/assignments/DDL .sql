-- ddl

-- Part 1: Data Definition Language (DDL) Commands
-- Task 1: Creating Tables
-- 1. Create a Students table with the following details:
-- • student_id: A unique identifier for each student. This should be the primary key and
-- should auto-increment.
-- • first_name: The first name of the student (cannot be left empty).
-- • last_name: The last name of the student (cannot be left empty).
-- • email: The email address of the student. Ensure that no two students have the same email.
-- • date_of_birth: The student's date of birth (ensure the date is in a valid range).
-- • gender: The gender of the student, restricted to the values 'Male', 'Female', or 'Other'.
-- 2. Create a Courses table with the following details:
-- • course_id: A unique identifier for each course. This should be the primary key.
-- • course_name: The name of the course (cannot be left empty).
-- • course_credits: The number of credits assigned to the course (between 1 and 5).
-- • department: The department offering the course.

-- Task 2: Adding Foreign Key Relationships
-- 3. Create an Enrollments table that records the courses taken by students with the following
-- details:
-- • enrollment _id: A unique identifier for each enrollment. This should be the primary key.
-- student_id: The ID of the student enrolling in the course. Create a foreign key
-- relationship with the student id in the Students table.
-- • course_ id: The ID of the course in which the student is enrolling. Create a foreign key
-- relationship with the course _id in the Courses table.
-- enrollment_date: The date the student enrolled in the course.


CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE CHECK (date_of_birth BETWEEN '1900-01-01' AND CURDATE()),
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);


CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_credits INT CHECK (course_credits BETWEEN 1 AND 5),
    department VARCHAR(100)
);



CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



-- Part 2: Constraints

-- Task 3: Applying Constraints
-- 4. Modify the Students table to:
-- • Add a constraint that ensures no duplicate email addresses.
-- • Ensure that the date_of_birth field is not left empty and only allows valid dates.
-- 5. Modify the Courses table to:
-- • Add a check constraint that ensures course_credits are between 1 and 5.
-- • Ensure that the course_name is unique across all courses.
-- 6. Modify the Enrollments table to: (
-- • Add a foreign key constraint that links the student_id to the Students table.
-- • Add a foreign key constraint that links the course_id to the Courses table.
-- • Add a check constraint that ensures enrollment_date is not in the future.

ALTER TABLE Students
MODIFY date_of_birth DATE NOT NULL CHECK (date_of_birth BETWEEN '1900-01-01' AND CURDATE());

ALTER TABLE Students
ADD CONSTRAINT unique_email UNIQUE (email);


ALTER TABLE Courses
ADD CONSTRAINT check_course_credits CHECK (course_credits BETWEEN 1 AND 5);

ALTER TABLE Courses
ADD CONSTRAINT unique_course_name UNIQUE (course_name);


ALTER TABLE Enrollments
ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES Students(student_id)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Enrollments
ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES Courses(course_id)
    ON DELETE CASCADE ON UPDATE CASCADE;
    
    
ALTER TABLE Enrollments
ADD CONSTRAINT check_enrollment_date CHECK (enrollment_date <= CURDATE());


-- Part 3: Table Modifications
-- Task 4: Altering and Dropping Columns
-- 7. Alter the Students table to:
-- Add a new column phone_number to store each student's phone number.
-- • Drop the gender column.
-- 8. Alter the Courses table to:
-- • Rename the department column to dept_name.
-- • Drop the course_credits column.


-- Add phone_number column
ALTER TABLE Students
ADD phone_number VARCHAR(15);

-- Drop gender column
ALTER TABLE Students
DROP COLUMN gender;

-- Rename department column to dept_name
ALTER TABLE Courses
CHANGE department dept_name VARCHAR(100);

-- Drop course_credits column
ALTER TABLE Courses
DROP COLUMN course_credits;



-- Part 4: Practical Queries
-- Task 5: Queries for Integrity Checks
-- 9. Write a query to:
-- • Retrieve all students who are enrolled in a course but do not have an email address.
-- • Find all courses that have no students enrolled.
-- 10. Write a query to:
-- • List the students who have enrolled in more than 3 courses.
-- • Display courses that have been enrolled by more than 5 students.


SELECT s.student_id, s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE s.email IS NULL OR s.email = '';


SELECT c.course_id, c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;


SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS total_courses
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 3;


SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_students
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) > 5;


