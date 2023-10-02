-- Case Study #1 - SushiLand

use sushiland;

-- 1. What is the total amount each customer spent at the restaurant?

select 
  s.Customer_Id
, sum(m.Price) Total_amount
from sushiland.sales s
join sushiland.menu m
on s.Product_Id = m.Product_ID
group by 1;

-- 2. How many days has each customer visited the restaurant?
select 
Customer_Id
, count(distinct s.Order_Date) 'No.of.Days Visited'
from sushiland.sales s
group by 1;


-- 3. What was the first item from the menu purchased by each customer?
select 
s.Customer_Id
, s.Order_Date
, m.Product_Name
from sushiland.sales s
join sushiland.menu m
on m.Product_ID = s.Product_Id
where 
	s.OrderId in ( select min(s.orderID) 
		from sushiland.sales s 
		group by s.Customer_Id)
order by 1;
  
--  4. What is the most purchased item on the menu and how many times was it purchased by all customers?

select 
m.Product_Name
, count(s.Product_ID) 'no.of.orders'
from sushiland.menu m
join sushiland.sales s
on s.Product_Id = m.Product_ID
group by 1;


--  5. Which item was the most popular for each customer?

with No_of_orders as (
select
s.Customer_Id
, m.Product_Name
, count(m.Product_ID) No_of_Orders
, dense_rank() over (partition by s.Customer_Id order by count(s.Customer_Id) desc) as Rnk
from sushiland.sales s
join sushiland.menu m
on s.Product_Id = m.Product_ID
group by 1,2 )
select Customer_Id
, Product_Name
, No_of_Orders
 from No_of_orders
where Rnk = 1;

-- 6. Which item was purchased first by the customer after they became a member?

with member_timeline as (
select 
mem.Customer_Id
, mem.Join_Date
, s.Order_Date
, s.Product_Id
, dense_rank() over(partition by s.Customer_Id order by s.Order_Date,s.OrderId) order_rank
from sushiland.members mem
join sushiland.sales s
on mem.Customer_Id = s.Customer_Id
where s.Order_Date >= mem.Join_Date
order by 1,3
)
select
Customer_Id
, Join_Date
, Order_Date
, Product_Name
from member_timeline mt
join sushiland.menu m
on mt.product_id = m.Product_ID
where mt.order_rank = 1
order by 1;

-- 7. Which item was purchased just before the customer became a member?

select 
mem.Customer_Id
, mem.Join_Date
, s.Order_Date
, m.Product_Name
from sushiland.members mem
join sushiland.sales s
on mem.Customer_Id = s.Customer_Id
join sushiland.menu m
on s.Product_Id = m.Product_ID
where mem.Join_Date < s.Order_Date
limit 10 ;


-- 8. What is the total items and amount spent for each member before they became a member?

select 
	mem.Customer_Id
    ,count(s.Order_Date) as Total_items
    ,sum(m.Price) as total_spent
from sushiland.members mem
join sushiland.sales s
on mem.Customer_Id = s.Customer_Id
join sushiland.menu m
on s.Product_ID = m.Product_ID
where mem.Join_Date > s.Order_Date
group by 1
order by 1;

-- Bonus Question: Join All The Things!  
-- (Re)create the table with customer id, order date, product name, product price, and Y/N on whether the customer was a member when placing the order.

select 
s.Customer_Id
, s.Order_Date
,m.Product_Name
,m.Price
, case
	when s.Order_Date >= mem.Join_Date then 'Yes'
    else 'No'
    end 'member'
from sushiland.sales s
left join sushiland.menu m
on s.Product_Id = m.Product_ID
left join sushiland.members mem
on s.Customer_Id = mem.Customer_Id
order by 1,2
limit 10;