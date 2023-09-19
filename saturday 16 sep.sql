create schema data_types;

use data_types;
-- json drop table data_typesemployees;

create table data_types.employees(
employeeID int primary key,
employeeName varchar(50),
employeeInfo json );

-- insert JSON data into table
insert into data_types.employees ( employeeID, employeeName, employeeInfo ) values 
( 1, 'john' , '{"Department":"HR", "salary":50000, "Skills":["Communication","Problem Solving"]}');

select employeeID, employeeName, employeeInfo->>'$.Department' as Department
, employeeInfo->>'$.Skills[0]' as Skill_1
, employeeInfo->>'$.Skills[1]' as Skill_2 
from data_types.employees;


-- CONSTRAINTS 
create schema constrains;
use constrains;

create table constrains.student(rollNo int primary key
, DOB date
, StudentName varchar(20)
, is_adult boolean
, Gender enum ('Male','Female')
, DeptId int );

select*from information_schema.columns where table_name = 'student' and table_schema = 'constrains_sample';

select*from constrains;


insert into sales.orders(OrderID,CustomerID,ProductID,OrderDate, Status
,ShippingAddress, PaymentMethod, PaymentStatus, ShippingMethod, TrackingNumber
,Notes) values ( 1, 1001, 12345, '2023-09-19', 'New', '123 Main Street', 'Credit card', 'Pending', 'FedEx Ground', '1234567890', 'None'),
(2, 1002, 54321, '2023-09-19', 'Shipped', '456 Elm Street', 'PayPal', 'Paid', 'USPS Priority Mail', '9876543210', 'None'),
(3, 1003, 67890, '2023-09-19', 'Cancelled', '789 Oak Street', 'Debit card', 'Refunded', 'UPS Ground', 'None', 'Order cancelled by customer' );
