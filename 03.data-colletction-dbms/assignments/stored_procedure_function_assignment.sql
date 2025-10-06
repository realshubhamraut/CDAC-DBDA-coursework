create database storedprofun;
use storedprofun;
show tables;

-- 1. Write a stored procedure to retrieve all employees from the Employees table for a given department ID.
delimiter $$
create procedure get_all_emp_details(out emp_id int,out emp_name varchar(50),inout dept_id decimal,out emp_email varchar(20),out ph_no varchar(20))
deterministic
begin
	select employee_id,concat(first_name,' ',last_name),department_id,email,phone_number
    into emp_id,emp_name,dept_id,emp_email,ph_no from employees
    where department_id=dept_id;
end;;
$$
delimiter ;

set @dept_id=0;

call get_all_emp_details(@emp_id,@emp_name,@dept_id,@emp_email,@ph_no);
select @emp_id as employee_id,@dept_id as department_id,@emp_name as full_name,@emp_email as email,@ph_no as phone_number;

select *from employees;


-- 2. Create a function that calculates the total salary expenditure for a given department ID.
delimiter $$
create function cal_sal(dep_id decimal)
returns decimal
deterministic
begin
	declare sal decimal;
	select sum(salary) into sal
    from employees
    where department_id=dep_id;
    return sal;
end;;
$$
delimiter ;
select cal_sal(90);

-- 3. Develop a stored procedure that accepts an employee ID as an input parameter and 
-- increases the salary of that employee by a specified percentage.
drop procedure acc_emp_sal;
delimiter $$
create procedure acc_emp_sal(in emp_id int, in sal decimal)
deterministic
begin
    UPDATE employees
    SET salary = salary + (salary * sal / 100)
    WHERE employee_id = emp_id;
end;;
$$
delimiter ;

-- set @sal=1.20;
-- set @emp_id=100;

call acc_emp_sal(100,20);
select employee_id,salary from employees where employee_id=100;

select *from employees;

-- 4. Write a function to determine the average salary for employees in a specific job title category.
delimiter $$
create function avg_sal_emp(job_t varchar(30))
returns decimal(10,2)
deterministic
begin
    declare avg_sal decimal(10,2);
    declare job varchar(20);
    
    select job_id into job 
    from jobs 
    where job_title = job_t;
    
    select avg(salary) into avg_sal
    from employees
    where job_id = job;
    
    return avg_sal;
end$$
delimiter ;

select avg_sal_emp('Sales Manager');
select *from jobs;

-- 5. Create a stored procedure that takes an employee's first name and last name as 
-- input parameters and returns the full name in uppercase letters.
drop procedure emp_name;
delimiter $$
create procedure emp_name(in f_name varchar(20),in l_name varchar(20), out full_name varchar(50))
deterministic
begin
	select upper(concat(first_name,' ',last_name)) into full_name
	from employees
    where first_name=f_name and last_name=l_name;
end;;
$$
delimiter ;
set @f_name='Neena';
set @l_name='Kochhar';
call emp_name('Neena','Kochhar',@full_name);
select @full_name as full_name_uppercase;

select *from employees;

-- 6. Write a stored procedure to insert a new employee into the Employees table with the 
-- provided first name, last name, and department ID.
delimiter $$
create procedure insert_emp(in f_name varchar(20),in l_name varchar(20), in dept_id decimal)
deterministic
begin
	insert into employees (first_name,last_name,department_id,email,hire_date,job_id)
    values (f_name,l_name,dept_id,concat(f_name,'@gmail.com'),current_date(),90);
end;;
$$
delimiter ;
set @first_name='hey';
set @last_name='bye';
set @department_id=200;
call insert_emp(@first_name,@last_name,@department_id);
call insert_emp('Neha','Sardar',203);
drop procedure insert_emp;
select * from employees where DEPARTMENT_ID=203;


-- 7. Create a function to calculate the total number of employees in a specific department.
delimiter $$
create function cal_tol_no_emp(dep_id decimal)
returns int
deterministic
begin
	declare count_emp int;
    select count(employee_id) into count_emp 
    from employees
    where dep_id=department_id;
    
    return count_emp;
end;;
$$
delimiter ;
-- drop function cal_tol_no_emp;
select cal_tol_no_emp(90) as count_of_employee_in_department;
select *from employees where department_id=90;

