Use Project;

select count(*) from transactions; 
select count(*) from products ;
select count(*) from customers ;

select * from transactions; 
select * from products ;
select * from customers ;

-- TOPIC : customer Loyalty and Retail Sales insights 

-- Title : Total Sales and Transactions over time 
-- Aim : To determine the Total Sales and Number of transactions per month 
select 
  date_format(date, '%Y-%m') As Month,
  Count(transaction_id) as total_transactions,
  sum(total_price) as total_sales 
  from transactions
  group by month 
  order by month ;
  
  -- Title : Top 10 Best Selling Product 
  -- Aim : To know the Product with the highest sales Volumn
  select p.product_name ,
	p.category, 
    sum(t.quantity) as total_unitsold,
    sum(t.total_price) as total_sales
    from transactions t 
    join products p on t.product_id = p.product_id
    group by p.product_id, p.product_name, 
    p.category 
    order by total_unitsold Desc 
    Limit 10;
     
-- Title : Sales by product Category 
-- Aim : To know how each product Category Performs
select 
  p.category, 
  count(t.transaction_id) as Number_of_Transaction,
  sum(t.quantity) as total_quantity_sold, 
  sum(t.total_price) as total_sales 
  from transactions t 
  join products p On t.product_id = p.product_id 
  group by p.category 
  order by total_sales Desc ;
  
  -- Title : Customer Loyalty Impact On Revenue
  -- Aim : To know if loyalty tiers influence how much customer Spend 
  select 
    c.loyalty_status, 
    count(Distinct t.customer_id)AS Number_of_customers,
    Sum(t.total_price) as total_sales ,
    round(Avg(t.total_price), 2 ) as Avg_purchase_Value
    from transactions t 
    join customers c on t.customer_id = c.customer_id
    group by c.loyalty_status
    order by total_sales desc ;
    
    -- Title: Most Active Cities ( customer Locations )
    -- Aim: to know which cities has the higest number of transactions
    select 
      c.location As City ,
      count(t.transaction_id) as total_transactions ,
      sum(t.total_price) as total_sales 
      from transactions t 
      join customers c on t.customer_id = c.customer_id
      group by c.location 
      order by total_transactions Desc 
      Limit 10 ;
      
  -- Title: Discount Impact Analysis 
  -- Aim : To know pattern between discount size and total sales 
  select 
     discount, 
     count(transaction_id) as transaction_count,
     sum(total_price) As Total_sales, 
     round(Avg(total_price), 2) As Avg_sale_Value 
     from transactions 
     group by discount 
     order by discount ;

-- Title: High Value Customers ( Top 10 by lifetime Spend )
-- Aim :  To Know Customers who spent the Most Overall 
select 
   c.customer_id,
   c.name,
   c.loyalty_Status, 
   Sum(t.total_price) As Total_Spent,
   count(t.transaction_id) as total_transactions
   from transactions t 
   join customers c on t.customer_id = c.customer_id
   group by  c.customer_id,
   c.name,
   c.loyalty_Status 
   order by total_spent Desc
   Limit 10; 
   
   -- Title: Average Other Size By Payment Method  
   -- Aim : TO Determine what the average value per payment method is!
   select 
      Payment_Method ,
      Count(transaction_id) AS Nunber_of_orders ,
      round(avg(total_price), 2 ) AS Avg_order_value ,
      sum(total_price) as total_sales 
      from transactions 
      group by payment_method 
	  Order by Avg_order_value Desc ;
      
 -- Title:  Cross Category Performance Summary 
 -- Aim : To Combine Product Category and Customer Loyalty Level
 select 
     p.category ,
     c.loyalty_status, 
     sum(t.total_price) as Total_Sales ,
     Count(t.transaction_id) as total_orders 
     from transactions t 
     join products p on t.product_id = p.product_id
     join customers C ON t.customer_id = c.customer_id
     group by  p.category ,
     c.loyalty_status
     order by p.category, total_sales Desc;
     
-- Title: Customer Lifetime Value   
-- Aim: TO Identify high LTV customers value for targetting and retention
    select 
    c.customer_id,
     C. name ,
     round(sum(t.total_price), 2) as lifetime_Value, 
     count(t.transaction_id) as num_purchases 
     from transactions t
     join customers c on t.customer_id = c.customer_id 
     group by c.customer_id,
     C. name 
     order by lifetime_value Desc
     limit 10 ;
    
    
   