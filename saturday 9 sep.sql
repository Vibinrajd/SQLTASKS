create database college;

create table college.student (id int, name varchar(20));

insert into college.student value(1, "Raja");

select * from college.student;

drop table college.student;

drop schema college;