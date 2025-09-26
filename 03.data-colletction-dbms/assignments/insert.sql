-- insert into assignments

use hr;

-- 1.

INSERT INTO countries(country_id, country_name, region_id)
VALUES ('IN', 'India', 1001);

show tables;

-- 2.

INSERT INTO countries (country_id, country_name)
VALUES ('US', 'United States');

-- 3. 

CREATE TABLE country_new AS
SELECT * FROM countries;

-- 4.

INSERT INTO countries (country_id, country_name, region_id)
VALUES ('UK', 'United Kingdom', NULL);

-- 5. 

INSERT INTO countries (country_id, country_name, region_id)
VALUES 
('C1', 'India', 1001),
('C2', 'USA', 1002),
('C3', 'UK', 1003);


-- 6. 

INSERT INTO countries (country_id, country_name, region_id)
SELECT country_id, country_name, region_id
FROM country_new;


-- 7.

ALTER TABLE jobs ADD CONSTRAINT job_id_unique UNIQUE (job_id);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('J101', 'Software Engineer', 5000, 12000);

-- 8.

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('J102', 'Data Scientist', 6000, 15000);


ALTER TABLE countries ADD CONSTRAINT unique_country_region UNIQUE (country_id, region_id);

-- 9.

INSERT INTO countries (country_id, country_name, region_id)
VALUES ('CA', 'Canada', 1004);


-- 10.

ALTER TABLE countries MODIFY country_id INT AUTO_INCREMENT PRIMARY KEY;

INSERT INTO countries (country_name, region_id)
VALUES ('Germany', 1005);

-- 11.


ALTER TABLE countries MODIFY country_id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE countries MODIFY country_name VARCHAR(40) DEFAULT 'N/A';

INSERT INTO countries (region_id) VALUES (1006);


-- 12.

ALTER TABLE job_history ADD CONSTRAINT fk_job FOREIGN KEY (job_id) REFERENCES jobs(job_id);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
VALUES (101, '2025-01-01', '2025-06-30', 'J101', 10);



-- 13.

ALTER TABLE employees ADD CONSTRAINT fk_dept_manager
FOREIGN KEY (department_id, manager_id)
REFERENCES departments(department_id, manager_id);

INSERT INTO employees (employee_id, first_name, last_name, department_id, manager_id, job_id)
VALUES (201, 'Shubham', 'Raut', 10, 100, 'J101');

-- 14


ALTER TABLE employees ADD CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employees ADD CONSTRAINT fk_job FOREIGN KEY (job_id) REFERENCES jobs(job_id);

INSERT INTO employees (employee_id, first_name, last_name, department_id, job_id)
VALUES (202, 'Alex', 'Smith', 20, 'J102');






