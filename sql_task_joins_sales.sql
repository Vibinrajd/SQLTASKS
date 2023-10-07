-- Find total sales done by a customer order by salesAmount
select
c.FullName Customer_Name,
round(sum(o.OrderQty * o.UnitPrice),1) SalesAmount
from sales.orders o
join sales.customers c
on o.CustomerID = c.CustomerID
group by 1
order by 2 desc;

-- Find catagory wise sales amount 
select
pc.CategoryName,
round(sum(o.UnitPrice*o.OrderQty),1) SalesAmount
from sales.orders o
join sales.products p
on o.ProductID = p.ProductID
join sales.productsubcategories ps
on p.SubCategoryID = ps.SubCategoryID
join sales.productcategories pc
on ps.CategoryID = pc.CategoryID
group by 1
order by 2 desc;

-- Which Employee has made more number of sales
select
e.FullName Employee,
round(sum(o.UnitPrice*o.OrderQty),1) SalesAmount
from sales.orders o
join sales.employees e
on o.EmployeeID = e.EmployeeID
group by 1
order by 2 desc
limit 5;

-- which product was ordered most number of times
select
p.ProductName,
count(distinct o.SalesOrderID) TotalOrders 
from sales.orders o
join sales.products p
on o.ProductID = p.ProductID
group by 1
order by 2 desc
limit 5;

-- Additional Practice Question

-- Find total orders by category,subcategory
-- Find the sales made by the female employees
-- Find the sales made by the vendor
-- Find the sales made by the manager
-- Find the distinct product brought by the customers
-- Find top 5 customer who made more number of orders
-- Find top  product of a vendor based on orderQuantity


-- Find total orders by category,subcategory
select
ps.SubCategoryName,
pc.CategoryName,
count(distinct o.SalesOrderID) TotalOrders
from sales.orders o
join sales.products p
on o.ProductID = p.ProductID
join sales.productsubcategories ps
on p.SubCategoryID = ps.SubCategoryID
join sales.productcategories pc
on ps.CategoryID = pc.CategoryID
group by 1,2
order by 3;

-- Find the sales made by the female employees
select
e.FullName,
e.Gender,
count(distinct o.SalesOrderID) TotalSales,
round(sum(o.OrderQty*o.UnitPrice),1) salesAmount
from sales.orders o
join sales.employees e
on o.EmployeeID = e.EmployeeID
group by 1,2
having e.Gender = 'F'
order by 4;

-- Find the sales made by the vendor
select
v.VendorName,
round(sum(o.OrderQty*o.UnitPrice),1) SalesAmount
from sales.orders o
join sales.vendorproduct vp
on o.ProductID = vp.ProductID
join sales.vendors v
on vp.VendorID = v.VendorID
group by 1
order by 2 desc;

-- Find the sales made by the manager
with sales as (
select
e.ManagerID,
e.FullName ManagerName,
round(sum(o.OrderQty*o.UnitPrice),1) SalesAmount
from sales.orders o
join sales.employees e
on o.EmployeeID = e.EmployeeID
group by 1,2
order by 3 desc)
select ManagerName, SalesAmount from sales;

-- Find the distinct product brought by the customers
select
p.ProductName,
count(distinct c.CustomerID) Products_Sold
from sales.products p
join sales.orders o
on p.ProductID = o.ProductID
join sales.customers c
on o.CustomerID = c.CustomerID
group by 1
order by 2 desc;

-- Find top 5 customer who made more number of orders
select 
c.FullName CustomerName,
count(o.SalesOrderID) No_of_Orders
from sales.orders o
join sales.customers c
on o.CustomerID = c.CustomerID
group by 1
order by 2 desc
limit 5;

-- Find top  product of a vendor based on orderQuantity
with sales as (
select
v.VendorName,
p.ProductName,
sum(o.OrderQty) OrderQuantity
from sales.products p
join sales.orders o
on p.ProductID = o.ProductID
join sales.vendorproduct vp
on o.ProductID = vp.ProductID
join sales.vendors v
on vp.VendorID = v.VendorID
group by 1,2
order by 1 asc, 3 desc)
select * from sales
where (vendorName,OrderQuantity) in (select vendorName,max(OrderQuantity) 
from sales 
group by 1 );