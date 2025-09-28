-- SQL Retail sales Analysis -- p1

-- DROP TABLE IF EXISTS retail_sales;
-- CREATE TABLE retail_sales(

--        transactions_id int PRIMARY KEY,
--        sale_date date,
--        sale_time time,
--        customer_id int,
--        gender varchar(15),
--        age int,
--        category varchar(15),
--        quantiy int,
--        price_per_unit float,
-- 	   cogs float,
--        total_sale float  
-- );
-- Select * from retail_sales;

-- DATA CLEANING 


SELECT * FROM retail_sales 
   WHERE 
      transactions_id IS null OR 
	  sale_date IS null OR 
	  sale_time IS null OR 
	  customer_id IS null OR 
	  gender IS null OR
	  age IS null OR
	  category IS null OR
	  quantiy IS null OR
	  price_per_unit IS null OR
	  cogs IS null OR
	  total_sale IS null;




-- DATA EXPLOREATION 

-- HOW MANY SALES WE HAVE --

SELECT COUNT(transactions_id) as TOTAL_SALES FROM retail_sales;

-- HOW MANY CUSTOMERS WE HAVE --

SELECT COUNT(DISTINCT customer_id) AS TOTAL_CUSTOMERS FROM retail_sales;

-- HOW MANY CATEGORIES WE HAVE --

SELECT COUNT(DISTINCT category) AS TOTAL_CATEGORIES FROM retail_sales;

-- DATA ANALYSIS AND BUSINESS KEY PROBLEMS & ANSWERS --

-- Q = 1 write a sql query to retrieve all columns for sales made on '2022-11-05';

SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Q = 2 write a sql query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of november -2022

SELECT * FROM retail_sales WHERE category = 'Clothing' AND quantiy > 3 AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11'; 


-- Q = 3 write a sql query to caluclate the total sales (total_sale) for each category 

SELECT SUM(total_sale) as AMOUNT,category,COUNT(*) as total_orders FROM retail_sales GROUP BY category; 


-- Q = 4 WRITE a sql query to find the average age of customers who purchased items from the 'Beauty' category


SELECT ROUND(AVG(age),2) as AVERAGE_AGE,category from retail_sales WHERE category = 'Beauty' GROUP BY category; 

-- Q = 5 Write a sql query to find all the transactions where the total_sales is greater than 1000;

SELECT * FROM retail_sales WHERE total_sale > 1000;

-- Q = 6 write a sql query to find the total numbers of transactions (transaction_id ) made by each gender in each category ;

SELECT COUNT(transactions_id) as total_transactions,gender,category from retail_sales GROUP BY category,gender ORDER BY category,gender; 

-- Q = 7 Write a sql query to caluclate the average sale for each month . Find Out best selling month in each year ;

SELECT * FROM 
(
SELECT 
   EXTRACT(YEAR FROM sale_date ) as YEAR,
   EXTRACT(MONTH FROM sale_date ) as MONTH,
   AVG(total_sale) as Average_sales,
   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date ) ORDER BY AVG(total_sale) DESC) as RANK 
   from retail_sales GROUP BY YEAR,MONTH
) as t1
WHERE t1.rank = 1 ;


-- Q = 8 Write a sql query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id as CUSTOMERS,
	SUM(total_sale) as TOTAL_SALES
	FROM retail_sales 
	GROUP BY CUSTOMERS ORDER BY TOTAL_SALES DESC 
	LIMIT 5;


-- Q = 9 Write a sql query to find the number of unique customers who purchased items for each category

SELECT COUNT(DISTINCT customer_id) as NO_OF_UNIQUE_CUSTOMERS , category FROM retail_sales GROUP BY category ;

-- Q = 10 Write a sql query to create each shift and number of orders (Example Morning <=12,Afternoon Between 12 & 17 , Evening > 17)

SELECT COUNT(*) as NO_OF_ORDERS,
       CASE
	      WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'MORNING'
		  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
          WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'EVENING'
		  ELSE 'FREE SHIFT'
	   END AS SHIFT FROM retail_sales GROUP BY SHIFT; 



-- END OF PROJECT 
	   