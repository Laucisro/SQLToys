--- Checking for consistency in pricing values, expecting to find all results only in one of the following queries
SELECT TOP 100 Product_Price
FROM toys.dbo.products
WHERE Product_Price LIKE '%,%'

SELECT TOP 100 Product_Price
FROM toys.dbo.products
WHERE Product_Price LIKE '%.%'

--- Total revenue in 2018, chanching Product_Price from a string to a float to make calculations

SELECT YEAR(CAST(s.Date as date)) AS Year, round(sum(CAST(REPLACE(p.Product_Price, '$', '') AS float)*CAST(s.Units AS INT)),0) AS Total_revenue
FROM toys.dbo.sales s
JOIN toys.dbo.products p ON s.Product_ID = p.Product_ID
WHERE YEAR(CAST(s.Date as date)) = 2018
GROUP BY YEAR(CAST(s.Date as date));

--- What's the top 10 best selling products in 2018?
SELECT TOP 10 s.Product_ID,  COUNT(s.Product_ID) AS Number_Sold, p.Product_Name, p.Product_Price
FROM toys.dbo.sales s
JOIN toys.dbo.products p ON s.Product_ID = p.Product_ID
WHERE YEAR(CAST(s.Date as date)) = 2018
GROUP BY s.Product_ID, p.Product_Name, p.Product_Price
ORDER BY COUNT(s.Product_ID) DESC;

--- What's the top 3 best selling categories in 2018

SELECT TOP 3 p.Product_Category, COUNT(s.Product_ID) AS Number_Sold 
FROM toys.dbo.sales s
JOIN toys.dbo.products p ON s.Product_ID = p.Product_ID
WHERE YEAR(CAST(s.Date as date)) = 2018
GROUP BY p.Product_Category
ORDER BY COUNT(s.Product_ID) DESC;

--- Average revenue by sale in 2018
SELECT ROUND(avg(sub.Product_Revenue),2) AS AverageSaleRevenue
FROM (
	SELECT s.Sale_ID, s.Units, CAST(REPLACE(p.Product_Price, '$', '') AS float)*CAST(s.Units AS INT) AS Product_Revenue
	FROM toys.dbo.sales s
	JOIN toys.dbo.products p ON s.Product_ID = p.Product_ID
	WHERE YEAR(CAST(s.Date as date)) = 2018
	GROUP BY s.Sale_ID, s.Units, p.Product_Price
	) sub;

--- Monthly revenue in 2018

SELECT sub.DateMonth, ROUND(SUM(sub.Product_Revenue),0) AS Monthly_Revenue_Total
FROM (
	SELECT MONTH(CAST(s.Date as date)) AS DateMonth, s.Units, CAST(REPLACE(p.Product_Price, '$', '') AS float)*CAST(s.Units AS int) AS Product_Revenue
	FROM toys.dbo.sales s
	JOIN toys.dbo.products p ON s.Product_ID = p.Product_ID
	WHERE YEAR(CAST(s.Date as date)) = 2018
) sub
GROUP BY  DateMonth
ORDER BY DateMonth

--- Monthly Revenue per category in 2018
SELECT sub.DateMonth, sub.Product_Category, ROUND(SUM(sub.Product_Revenue),0) As Monthly_Revenue_Category
FROM (
	SELECT MONTH(CAST(s.Date as date)) AS DateMonth, p.Product_Category, CAST(REPLACE(p.Product_Price, '$', '') AS float)*CAST(s.Units AS int) AS Product_Revenue
	FROM toys.dbo.sales s
	JOIN toys.dbo.products p ON s.Product_ID = p.Product_ID
	WHERE YEAR(CAST(s.Date as date)) = 2018
) sub
GROUP BY sub.DateMonth, sub.Product_Category
ORDER BY DateMonth, Product_Category

--- Monthly Revenue per category and month in 2018
SELECT  sub.Product_Category, sub.DateMonth, ROUND(SUM(sub.Product_Revenue),0) AS Monthly_Revenue
FROM (
	SELECT MONTH(CAST(s.Date as date)) AS DateMonth, s.Units, CAST(REPLACE(p.Product_Price, '$', '') AS float)*CAST(s.Units AS int) AS Product_Revenue, p.Product_Category
	FROM toys.dbo.sales s
	JOIN toys.dbo.products p ON s.Product_ID = p.Product_ID
	WHERE YEAR(CAST(s.Date as date)) = 2018
) sub
GROUP BY  Product_Category, DateMonth
ORDER BY Product_Category, DateMonth

--- Top total profit per item in 2018
SELECT TOP 10 sub.Product_Name, SUM(sub.Product_Profit*sub.Units) AS Total_Profit
FROM (
	SELECT p.Product_Name, CAST(REPLACE(p.Product_Price, '$', '') AS float)-CAST(REPLACE(p.Product_Cost, '$', '') AS float) AS Product_Profit, s.Units 
	FROM toys.dbo.products p
	JOIN toys.dbo.sales s ON p.Product_ID=p.Product_ID
	WHERE YEAR(CAST(s.Date as date)) = 2018
	) sub
GROUP BY sub.Product_Name, sub.Product_Profit, sub.Units
ORDER BY Total_Profit DESC