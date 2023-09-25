use functions_sample;

-- question 1
select
CustomerName
,sum(SalesAmount) as Total_Sales
,dense_rank() over(order by sum(SalesAmount) desc) as 'Rank'
from functions_sample.sales_data
group by CustomerName
limit 5;

-- question 2
select
CustomerName
,sum(SalesAmount) as Total_Sales
,dense_rank() over(order by sum(SalesAmount)) as 'Rank'
from functions_sample.sales_data
group by CustomerName
limit 5;

-- question 3
select
ProductName
,sum(orderQty) as Total_quantity
from functions_sample.sales_data
group by ProductName
order by Total_quantity desc
limit 5;

-- question 4
with product_quantity as (
select
ProductName
,sum(orderQty) as Total_quantity
from functions_sample.sales_data
group by ProductName)
select * from product_quantity
where Total_quantity = (select min(Total_quantity) from product_quantity);

-- question 5
select
CustomerName
,count(SalesOrderID) as No_of_Orders
from functions_sample.sales_data
group by CustomerName
order by No_of_Orders desc
limit 5;

-- question 6
select
CustomerName
,count(SalesOrderID) as No_of_Orders
,dense_rank() over(order by count(SalesOrderID) desc) as 'Rank'
from functions_sample.sales_data
group by CustomerName
limit 10;

-- question 7
select
CustomerName
,count(SalesOrderID) as No_of_Orders
from functions_sample.sales_data
group by CustomerName
having No_of_Orders<5
order by No_of_Orders
limit 5;

-- question 8
select
date_format(OrderDate,'%Y/%m') as 'Year_Month'
,sum(SalesAmount) as Total_sales
from functions_sample.sales_data
group by 1
order by 1
limit 5;

-- question 9
with sales as (
select
date_format(OrderDate,'%Y/%m') as YearMonth
,sum(SalesAmount) as CurrentSalesAmount
from functions_sample.sales_data
group by 1)
select 
YearMonth
,CurrentSalesAmount
,lag (CurrentSalesAmount) over (order by YearMonth) as PreviousSalesAmount
,case
when 
CurrentSalesAmount > lag(CurrentSalesAmount) over(order by YearMonth) then 'Increase' else 'decrease'
end as Sales_Status
from sales
limit 10;

-- question 10
with Product as (
select
distinct CategoryName
,ProductName
,UnitPrice
,row_number() over (partition by CategoryName order by UnitPrice desc) as r_num_by_price
from functions_sample.sales_data )
select * from Product
where r_num_by_price=1;

