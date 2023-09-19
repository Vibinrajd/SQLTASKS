create schema sales;
use sales;

-- creating 3 tables
-- 1) Customer Table
create table sales.customer(
CustomerID int primary key not null,
Email varchar(30) unique not null,
Address text,
Phone char(10) not null,
Age smallint not null,
DOB date
);

-- 2) Product Table
create table sales.product(
ProductID int primary key auto_increment,
ProductName varchar(255) not null,
Price decimal(10,2) not null check (Price>0),
Description text,
Category_or_Product_Type varchar(255) not null
);

-- 3) Orders Table
create table sales.orders(
OrderID int primary key auto_increment not null,
CustomerID int not null,
ProductID int not null,
OrderDate timestamp not null default current_timestamp,
Status varchar(20) not null,
ShippingAddress text,
PaymentMethod varchar(30) not null,
PaymentStatus varchar(20) not null,
ShippingMethod varchar(30) not null,
TrackingNumber varchar(50) ,
Notes text
);

-- applying Foreign key
alter table sales.orders add constraint fk_CustomerID foreign key (CustomerID) References customer(CustomerID);
alter table sales.orders add constraint fk_ProductID foreign key (ProductID) References product(ProductID);

-- inserting values
-- 1) Customer Table
INSERT INTO sales.customer (CustomerID, Email, Address, Phone, Age, DOB) VALUES
(1001, 'customer1@gmail.com', '123 Main Street', '6541265556', 30, '1993-08-04'),
(1002, 'customer2@gmail.com', '456 East Street', '9876543210', 25, '1998-09-15'),
(1003, 'customer3@gmail.com', '789 South Street', '4563217890', 20, '2003-10-26');


-- 2) Product Table
INSERT INTO sales.product ( ProductName, Price, Description, Category_or_Product_Type) VALUES
( 'Laptop', 1000.00, 'A laptop computer with a 15.6-inch display, Intel Core i5 processor, and 8GB of RAM.', 'Electronics'),
( 'Smartphone', 500.00, 'A smartphone with a 6.5-inch display, Snapdragon 8 Gen 1 processor, and 128GB of storage.', 'Electronics'),
( 'Television', 750.00, 'A 55-inch television with 4K resolution and HDR support.', 'Electronics'); 

-- Orders Table
INSERT INTO sales.orders (CustomerID, ProductID, OrderDate, Status, ShippingAddress, PaymentMethod, PaymentStatus, ShippingMethod, TrackingNumber, Notes) VALUES
(1001, 1, CURRENT_TIMESTAMP, 'New', '123 Main Street', 'Credit card', 'Pending', 'FedEx Ground', '1234567890', 'None'),
(1002, 2, CURRENT_TIMESTAMP, 'Shipped', '456 East Street', 'PayPal', 'Paid', 'USPS Priority Mail', '9876543210', 'None'),
(1003, 3, CURRENT_TIMESTAMP, 'Cancelled', '789 South Street', 'Debit card', 'Refunded', 'UPS Ground', NULL, 'Order cancelled by customer');


select*from sales.customer;

select*from sales.product;

select*from sales.orders;
