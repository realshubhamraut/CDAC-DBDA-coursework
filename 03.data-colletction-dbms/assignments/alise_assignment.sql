-- Write a query to display EMPLOYEE_ID as ID, FIRST_NAME as First, and LAST_NAME as Last from the employees table.

select employee_id as id,first_name as last from employees;

-- Write a query to display JOB_ID as JobCode, JOB_TITLE as Title, and MIN_SALARY as MinimumSalary from the jobs table.
select job_id as jobcode , min_salary as minimumsalary;

-- Write a query to display the FIRST_NAME and LAST_NAME of employees from the employees table by using an alias e for the table.

select first_name , last_name from employees e;

-- Write a query to display the EMPLOYEE_ID and the full name (FIRST_NAME + ' ' + LAST_NAME as FullName) 
-- of employees, and sort the result by FullName in descending order.

select employee_id ,  (full_name," ",last_name) as fullname from employees   ;

-- Write a query to display EMPLOYEE_ID as ID, FIRST_NAME as Name, and SALARY as Income from the employees table for 
-- employees with a salary greater than 5000, using aliases for the columns


select employee_id as id , first_name as name , salary as income  from employees
where salary > 5000;



-- Write a query to display the EMPLOYEE_ID, FIRST_NAME, and DEPARTMENT_NAME from the employees 
-- and departments tables using aliases e for employees and d for departments.


select employee_id, first_name,department_name from employees e join departments d on e.department_is and d.department_id;

-- Write a query to display COUNTRY_NAME and REGION_NAME from the countries and regions tables, using aliases c for countries 
-- and r for regions, where the REGION_ID is greater than 2


select country_name , region_name  from countries c join regions r on c.location_id =r.location_id where region_id > 2; 


-- Write a query to display the FIRST_NAME and LAST_NAME of employees 
-- whose department name is "IT", using aliases e for employees and d for departments.

select first_name,last_name from employees e join departments d on e.department_id = d.department_id where department_name ="IT";


-- Write a query to display the average salary (AVG(SALARY) as AverageSalary) 
-- for each department using aliases for the departments and employees tables.


select avg(salary) as avgsalary from employees e join departments d on e.department_id=d.department_id ;


-- Write a query to display the REGION_NAME and the total number of countries in each region (as CountryCount), \
-- using aliases for both the countries and regions tables


select region_name and (sum(totle_countries)) as countrycount from countries c join regions r on c.location_id=r.location_id;