-- 8. Develop a stored procedure that accepts an employee ID as input and deletes that 
-- employee's record from the Employees table.
delimiter $$
create procedure delete_emp(in emp_id int)
deterministic
begin
	delete from employees where employee_id=emp_id;
end;;
$$
delimiter ;

call delete_emp(0);
select *from employees;

-- 9. Write a function to determine the highest salary in the Employees table.
delimiter $$
create function high_sal()
returns decimal
deterministic
begin
	declare h_sal decimal;
    select max(salary) into h_sal
    from employees;
    return h_sal;
end;;
$$
delimiter ;

select high_sal() as high_salary;

-- 10. Create a stored procedure that takes a department ID as an input parameter and returns 
-- the list of employees sorted by their salary in descending order within that department.
delimiter $$
create procedure list_emp(in dept_id decimal)
deterministic
begin
	select employee_id, first_name, last_name, salary
    from employees
    where department_id = dept_id
    order by salary desc;
end;;
$$
delimiter ;

call list_emp(100);

-- 11. Write a stored procedure to update the job title of an employee based on their employee ID.
delimiter $$
create procedure update_job_title(in emp_id decimal,in job_t varchar(20))
deterministic
begin
	update employees e
	join jobs j on e.job_id = j.job_id
	set j.job_title = job_t
	where e.employee_id = emp_id;
end;;
$$
delimiter ;

call update_job_title(100,'IT');
select *from jobs where job_title='IT';

-- 12. Create a function that returns the number of employees hired in a specific year.
delimiter $$
create function emp_hired(emp_year year)
returns int
deterministic
begin
    declare count_emp_inyear int;

    select COUNT(employee_id) into count_emp_inyear
    from employees
    where year(hire_date) = emp_year;

    return count_emp_inyear;
end$$

delimiter ;

select emp_hired(1987);
select *from employees;

-- 13. Develop a stored procedure that accepts an employee ID as input and retrieves the employee's details, 
-- including their name, department, and salary.
delimiter $$
create procedure accepts_employee(in emp_id decimal)
deterministic
begin
	select employee_id,first_name,last_name,department_id,salary 
    from employees where employee_id=emp_id;
end;;
$$
delimiter ;

call accepts_employee(100);
drop procedure accepts_employee;

-- 14. Write a function to calculate the average tenure (in years) of employees in the company.
delimiter $$
create function cal_avg_tenure()
returns decimal(5,2)
deterministic
begin
	declare avg_tenure decimal;
    select avg(timestampdiff(year, hire_date, CURDATE())) into avg_tenure
    from employees;
    return avg_tenure;
end$$
delimiter ;
	
select cal_avg_tenure();

-- 15. Create a stored procedure that takes a department ID as an input parameter and 
-- returns the department name along with the count of employees in that department.
DELIMITER $$

CREATE PROCEDURE get_dept_employee_count(IN dept_id INT,OUT dept_name VARCHAR(100),OUT emp_count INT)
BEGIN
    SELECT department_name INTO dept_name
    FROM departments
    WHERE department_id = dept_id;
    
    SELECT COUNT(*) INTO emp_count
    FROM employees
    WHERE department_id = dept_id;
END$$

DELIMITER ;

call get_dept_employee_count(90,@dept_name,@emp_count);
select @dept_id,@dept_name,@emp_count;


-- 16. Write a stored procedure to retrieve the top N highest-paid employees in the company, 
-- where N is an input parameter.
DELIMITER $$

create procedure get_top_n_highest_paid(IN top_n INT)
begin
    select employee_id, first_name, last_name, salary
    from employees
    order by salary desc
    limit top_n;
end$$
delimiter ;

call get_top_n_highest_paid(10);

-- 17. Create a function that calculates the total bonus amount for all employees based on their performance ratings.


-- 18. Develop a stored procedure that accepts a salary threshold as an input parameter and retrieves 
-- all employees with salaries above that threshold.
delimiter $$
create procedure accepts_emp(in sal_threshold decimal)
begin
	select employee_id,first_name,last_name,salary
    from employees
    where salary>=sal_threshold;
end;;
$$
delimiter ;

call accepts_emp(5000);

