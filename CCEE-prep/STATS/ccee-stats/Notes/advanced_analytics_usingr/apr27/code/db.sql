-- create table
create table weather (
    id integer primary key auto_increment,
    dayOfWeek varchar(10),
    date varchar(10),
    highTemperature int,
    lowTemperature int,
    precipitation int
);