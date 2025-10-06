use joinhr;
show triggers;
show tables;

-- 1. How can MySQL triggers be used to automatically update employee records when a department is changed?


-- 2. What MySQL trigger can be used to prevent an employee from being deleted if they are currently 
-- assigned to a department?


-- 3. How can a MySQL trigger be used to send an email notification to HR when an employee is hired or terminated?


-- 4. What MySQL trigger can be used to automatically assign a new employee to a department based on their job title?
drop trigger auto_insert_emp;

delimiter $$
create trigger auto_insert_emp
before insert on employees
for each row
begin
	-- if(new.job_title=job_title) then
--     insert into employees values(new.employee_id,new.department_id);
    
    if job_title = 'IT' then set new.job_id = 'AD_PRES',new.department_id = 60;
    elseif job_title = 'Administration Vice President' 
    then set new.job_id = 'AD_VP', new.department_id = 100;
    else 
		signal sqlstate '45000'
        set message_text = 'invalid job title. correctwala job title dal.';
	end if;
end ;;
$$
delimiter ;

insert into jobs (job_id,job_title,min_salary,max_salary)
values ('AD_P','Administration Vice President',5000,450000);
select *from jobs;
select *from employees;

DELIMITER //

CREATE TRIGGER assign_department_by_jobtitle
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE dept_id INT;
    SELECT 
        CASE 
            WHEN JOB_TITLE = 'IT_PROG' THEN 10
            WHEN JOB_TITLE = 'HR_REP' THEN 20
            ELSE 30
        END
    INTO dept_id
    FROM jobs
    WHERE JOB_ID = NEW.JOB_ID;
    SET NEW.DEPARTMENT_ID = dept_id;
END;
//
DELIMITER ;




select *from jobs;
select * from departments;
select * from employees;
-- 5. How can a MySQL trigger be used to calculate and update the total salary budget for a department 
-- whenever a new employee is hired or their salary is changed?


-- 6. What MySQL trigger can be used to enforce a maximum number of employees that can be assigned to a department?


-- 7. How can a MySQL trigger be used to update the department manager whenever an employee under their 
-- supervision is promoted or leaves the company?


-- 8. What MySQL trigger can be used to automatically archive the records of an employee who has been 
-- terminated or has left the company?