-- 19. Write a function to determine the average age of employees in the company based on their birthdates.

-- 20. Create a stored procedure that takes an employee's last name as an input parameter and returns 
-- all employees with a similar last name.
DELIMITER $$

CREATE PROCEDURE get_employees_by_lastname(IN lname VARCHAR(50))
BEGIN
    SELECT employee_id, first_name, last_name, salary
    FROM employees
    WHERE last_name LIKE CONCAT('%', lname, '%');
END$$

DELIMITER ;

call get_employees_by_lastname('De Haan');
select *from employees;

-- 21. Write a stored procedure to update the email address of an employee based on their employee ID.
DELIMITER $$

CREATE PROCEDURE update_employee_email(
    IN emp_id INT,
    IN new_email VARCHAR(100)
)
BEGIN
    UPDATE employees
    SET email = new_email
    WHERE employee_id = emp_id;
END$$

DELIMITER ;

call update_employee_email(101,'NKOCHHAR@gmail.com');
select *from employees;

-- 22. Create a function that calculates the total experience (in years) of all employees combined in the company.
DELIMITER $$
CREATE FUNCTION total_experience_years()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_exp INT;

    SELECT SUM(TIMESTAMPDIFF(YEAR, hire_date, CURDATE())) INTO total_exp
    FROM employees;

    RETURN total_exp;
END$$
DELIMITER ;

call total_experience_years();

-- 23. Develop a stored procedure that accepts a department ID as input and returns the department name 
-- along with the average salary of employees in that department.
drop procedure re_emp_details;
delimiter $$
create procedure re_emp_details(in dept_id decimal)
begin
	select d.department_id,d.department_name,avg(e.salary)
    from departments d
    join employees e
	on d.department_id=e.department_id
    where d.department_id=dept_id
    group by d.department_id, d.department_name;
end;;
$$
delimiter ;

call re_emp_details(80);

-- 24. Write a function to determine the number of employees who have been with the company 
-- for more than a specified number of years.
drop function no_of_emp_inyear;
DELIMITER $$

CREATE FUNCTION no_of_emp_inyear(min_years INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE emp_count INT;
    
    SELECT COUNT(employee_id) INTO emp_count
    FROM employees
    WHERE TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > min_years;
    
    RETURN emp_count;
END$$

DELIMITER ;

SELECT no_of_emp_inyear(2);

select *from employees where year(hire_date)=1987;

-- 25. Create a stored procedure that takes a job title as an input parameter and returns the count of employees holding that job title.

-- 26. Write a stored procedure to retrieve the details of employees who have a salary within a specified range.

-- 27. Create a function that calculates the total number of working hours for an employee in a given month.

-- 28. Develop a stored procedure that accepts an employee ID as input and retrieves the employee's department name and manager's name.

-- 29. Write a function to determine the total number of employees hired in each year, grouped by the year of hire.

-- 30. Create a stored procedure that takes a city name as an input parameter and returns the list of employees residing in that city.

-- 31. Write a stored procedure that calculates the average salary increase percentage for employees who have been with the company for more than five years.

-- 32. Create a function that calculates the total sales revenue generated by each employee in the Sales department, considering both individual and team contributions.

-- 33. Develop a stored procedure that accepts a date range as input and retrieves all employee attendance records within that period, including late arrivals and early departures.

-- 34. Write a function that determines the average number of projects handled by employees in each department and identifies departments with exceptionally high or low project volumes.

-- 35. Create a stored procedure that takes a job title as an input parameter and returns the list of employees holding that job title, along with the total compensation considering bonuses and allowances.

-- 36. Write a stored procedure that calculates the performance rating for each employee based on various criteria, such as project completion, client feedback, and adherence to deadlines.

-- 37. Create a function that determines the average time taken to resolve customer issues for each support agent, considering different issue categories and urgency levels.

-- 38. Develop a stored procedure that accepts a date range and a specific project ID as input and retrieves all employee work hours dedicated to that project within the given period.

-- 39. Write a function that calculates the employee turnover rate for each department, considering the number of new hires and the number of departures over a specified time frame.

-- 40. Create a stored procedure that takes a location as an input parameter and returns the list of employees who have been involved in projects related to that location, along with their project contributions and performance ratings.

