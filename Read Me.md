---
title: "Maven Toy Store"
author: "Laura Cisneros Robles"
date: "2022-09-17"
output: html_document
---

# Maven Toy Store
This is a personal project in wich I will explore a dataset of a Mexican Toy Store provided by Mysar Ahmad Bhat on Kaggle (https://www.kaggle.com/datasets/mysarahmadbhat/toy-sales) with the intend to extract relevant data with SQL to create a dashboard in Tableau.
I'm Working with Microsoft SQL server and Tableau Public.

Following the data structure provided by the dataset, I create 4 tables in the database toys: inventory, products, sales and stores. Then, I perform a series of queries to extract the relevant metrics to create a sales dashboard. As I'm working with Tableau Public, I'm unable to connect my database directly to Tableau, so I will extract manually as a csv file the result of each query to work with them in Tableau.

You can find the dashboard in the following link: https://public.tableau.com/views/ToySalesDashboard_16634114715600/Dashboard1?:language=es-ES&:display_count=n&:origin=viz_share_link