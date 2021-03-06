CREATE database Superstore;

use Superstore;

Create table cust_dimen(
    Customer_Name varchar(25) not null,
    Province varchar(25) not null,
    Region varchar(25) not null,
    Customer_Segment varchar(25) not null,
    Cust_id varchar(25) not null);
    select * from cust_dimen;

Create table market_fact(
	Ord_id varchar(25) not null,
    Prod_id varchar(25) not null,
    Ship_id varchar(25) not null,
    Cust_id varchar(25) not null,
    Sales int not null,
    Discount decimal not null,
    Order_Quantity tinyint not null,
    Profit smallint not null,
    Shipping_Cost numeric not null,
    Product_Base_Margin numeric null);
    SELECT * from market_fact; 

Create table orders_dimen(
	Order_ID int not null,
    Order_Date date not null,
    Order_Priority varchar(25) not null,
    Ord_id varchar(25) not null);
    select * from orders_dimen;
    
Create table prod_dimen(
	Product_Category varchar(25) not null,
    Product_Sub_Category varchar(30) not null,
    Prod_id varchar(25) not null);
Select * from prod_dimen;

Create table shipping_dimen(
	Order_ID int not null,
    Ship_Mode varchar(25) not null,
    Ship_Date date not null,
    Ship_id varchar(25) not null);
    select * from shipping_dimen;
    
/*1.Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen.*/
select Customer_Name  as `Customer Name`,
    Customer_Segment as `Customer Segment`
	from superstore.cust_dimen;
    
/*2.Write a query to find all the details of the customer from the table cust_dimen order by desc.*/
select * from superstore.cust_dimen
order by 1 desc;

/*3.Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.*/
select Order_ID , Order_Date 
from superstore.orders_dimen 
where Order_Priority = 'HIGH';

/*4.Find the total and the average sales (display total_sales and avg_sales)*/
select sum(Sales) as total_sales,avg(Sales) as avg_sales 
from superstore.market_fact;

/*5.Write a query to get the maximum and minimum sales from maket_fact table.*/
select max(Sales) as max_sale,min(Sales) as min_sale
from superstore.market_fact;

/*6.Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers.*/
select Region,count(Customer_Name) as 'Number_of_Customers' 
from superstore.cust_dimen 
group by Region 
order by count(Customer_Name) desc;

/*7.Find the region having maximum customers (display the region name and max(no_of_customers)*/
select Region,count(customer_name) as 'Number_of_Customers' 
from superstore.cust_dimen 
group by Region 
order by count(Customer_Name) desc limit 1 ;

/*8.Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased)*/
select Customer_Name, count(*) as num_tables 
from superstore.market_fact s, superstore.cust_dimen c, superstore.prod_dimen p     
where s.Cust_id = c.Cust_id and s.Prod_id = p.Prod_id and 
p.Product_Sub_Category = 'TABLES' and c.Region = 'ATLANTIC'     
group by Customer_Name;

/*9.Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners)*/
select Customer_Name,count(*) as `no of small business owners` 
from superstore.cust_dimen 
where Customer_Segment = 'SMALL BUSINESS' and Province = 'ONTARIO'
group by Customer_Name;

/*10.Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold) */
select Prod_id,count(*) 
as `no_of_products sold` 
from superstore.market_fact 
group by Prod_id 
order by count(`no_of_products sold`) desc;

/*11.Display product Id and product sub category whose produt category belongs to Furniture and Technlogy. The result should contain columns product id, product sub category.*/
select Prod_id,Product_Sub_Category 
from superstore.prod_dimen
where Product_Category='FURNITURE' 
or Product_Category='TECHNOLOGY'
group by Prod_id;

/*12.Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?*/
select Product_Category,Profit 
from superstore.market_fact s,superstore.prod_dimen p
where s.Prod_id = p.Prod_id
group by Product_Category 
order by Profit desc;

/*13.Display the product category, product sub-category and the profit within each subcategory in three columns.*/
select Product_Category,Product_Sub_Category,Profit 
from superstore.market_fact s,superstore.prod_dimen p
where s.Prod_id = p.Prod_id;

/*14.Display the order date, order quantity and the sales for the order.*/
select Order_Date,Order_Quantity,Sales 
from superstore.market_fact s, superstore.orders_dimen c
where s.Ord_id = c.Ord_id;

/*15.Display the names of the customers whose name contains the 
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’*/
select Customer_Name 
from superstore.cust_dimen 
where Customer_Name 
like '_R%' and 
Customer_Name like '___D%'; 

/*16.Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000.*/
select 	c.Cust_id,s.Sales,c.Customer_Name,c.Region 
from superstore.market_fact s,superstore.cust_dimen c
where s.Cust_id = c.Cust_id 
and Sales between 1000 and 5000;

/*17.Write a SQL query to find the 3rd highest sales.*/
select min(Sales) as `3rd highest salary` 
FROM (  
select Sales 
from superstore.market_fact 
order by Sales desc limit 3
 ) as a;
 
/*18.Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, display the region-wise no_of_shipments and the profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region)
 → Note: You can hardcode the name of the least profitable product subcategory.*/
select Region,count(Ship_id) as no_of_shipment,sum(Profit) as profit_in_each_region 
from superstore.cust_dimen c,superstore.market_fact s,superstore.prod_dimen p
where c.Cust_id = s.Cust_id and s.Prod_id = p.Prod_id
group by Region
order by profit_in_each_region asc; 




