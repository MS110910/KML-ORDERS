create database Store;
use	Store;

create table OrderStore (
row_id serial primary key,
order_id varchar(50),
order_date text,
order_priority varchar(50),
order_quantity integer,
sales numeric,
discount numeric,
ship_mode varchar(100),
profit numeric, 
unit_price numeric,
shipping_cost numeric,
customer_name varchar(255),
province varchar(100),
region varchar(100),
customer_segment varchar(100),
product_category varchar(100),
product_sub_category varchar(100),
product_name text,
product_container varchar(100),
product_base_margin numeric,
ship_date text 
);
select * from orderstore limit 10;

SELECT product_category,
SUM(sales) AS Total_Sales
FROM orderstore
GROUP BY product_category
ORDER BY Total_Sales DESC
LIMIT 1;

SELECT region, 
SUM(Sales) AS Total_Sales
FROM orderstore
GROUP BY region
ORDER BY Total_Sales DESC
LIMIT 3;

SELECT region, 
SUM(Sales) AS Total_Sales
FROM orderstore
GROUP BY region
ORDER BY Total_Sales ASC
LIMIT 3;

SELECT SUM(Sales) AS
Total_appliances_sold_in_Ontario
FROM orderstore
WHERE Product_Sub_Category = 'Appliances' AND Province = 'Ontario';

SELECT Customer_Name,
SUM(Sales) AS Min_Total_Sales
FROM orderstore
GROUP BY Customer_Name
ORDER BY Min_Total_Sales ASC
LIMIT 10;

SELECT Ship_Mode, 
SUM(Shipping_Cost) AS Most_Shipping_Cost
FROM orderstore
GROUP BY Ship_Mode
ORDER BY Most_Shipping_Cost DESC 
LIMIT 1;

SELECT Customer_Name, 
SUM(Sales) AS Customer_Total_Sales
FROM orderstore
GROUP BY Customer_Name
ORDER BY Customer_Total_Sales DESC
LIMIT 5;

SELECT Customer_Name, product_category,
SUM(Sales) AS Customer_Total_Category_Sales,
COUNT(*) AS No_of_Orders_in_the_Category
FROM orderstore
WHERE Customer_Name IN ('Emily Phan', 'Deborah Brumfield', 'Roy Skaria', 'Sylvia Foulston', 'Grant Carroll')
GROUP BY Customer_Name, product_category
ORDER BY Customer_Name, Customer_Total_Category_Sales DESC;

SELECT Customer_Name, 
SUM(Sales) AS Customer_Total_Sales
FROM orderstore
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY Customer_Total_Sales DESC
LIMIT 1;

SELECT Customer_Name,
COUNT(order_id) AS Total_Orders_Placed
FROM orderstore
WHERE Customer_Segment = 'Corporate' AND order_date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY Customer_Name 
ORDER BY Total_Orders_Placed DESC
LIMIT 1;

SELECT Customer_Name,
SUM(profit) AS Customer_Total_Profit
FROM orderstore
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Customer_Total_Profit DESC
LIMIT 1;

CREATE TABLE OrderStatus (
order_id VARCHAR(50),
status VARCHAR(50)
);

SELECT * FROM OrderStatus;

SELECT DISTINCT O.Customer_Name, O.Customer_Segment
FROM orderstore AS O
JOIN OrderStatus AS OS ON O.Order_id = OS.Order_id
WHERE OS.status = 'Returned';

SELECT Order_Priority, Ship_Mode,
SUM(Shipping_Cost) AS Total_Priority_Shipping_Cost,
COUNT(Order_id) AS No_of_Priority_Orders_by_Ship_Mode
FROM orderstore
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority ASC, Total_Priority_Shipping_Cost DESC;
