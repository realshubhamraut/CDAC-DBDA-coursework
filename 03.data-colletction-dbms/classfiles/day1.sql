USE keys_learn;
CREATE table customer(
	c_id int primary key,
    c_name varchar(30)
);

CREATE table orders(
	o_id int primary key,
    o_type varchar(20),
    c_id int,
    amt int,
    foreign key(c_id) references customer(c_id)
);

INSERT INTO customer value(1,"shubham");
insert into customer value(2,"Payal");



insert into orders value(111,"Business", 1, 100);
insert into orders value(112, "home", 1, 1000);
insert into orders value(113, "office", 2, 1399);


CREATE table orders1

SELECT * FROM orders;


CREATE table customer1(
	c_id int primary key, 
    c_name varchar (30)
);

create table order1(
	o_id int, 
    o_type varchar(50),
    c_id int, 
    amt int, 
    foreign key(c_id) references customer1(c_id)
);


CREATE table department(
d_id int primary key,
dept_name varchar(50)
);


create table employee(
emp_id int primary key,
emp_name varchar(20),
d_id int, foreign key (d_id) references department(d_id)
on delete set null
);


select * from department;
desc department;

use keys_learn;
create table department;

insert into department values(1, "Shubham");
insert into department values(2, "Payal");


update department set dept_name="IT/ENGG" WHERE d_id = 1;
update department set dept_name="SCIENCE" WHERE d_id = 2;





insert into employee values(1,"manager");
