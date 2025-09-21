CREATE DATABASE new_db;
USE new_db;

create table date_1(
s_name varchar(20),
dob date);



insert into date_1 value('Sam', '2020-11-04');
insert into date_1 value('jam', '2020-11-21');
insert into date_1 value('dim', '2020-11-05');
SELECT * FROM date_1;



SELECT length(dob) from date_1;
INSERT into date_1 value("Sam", null);

CREATE table date_2(
s_name varchar(20),
dob date, birth_time time);

insert into date_2 value ('s', '2021-9-12' '23:09:22');
select * from date_2;



CREATE table date_3(
s_name varchar(20),
birth_date_time datetime);

insert into date_3 value('sam', '2021-9-12 12:09:22');
SELECT * FROM date_3;


CREATE table date_4(
s_name varchar(20),
login_time timestamp
);


insert into date_4 value ('sam', current_timestamp());

select * from date_4;	

create table date_5(
s_name varchar(20),
birth_year year);

insert into date_5 values('devansh','2001');

select* from date_5;


select now();

select current_time() as curr_time;

CREATE table student_uk(s_name varchar(20),
age int, email varchar(100) UNIQUE
);


INSERT into student_uk value('SAM', 24, 'shubham@gmail.com');
INSERT into student_uk value('Samay',26, 'shubham@gmail.com');

drop table student_uk1;
CREATE TABLE student_uk1(email varchar(100), age int,
mobile_no int(10),
unique(email, mobile_no));

insert into student_uk1 value('SAM', 24, 'abc@gmail.com', 099999);
insert into student_uk1 value('SAM', 24, 'abc@gmail.com', 099999);


create table student_UK2(
s_name varchar(20),
username varchar(10) unique,
age int, email varchar(100), mobile_no int(10),
unique(email,mobile_no)
);


insert into student_uk2 value('Nilesh', 'NK', 24, 'nk@gmail.com',12345);
insert into student_uk2 value('Nilesh', 'NK', 24, 'nk@gmail.com',12345);


CREATE TABLE employee_UK1(
emp_name varchar(20), 
usernmae varchar(10)unique not null, age int, dept_id int);

insert into employee_UK1 value('Leo', 'abc', 45, 501);
insert into employee_UK1 value('Leo', NULL, 45, 501);


create table employee_UK3
(emp_name varchar(20) not null, 
u_email varchar(10) unique,
email varchar(10) not null,
alter_email varchar(10),
unique(email,alter_email));


