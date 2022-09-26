---
title: "MexicoToySale"
author: "Laura Cisneros Robles"
date: "2022-09-17"
output: html_document
---

# Mexico Toy sale
This is a personal project in wich I will explore a dataset of a Mexican Toy Store provided by Mysar Ahmad Bhat on Kaggle (https://www.kaggle.com/datasets/mysarahmadbhat/toy-sales) with the intend to extract relevant data with SQL to create a dashboard in Tableau.
I'm Working with Microsoft SQL server and Tableau Public.

Following the data structure provided by the dataset, I create 4 tables in the database toys: inventory, products, sales and stores. Then, I perform a series of queries to extract the relevant metrics to create a sales dashboard. As I'm working with Tableau Public, I'm unable to connect my database directly to Tableau, so I will extract manually as a csv file the result of each query to work with them in Tableau.

## Undestanding the data
Each table contains 

```
SELECT TOP 100 Product_Price
FROM toys.dbo.products
WHERE Product_Price LIKE '%,%'

SELECT TOP 100 Product_Price
FROM toys.dbo.products
WHERE Product_Price LIKE '%.%'
```
kljhsddkjfhsd

```
CAST(REPLACE(p.Product_Price, '$', '') AS float)*CAST(s.Units AS INT) AS Product_revenue
```

