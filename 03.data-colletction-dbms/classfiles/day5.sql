create table emp_primary(
s_id int,
s_name varchar(20),
email varchar(20) primary key
);

alter table emp_primary modify column s_id int not null unique;
alter table emp_primary add index(s_id);
show indexes from emp_primary;

desc emp_primary;

ALTER table emp_primary drop primary key;
alter table emp_primary add primary key (s_id, email);
desc emp_primary;


create table employee_1(
emp_id int,
emp_name varchar(23),
dep varchar(23));


insert into employee_1 VALUES (1,'wislon','IT');


create table emp_tmp as select * from 
use 
select * from employees;
use hr;


create table emp_tmp as select * from employee;


select * from emp_tmp;

alter table employee add column salary int;




show databases;
drop table emp_temp;
create table emp_temp as select * from employees;
select * from emp_temp;

SET SQL_SAFE_UPDATES = 0;

update emp_temp set salary = 5000 where employee_id = 100;

update emp_temp set first_name = 'SAM' where employee_id = 104;

update emp_temp set department_id=20, manager_id=100 where employee_id = 104;


update emp_temp set salary = salary *1000 where salary <1000000;
alter table emp_temp modify salary BIGINT;


show create table emp_temp;



update emp_temp set first_name ='SAM' where employee_id = 104;
update emp_temp set manager_id  = 90 where job_id ='AD_VP' and department_id = 90;


select manager_id, department_id from emp_temp
WHERE department_id IN (90,60,30,100);



update emp_temp set manager_id = 70 WHERE department_id IN (90, 60, 30, 100);

delete from emp_temp where department_id = 19;

delete from emp_temp where salary > 100000;

delete from emp_temp where salary BETWEEN 40000 AND 100000;

rename table emp_temp to employee_temp_table;

update employee_temp_table set last_name ='' where employee_id = 100;
show tables;

show tables;

select * from employees
order by salary;

select salary, salary*100 as incremented_salary from employees;


create table t_emp as (select salary, salary*100 increment from employees);
select * from t_emp;


select employee_id, concat(first_name, last_name) as full_name from employees;

select employee_id, concat(first_name, '', last_name) as full_name, salary, salary*100 increment, year(hire_date) hire_year from employees;

select e.employee_id, concat(e.first_name,' ', e.last_name) full_name from employees e;

SELECT salary, (incremented_salary - salary) as diff_in_salary from employees
WHERE incremented_salary in (SELECT salary, salary*100 as incremented_salary);





SELECT salary, (incremented_salary - salary) as diff_in_salary from employees
WHERE incremented_salary in (SELECT salary, salary*100 as incremented_salary)]




