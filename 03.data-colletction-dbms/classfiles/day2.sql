create database datatype_lab;
use datatype_lab;
create table char_1(s_name char(5), s_id int);
insert into char_1 value('Radha', 10);
insert into char_1 value('Raaadha', 10);
CREATE TABLE char_2(s_name char(256), s_id int);

SELECT length(s_name) from char_1;


create table varchar_1(s_name varchar(5), s_id int);
INSERT into varchar_1 value('Radha',10);
select * from varchar_1;

select * from assignment1;


CREATE TABLE blob_ex(tag varchar(10), img blob);

desc blob_ex;
insert into blob_ex value('cat inage', '/Users/proxim/Desktop/1.png');
SELECT * FROM blob_ex;

INSERT into blob_ex value('img12', load_file('/Users/proxim/Desktop/2.png'));

SELECT * FROM blob_ex;

create table text_ex(tag varchar(10), about text);
insert into text_ex value("about art", "This page shares my best articles to read on topics like
health, happiness, creativity, productivity and more. The
central question that drives my work is, How can we live
better? To answer that question, I like to write about
science-based ways to solve practical problems.
Youll find interesting articles to read on topics like how
to stop procrastinating as well as personal
recommendations like my list of the best books to read
and my minimalist travel guide. Ready to dive in? You
can use the categories below to browse my best articles.");

SELECT * from text_ex;

SELECT length(about) as no_of_byte from text_ex;



CREATE table set_ex(order_id int,
	c_name varchar(20),
    food_type set('veg', 'medium spicy', 'no onion', 'no garlic'));
    
    
    
    
    
    
    
    
    
    
insert into set_ex value(11,'sai', 'veg');
insert into set_ex value(11,'sai', 'veg', 'spicy');
insert into set_ex value(11,'sai','veg, spicy');


SELECT * from set_ex;






create table job_interview(
app_name varchar(50), resume_upload blob, contact_me set('Phone Number', 'email', 'text Message', 'Letter'));



INSERT INTO job_interview 
VALUES(
    'Sai',
    LOAD_FILE('/Users/proxim/Desktop/1.png'), 
    'Phone Number,email,text Message'
);


CREATE table from_app(app_name varchar(50), course_type varchar(10), gender enum('Male','Female','Others'));

insert into from_app values('sanam','dbda','female');

SELECT * FROM from_app;




SELECT * FROM job_interview;


CREATE table hostel_students(stud_name varchar(50), seat_type char(5),
	gender enum('Male', 'Female', 'Others'), hobbies_desc TEXT,
    contact_desc SET('Phone', 'mobile', 'landline'), photo BLOB);

INSERT INTO hostel_students
(stud_name, seat_type, gender, hobbies_desc, contact_desc, photo)
VALUES
("Shubham", "201-B", "Male", "He is very well versed playing the basketball and other sports and can compete in inter-hostel an outer hostel leagues", "mobile",
load_file('/path/to/secure/folder/2.png'));


CREATE table numeric_examples(
student_id int, student_name varchar(50),
age int);

select length(age) as age_len, length(student_id) as len_st_id from numeric_examples;

insert into numeric_examples values(123, 'sai', 25);



