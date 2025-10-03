-- triggers


delimiter $$
create trigger before_insert_into_employee
before insert on employee
for each row
begin
	-- new === this take new value 
    -- old == this take old values in the table
    if new.salary is null then
		set new.salary=15000.0;
	end if;
    
end $$
delimiter ;

drop trigger before_insert_into_employee;
select * from  employee;
 
INSERT INTO employee (employee_id, name,  department_id)
VALUES(7, 'shubham Smith', 101);

--
use hr;
delimiter $$
create trigger before_insert_into_employee1
before insert on employees
for each row
begin
	-- new === this take new value 
    -- old == this take old values in the table
    if new.salary = 15000.0 then
		set new.salary = NULL;
	end if;
    
end;;
$$
delimiter ;

select * from employees;
--

delimiter $$
create trigger before_insert_into_employee_eg2
before insert on employee
for each row
begin
	
    if new.department_id is null then
		set new.department_id=100;
	end if;
    
end;;
$$
delimiter ;



-- Create a logging table to store the messages
CREATE TABLE employee_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_message VARCHAR(255),
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from employee_log;

-- Create the trigger to log messages after employee insertions



DELIMITER $$


CREATE TRIGGER after_employee_insert
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    -- Insert the message into the logging table
    INSERT INTO employee_log (log_message)
    VALUES (CONCAT('A new employee has been inserted with ID: ', NEW.employee_id));
END;
$$


DELIMITER ;
INSERT INTO employee (employee_id, name, salary)
VALUES (10, 'John Doe', 50000.00);


select * from employee;
select * from employee_log;

DELIMITER $$
create trigger after_employee_insert
after insert on employee
for each row 
begin 
	insert into employee_log (log_message)
    values (concat('new employee inserted with id: ', NEW.employee_id));
END;

DELIMITER ;;

INSERT INTO employee (employee_id, name) VALUES (101, 'shubham');



create table employee_email_log(
log_id int auto_increment primary key,
log_message varchar(255),
log_timestamp timestamp default current_timestamp
);


create table employee_emails(
emp_id int,
email varchar(100)
created_date timestamp default current_timestamp
);
