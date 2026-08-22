# Retail Sales & Profitability Analytics

## Project Overview

This project analyzes retail sales data to understand overall business performance, profitability, product performance, customer behavior, regional performance, payment channels, and returns.

The project follows an end-to-end Data Analytics workflow using Python, PostgreSQL, and Power BI.

## Business Problem

The business wants to understand:

* Overall sales and profitability performance
* Which categories and sub-categories generate the most profit
* Which products are driving losses
* Which customers and regions contribute most to profitability
* How payment modes perform
* Which categories have higher return rates
* How sales performance changes over time

## Business Objectives

1. Analyze overall sales, profit, orders, customers, and quantity.
2. Identify high-performing and low-performing categories and products.
3. Analyze customer and regional profitability.
4. Evaluate payment-mode performance.
5. Analyze return rates.
6. Build an interactive Power BI dashboard for business decision-making.

## Dataset

* Rows: 5,901
* Columns: 21
* Period: 2019–2020
* Data Type: Retail sales transactions

The dataset contains information related to:

* Orders
* Customers
* Products
* Categories and Sub-Categories
* Sales
* Quantity
* Profit
* Returns
* Payment Mode
* Region
* Order and Ship Dates

## Tools & Technologies

| Tool       | Purpose                                      |
| ---------- | -------------------------------------------- |
| Python     | Data Cleaning & Exploratory Data Analysis    |
| Pandas     | Data manipulation and validation             |
| PostgreSQL | SQL analysis and business queries            |
| Power BI   | Data modeling, DAX and dashboard development |
| GitHub     | Project documentation and portfolio          |

## Project Workflow


Raw Dataset
     ↓
Python Data Cleaning
     ↓
Exploratory Data Analysis
     ↓
Cleaned Dataset
     ↓
PostgreSQL Analysis
     ↓
Power BI Data Modeling
     ↓
DAX Measures
     ↓
Interactive Dashboard
     ↓
Business Insights & Recommendations



## Python Analysis

Python was used for:

* Data inspection
* Data type validation
* Date cleaning
* Postal code cleaning
* Data quality checks
* Duplicate investigation
* Statistical analysis
* Exploratory Data Analysis
* Business performance analysis

Python File:

`03_Retail_Sales_Python_Analysis`

## SQL Analysis

PostgreSQL was used for:

* Table creation
* Data validation
* Overall business KPIs
* Yearly performance
* Category performance
* Sub-category performance
* Loss-making products
* Profitable products
* Customer profitability ranking
* Regional analysis
* Returns analysis
* Payment-mode analysis
* Monthly sales trends
* Month-over-Month analysis using 'LAG()'
* Advanced ranking using 'CTE', 'RANK()' and 'PARTITION BY'

SQL file:

`04_Retail_Sales__PostgreSQL_Analysis`

## Power BI Dashboard

The Power BI report contains three pages:

### 1. Executive Overview

Provides a high-level view of:

* Total Sales
* Total Profit
* Total Orders
* Profit Margin
* Average Order Value
* Monthly Sales Trend
* Profit by Category
* Profit by Region

### 2. Product & Category Performance

Focuses on:

* Category profitability
* Sub-category profitability
* Category profit margins
* Top profitable products
* Top loss-making products

### 3. Customer, Region & Channel Analysis

Focuses on:

* Customer profitability
* Regional performance
* Payment-mode performance
* Return rates
* Customer sales vs. profit

Power BI file:

`05_Retail_Sales_Profitability_Analysis`

## Key KPIs

| KPI                 | Overall Result |
| ------------------- | -------------: |
| Total Sales         |  $1,565,804.32 |
| Total Profit        |    $175,262.11 |
| Total Orders        |          3,003 |
| Total Customers     |            773 |
| Total Quantity      |         22,317 |
| Profit Margin       |         11.19% |
| Average Order Value |        $521.41 |
| Return Rate         |          4.86% |

## Key Business Insights

### Category Performance

* Technology generated the highest profit with approximately $90.46K and the highest profit margin of 19.22%.
* Office Supplies generated the highest sales at approximately $643.71K.
* Furniture had the weakest profitability with a profit margin of approximately 2.22%.

### Sub-Category Performance

* Copiers generated the highest sub-category profit.
* Tables were the largest loss-making sub-category with approximately -$11.09K profit.
* Supplies and Bookcases also showed negative profitability.

### Regional Performance

* West was the strongest region by profit with approximately $67.86K.
* Central had the lowest profit margin among the four regions.

### Returns

* Furniture had the highest return rate at approximately 5.60%.
* Technology and Office Supplies had lower return rates.

### Payment Mode

* COD generated the highest observed sales and profit among the payment modes.
* Online and Cards followed with lower overall profit contribution.

## Business Recommendations

1. Investigate the profitability of the Furniture category, especially loss-making sub-categories such as Tables.
2. Review pricing, discounting, and product-level profitability for consistently loss-making products.
3. Investigate the higher return rate observed in Furniture.
4. Study the factors behind the strong profitability of Technology and high-performing products such as Copiers.
5. Monitor regional and customer-level profitability rather than relying only on sales volume.

## Project Structure

retail-sales-profitability-analytics/
│
├── README.md
│
├── data/
│   └── SuperStore_Sales_Dataset_Cleaned.csv
│
├── python/
│   └── Retail_Sales_Python_Analysis.ipynb
│
├── sql/
│   └── Retail_Sales_SQL_Analysis.sql
│
├── powerbi/
│   └── Retail_Sales_Profitability_Analysis.pbix
│
└── screenshots/
    ├── executive-overview.png
    ├── product-category-performance.png
    └── customer-region-channel-analysis.png
    

## Dashboard Preview

### Executive Overview

<img width="1167" height="656" alt="Page_1_Executive_Overview" src="https://github.com/user-attachments/assets/8e3e846d-454b-4342-b63d-37e2e71aa026" />


### Product & Category Performance

<img width="1170" height="652" alt="Page_2_Product_ _Category_Perfomance" src="https://github.com/user-attachments/assets/f7c78cac-1c03-47dd-97e7-1a9a8c25f0d2" />


### Customer, Region & Channel Analysis

<img width="1170" height="662" alt="Page_3_Customer_Region_ _Channel_Analysis" src="https://github.com/user-attachments/assets/3dc79fc5-23d3-422f-9a52-f1bf84d1e159" />

