use joinhr;
-- Ranking Functions:
select *from employees;
select *from departments;

-- 1. Find the top 3 highest paid employees in each department using RANK().
with rankemployees as(
	select concat(e.first_name,' ',e.last_name)as full_name, e.employee_id,
    e.salary,d.DEPARTMENT_NAME,d.department_id, rank()
    over(partition by d.department_id order by e.salary desc)as salary_rank 
    from employees e
    join departments d
    on e.DEPARTMENT_ID=d.DEPARTMENT_ID
)  
select department_id,DEPARTMENT_NAME,employee_id,salary,full_name,salary_rank
from rankemployees
where salary_rank <=3
order by department_name,salary_rank;

select * from employees where DEPARTMENT_ID=90 ;
-- 2. Assign a unique row number to each employee within their department using ROW_NUMBER() 
-- based on salary descending.
select department_id,employee_id,concat(first_name,' ' ,last_name)as full_name,Salary,row_number() 
over(partition by DEPARTMENT_ID order by SALARY desc)as row_no
from employees ;

select department_id,employee_id ,count(*)
from employees 
where DEPARTMENT_ID=90
group by department_id,employee_id;

-- 3. List departments where at least two employees share the same salary rank using DENSE_RANK().
select *from departments;
WITH RankedSalaries AS (
    SELECT Employee_ID,concat(first_name,' ' ,last_name)as full_name,Department_ID,Salary,
	DENSE_RANK() OVER (PARTITION BY Department_ID ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
),
DuplicateRanks AS (
    SELECT Department_ID,SalaryRank,COUNT(*) AS RankCount
    FROM RankedSalaries
    GROUP BY Department_ID, SalaryRank
    HAVING COUNT(*) >= 2
)
SELECT DISTINCT d.Department_ID,ds.department_name
FROM DuplicateRanks d join departments ds on d.department_id=ds.department_id;

-- 4. Divide employees into 4 equal salary groups using NTILE(4) and display the group number 
-- along with employee details.
SELECT NTILE(4) OVER (ORDER BY salary) AS salary_group,
employee_id,concat(first_name,' ' ,last_name)as full_name,salary,department_id
FROM employees;



-- 5. Find the top 3 highest paid employees in each department using RANK().


-- 6. Assign a unique row number to each employee within their department using ROW_NUMBER() based on salary descending.


-- 7. List departments where at least two employees share the same salary rank using DENSE_RANK().


-- 8. Divide employees into 4 equal salary groups using NTILE(4) and display the group number along with employee details.
