# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_p1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
-- HOW MANY SALES WE HAVE --

SELECT COUNT(transactions_id) as TOTAL_SALES FROM retail_sales;

-- HOW MANY CUSTOMERS WE HAVE --

SELECT COUNT(DISTINCT customer_id) AS TOTAL_CUSTOMERS FROM retail_sales;

-- HOW MANY CATEGORIES WE HAVE --

SELECT COUNT(DISTINCT category) AS TOTAL_CATEGORIES FROM retail_sales;

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

DELETE FROM retail_sales 
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Q = 1 write a sql query to retrieve all columns for sales made on '2022-11-05'**:
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

2. **Q = 2 write a sql query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of november -2022**:
```sql
SELECT * FROM retail_sales WHERE category = 'Clothing' AND quantiy > 3 AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11'; 
```

3. **Q = 3 write a sql query to caluclate the total sales (total_sale) for each category **:
```sql
SELECT SUM(total_sale) as AMOUNT,category,COUNT(*) as total_orders FROM retail_sales GROUP BY category;
```

4. **Q = 4 WRITE a sql query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT ROUND(AVG(age),2) as AVERAGE_AGE,category from retail_sales WHERE category = 'Beauty' GROUP BY category; 
```

5. **Q = 5 Write a sql query to find all the transactions where the total_sales is greater than 1000.**:
```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```

6. **Q = 6 write a sql query to find the total numbers of transactions (transaction_id ) made by each gender in each category .**:
```sql
SELECT COUNT(transactions_id) as total_transactions,gender,category from retail_sales GROUP BY category,gender ORDER BY category,gender; 
```

7. **Q = 7 Write a sql query to caluclate the average sale for each month . Find Out best selling month in each year **:
```sql
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
```

8. **Q = 8 Write a sql query to find the top 5 customers based on the highest total sales  **:
```sql
SELECT 
    customer_id as CUSTOMERS,
	SUM(total_sale) as TOTAL_SALES
	FROM retail_sales 
	GROUP BY CUSTOMERS ORDER BY TOTAL_SALES DESC 
	LIMIT 5;
```

9. **Q = 9 Write a sql query to find the number of unique customers who purchased items for each category.**:
```sql
SELECT COUNT(DISTINCT customer_id) as NO_OF_UNIQUE_CUSTOMERS , category FROM retail_sales GROUP BY category ;
```

10. **Q = 10 Write a sql query to create each shift and number of orders (Example Morning <=12,Afternoon Between 12 & 17 , Evening > 17)**:
```sql
SELECT COUNT(*) as NO_OF_ORDERS,
       CASE
	      WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'MORNING'
		  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
          WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'EVENING'
		  ELSE 'FREE SHIFT'
	   END AS SHIFT FROM retail_sales GROUP BY SHIFT; 



-- END OF PROJECT 
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `sql_query_p1.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `sql_query_p1.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Zero Analyst

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:


- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/ahmeed_jutt_/)
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/ahmadmehmood1252/)

Thank you for your support, and I look forward to connecting with you!
