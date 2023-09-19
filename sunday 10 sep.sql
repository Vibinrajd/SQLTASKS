
-- create a schema
create schema company;
drop schema company;
-- use a schema
use company;

-- show tables in schema
show tables;

-- creating a table
-- Syntax: create table schema_name.Table_name (col1 type,col2 type, col3 type, ....);

create table company.employee(id int,name varchar(10) ,designation varchar(20),doj date,salary double,phone_no bigint);

-- information schema
select * from information_schema.tables where table_schema = 'company' ;

-- information schema columns
select * from information_schema.columns where table_name = 'employee' and table_schema = 'company';

-- alter table
-- Syntax ALTER TABLE TABLE_NAME RENAME NEW_TABLE_NAME;
alter table company.employee rename emp;

select * from information_schema.columns where table_name = 'emp' and table_schema = 'company';

-- alter table columns
alter table company.emp rename column doj to Date_of_join;

-- insert
-- insert 1 record
insert into company.emp values(1,'Raja','Clerk','2023-09-10',1200.20,8667752115);

-- view data in table 
select * from company.emp;

-- insert more than 1 record
insert into company.emp(id,name,designation,Date_of_join,salary,phone_no)
 values(2,'Rani','Clerk','2023-09-10',1200.20,8667752115),
 (3,'Sita','Clerk','2023-09-10',1200.20,8667752115),
 (4,'Geeta','Clerk','2023-09-10',1200.20,8667752115),
 (5,'Ramesh','Clerk','2023-09-10',1200.20,8667752115);


-- view data in table 
select * from company.emp;

-- Update 
-- SYNTAX UPDATE table_name SET column_name condition (optional) WHERE col_name = ''' 

set sql_safe_updates = 0;

update company.emp set id = 9 where id = 2;

-- Update All data in a column
update company.emp set phone_no = 99999;

-- view data in table 
select * from company.emp;

-- delete
delete from company.emp where id = 9;
select * from company.emp;

-- select to display all data
-- * ==> all
select * from company.emp;

-- particular columns
select id,Date_of_join,salary from company.emp;
 
delete from company.emp where id in (1,4);

-- truncate table
truncate table company.emp;

-- imp interview question(
--             Truncate      	Drop	  Delete
--               DDL	        DDL	       DML
-- Execution	Table	       Table	   Row
-- TCL	       No Rollback	No Rollback	   Rollback )


-- TCL Language

select * from company.emp;
start transaction;
insert into company.emp values(13,'Raja','Clerk','2023-09-10',1200.20,8667752115);
commit;
rollback;

set autocommit = 1;