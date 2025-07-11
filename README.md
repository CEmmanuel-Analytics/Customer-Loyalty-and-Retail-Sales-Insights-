# Customer Loyalty and Retail Sales Insights Using MySQL and PowerBI 

This Project focuses on analyzing retail Sales and Customer loyalty Behaviour 
using a relational Database. I used **Mysql** for data quering and **PowerBI**
For Creating an interactive Dashboard. The Dataset consist of three related tables:
`Customer`,`Product`, and `Transaction` (2,000 rows total).

## Project Objectives 
- performed **deep SQL analyis** Using Joins and Groupby 
- Uncovered **Insights** about Customer Behaviour and product Performance 
- Built a **Power BI dashboard** for visualization 
- Highlighted Analytical Skills for a **remote data Analyst role**

## Dataset Structure 
| Table         | Description                            |
|---------------|----------------------------------------|
| `customers`   | Customer details including location, gender, income, loyalty |
| `products`    | Product info like name, category, price |
| `transactions`| Sales data including date, quantity, discount, payment method |


## SQL Analysis Summary 
 I performed Ten Key queries to extract Business insights:

 ### 1. **  Total Sales and Transactions Over time**
 **Insight**: Monthly Revenue and transaction Trend  Helps visualize performance over time. 
 ```sql
-- Title : Total Sales and Transactions over time 
-- Aim : To determine the Total Sales and Number of transactions per month 
select 
  date_format(date, '%Y-%m') As Month,
  Count(transaction_id) as total_transactions,
  sum(total_price) as total_sales 
  from transactions
  group by month 
  order by month ;
```

 ### 2. **Top Ten Best Selling Product**
**Insights** i Identified Which Product Drives The Most Revnue, great for marketing and Planning. 
 ```sql
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
```

###  3. **Sales by Product Category**
**Insight**: I used it to Analyze the performane across the 5 fixed product Category 
```sql
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
```

###  4. **Customer Loyalty Impact on Revenue**
**Insight**: Reveales weather higher loyalty tiers influence higher spending.
  ```sql
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
```

###  5. **Most Active Cities**
**Insight**: i understood Regional Performance and Demand hospots 
  ```sql
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
```

###  6. **Discount Impact Analysis**
**Insight**: Evaluated whether higher discounts result in higher or lower sales.
  ```sql
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
```
###  7. **High Valaue Customers**
**Insight** identified VIP customers based on life spend, greate for loyalty Campeigns. 
  ```sql
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
 ```

###  8. **Avearge Order Size by Payment Method**
**Insight**: Compared order size accross different payment channels.
  ```sql
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
```

###  9. **Cross-Category performance Summary**
**Insight**: Combines customer loyalty and product category to uncover segment preferences. 
  ```sql
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
```

###  10. ** Customer Lifetime Value **
 **Insight**: TO Identify high LTV customers value for targetting and retention
   ```sql
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
```
    


 ## My Power BI Dashboard Highlights
  After Analysis, i Built a Power BI Dashboard including 
  - **Sales Trend by Date**
  - **Top Ten Selling Product**
  - **Sales by Product Category**
  - **Loyalty Status vs Total Sales**
  - **Top Ten Customer Locations**
  - **Payment Method Breakdown** 
  - **Date Slicer|Year & Quaters**

## 🖼️ Dashboard Preview
  ![Visual Screen Shot](<Dashboard .png>)## Dahboard ScreenShot 



## Key Learnigs 
 - Strong Hands on Practice with **SQL joins, grouping , aggregations**
 - Data Story Telling through **PowerBI Visualization** 
 - Real World approach to **customer segmentation** 
 - Real World Approach to **Customer Segmentation & sales analytics**

 ## Tools Used 
 - **MySQL Workbench**
 - **Power BI Desktopm **
   - **csv for import**
    - **Faker** (for generating synthetic data)

##  Use Case Scenario

Imagine you are a retail business analyst working for a chain of stores in the U.S. You’ve been tasked with:

- Understanding how customer loyalty tiers affect purchasing
- Identifying top-performing products and cities
- Analyzing how discounts influence total sales
- Providing clear visual reports to stakeholders

This project replicates that real-world challenge using clean SQL queries and interactive Power BI dashboards.

##  Skills Demonstrated

-  Data Aggregation and Filtering (SQL `GROUP BY`, `HAVING`)
-  Multi-table JOINs and foreign key relationships
-  Insight generation from raw transactions
-  Time-series analysis using date hierarchy
-  DAX and calculated columns in Power BI
-  Dashboard building with KPI cards, slicers, and interactivity

## About me 
Hi, i'm Chibueze Emmanuel Chukwuma, a data analyst, Passionate about deriving insights from messy datasets and building visual dashboards that communicate clearly. i'm actively looking for ** Remote/Physical Data Analyst roles**,  

-- connect with me on www.linkedin.com/in/
emmanuel-chibueze


##  How to Run This Project

1. Clone the repo:
   ```bash
   (https://github.com/CEmmanuel-Analytics/Customer-Loyalty-and-Retail-Sales-Insights-)
