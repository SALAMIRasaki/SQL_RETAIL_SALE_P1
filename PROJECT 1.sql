
SELECT * FROM retail_sales

SELECT 
	COUNT(*) FROM retail_sales;

--DROPING NULL VALUE--

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time is NULL
	OR
	customer_id is NULL
	OR 
	gender is NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL



DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time is NULL
	OR
	customer_id is NULL
	OR 
	gender is NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL


SELECT * FROM retail_sales

--DATA EXPLORATION

--HOW MANY SALES WE HAVE

SELECT COUNT(*) AS Total_sale FROM retail_sales;

--NUMBER OF CUSTOMERS		1997

SELECT 
	COUNT(customer_id) 
	AS Customers 
	FROM retail_sales;

--HOW MANY UNIQUE CUSTOMERS-----155
SELECT 
	COUNT(DISTINCT Customer_id) 
	AS Distinct_Customer 
	FROM retail_sales;

--HOW MANY UNIQUE CATEGORY-- 3

SELECT 
	COUNT(DISTINCT category) 
	AS Distinct_Category 
	FROM retail_sales;

--DISPLAY UNIQUE CATEGORY BY NAME

SELECT 
	DISTINCT category 
	AS Category_name 
	FROM retail_sales;

--DATA ANALYSIS AND BUSINESS KEY PROBLEMS

--Q-1 WRITE QUERRIES TO RETRIEVE ALL COLUMN FOR SALES MADE ON '2022-22-05'

SELECT * FROM retail_sales
WHERE 
	sale_date = '2022-11-05';

--Q-2 To retrieve all transactions where the category  is 'clothing' 
--and the quantity sold is more than 4 in the month of Nov_2022

SELECT * FROM retail_sales;

SELECT 
	*
FROM retail_sales
WHERE category ='Clothing'
	AND TO_CHAR(sale_date, 'YYYY-MM') ='2022-11' 
	AND quantiy >= 4


---SUM ALL CATEGORY BY THE QUANTITY
SELECT 
	category,
	SUM(quantiy)
	FROM retail_sales
GROUP BY 1

--TO RETRIEVE ALL QUANITY PURCHASED BY MALE AND FEMALE WHERE CATEGORY IS CLOTHING

SELECT SUM(quantiy)
FROM retail_sales
WHERE gender ='Male'
AND age >20


SELECT SUM(quantiy)
FROM retail_sales
WHERE gender ='Female'
AND age >20





--Q-3 CALCULATE TOTAL SALES FOR EACH CATEGORY

SELECT 
	category,
	SUM(total_sale) AS sum_total_sale,
	COUNT (total_sale) as total_order
FROM retail_sales
GROUP BY category
	

--Q-4 AVERAGE AGE OF CUSTOMERS WHO PURCHASE ITEMS FROM 'BEAUTY CATEGORY'
SELECT *FROM retail_sales

SELECT
	ROUND(AVG(age), 2) AS Ave_age, category
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

--Q-5 FIND ALL TRANSACTIONS WHERE TOTAL SALE IS GREATER THAN 1000

SELECT *
FROM retail_sales
WHERE total_sale >1000

--Q--6 TOTAL NUMBER OF TRANSACTIONS BY EACH GENDER

SELECT
		category,
		gender,
		COUNT(*) as total_trans
FROM retail_sales
GROUP 
	BY 
	category,
	gender

--SUM OF TOTAL TRANSACTIONS BY EACH GENDER

SELECT
		category,
		gender,
		SUM(total_sale) as sum_total_sales
FROM retail_sales
GROUP 
	BY 
	category,
	gender

--Q-7 CALCULATE THE AVERAGE SALE FOR EACH MONTH , FIND THE BEST SELLING MONTH IN EACH YEAR
--CREAT A SUB TABLE, RANK WHICH INVILVE PARTITION BY

SELECT
		year,
		month,
		avg_sale
FROM
(
SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY 1, 2
) AS t1
WHERE rank =1


--Q-8 TOP 5 CUSTOMERS BASED ON THE HIGHEST SALES

--select DISTINCT customer_id from retail_sales		

SELECT * FROM retail_sales

SELECT 
	customer_id,
	SUM(total_sale) AS total_sales,
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--TO DETERMINE THE MOSR PURCHASE ITEM  BY CUSTOMERS

SELECT 
	customer_id,
	SUM(total_sale) AS total_sales,
	category
FROM retail_sales
GROUP BY 1,3
ORDER BY 2 DESC
LIMIT 5


--Q-9	Numbers of Unique Cusomers who purchase items from each Category

SELECT 
	COUNT(DISTINCT customer_id) AS unique_customer, 
	category
from retail_sales
GROUP BY 2

--TO GET THE TOTAL NUMBER OF CUSTOMER IN EACH CATEGORY

SELECT 
	COUNT(customer_id) AS num_customer, 
	category
from retail_sales
GROUP BY 2

--Q-10 	WRITE A QUERY TO CREATE EACH SHIFT AND NUMBERS OF ORDERS
--(E.G MORNING <=12, AFTERNOON BETWEEN 12 &17 EVENING > 17)

--A there is no Morning or Afternoon in the file, we need to create one

-- SELECT *,
	--CASE
		--WHEN THEN
		--WHEN THEN
		--ELSE
	--END AS SHIFT
--FROM retail_sales       This will create a new COLUMN

--NOTE EXTRACT (HOUR FROM CURRENT_TIME)   will show the current time on ur PC

WITH hourly_sales
AS
(
	SELECT *,
			CASE
				WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN	'Morning'
				WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afernoon'
				ELSE 'Evening'
			END AS shift
		FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift
ORDER BY 2 DESC

--END OF PROJECT










	
