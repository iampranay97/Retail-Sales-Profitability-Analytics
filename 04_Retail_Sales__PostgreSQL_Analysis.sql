-- Step 1 :- Create Tabel

CREATE TABLE superstore_sales (
    "Row ID" INTEGER,
    "Order ID" VARCHAR(50),
    "Order Date" DATE,
    "Ship Date" DATE,
    "Ship Mode" VARCHAR(50),
    "Customer ID" VARCHAR(50),
    "Customer Name" VARCHAR(150),
    "Segment" VARCHAR(50),
    "Country" VARCHAR(100),
    "City" VARCHAR(100),
    "State" VARCHAR(100),
    "Region" VARCHAR(50),
    "Product ID" VARCHAR(50),
    "Category" VARCHAR(100),
    "Sub-Category" VARCHAR(100),
    "Product Name" VARCHAR(255),
    Sales NUMERIC(12,4),
    Quantity INTEGER,
    Profit NUMERIC(12,4),
    Returns INTEGER,
    "Payment Mode" VARCHAR(50)
);

-- Step 2 :- Validate Row Count

SELECT COUNT(*) AS total_rows
FROM superstore_sales;

-- Step 3 :- Inspect Sample Records

SELECT * FROM superstore_sales
LIMIT 5;

-- Step 4 :- Validate Category Distribution

SELECT
	"Category",
	COUNT(*) AS row_count
FROM superstore_sales
GROUP BY "Category"
ORDER BY row_count DESC;

-- Step 5 :- Overall Business Performance

SELECT
	SUM("sales") AS total_sales,
	SUM("profit") AS total_profit,
	SUM("quantity") AS total_quantity,
	COUNT(DISTINCT "Order ID") AS total_orders,
	COUNT(DISTINCT "Customer ID") AS total_customers
FROM superstore_sales;

-- Step 6 :- Yearly Performance

SELECT
	EXTRACT(YEAR FROM "Order Date") AS order_year,
	ROUND(SUM("sales"), 2) AS total_sales,
	ROUND(SUM("profit"), 2) AS total_profit,
	COUNT(DISTINCT "Order ID") AS total_orders,
	SUM("quantity") AS total_quantity,
	ROUND(
		SUM("profit") / NULLIF(SUM("sales"), 0) * 100,
		2
	) AS profit_margin_pct
FROM superstore_sales
GROUP BY EXTRACT(YEAR FROM "Order Date")
ORDER BY order_year;

-- Step 7 :- Category Performance

SELECT
	"Category",
	ROUND(SUM("sales"), 2) AS total_sales,
	ROUND(SUM("profit"), 2) AS total_profit,
	COUNT(DISTINCT "Order ID") AS total_orders,
	SUM("quantity") AS total_quantity,
	ROUND(
		SUM("profit") / NULLIF(SUM("sales"), 0) * 100,
		2
	) AS profit_margin_pct
FROM superstore_sales
GROUP BY "Category"
ORDER BY total_profit DESC;

-- Step 8 :- Sub-Category Perfomance

SELECT
    "Sub-Category",
    ROUND(SUM("sales"), 2) AS total_sales,
    ROUND(SUM("profit"), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders,
    SUM("quantity") AS total_quantity,
    ROUND(
        SUM("profit") / NULLIF(SUM("sales"), 0) * 100,
        2
    ) AS profit_margin_pct
FROM superstore_sales
GROUP BY "Sub-Category"
ORDER BY total_profit ASC;

-- Step 9 :- Top 10 Loss-Making Products

SELECT
    "Product ID",
    "Product Name",
    ROUND(SUM("sales"), 2) AS total_sales,
    ROUND(SUM("profit"), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders,
    SUM("quantity") AS total_quantity,
    ROUND(
        (SUM("profit") / NULLIF(SUM("sales"), 0))::NUMERIC * 100,
        2
    ) AS profit_margin_pct
FROM superstore_sales
GROUP BY
    "Product ID",
    "Product Name"
HAVING SUM("profit") < 0
ORDER BY total_profit ASC
LIMIT 10;

-- Step 10 :- Top 10 Profitable Products

SELECT
    "Product ID",
    "Product Name",
    ROUND(SUM("sales"), 2) AS total_sales,
    ROUND(SUM("profit"), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders,
    SUM("quantity") AS total_quantity,
    ROUND(
        (SUM("profit") / NULLIF(SUM("sales"), 0))::NUMERIC * 100,
        2
    ) AS profit_margin_pct
FROM superstore_sales
GROUP BY
    "Product ID",
    "Product Name"
HAVING SUM("profit") > 0
ORDER BY total_profit DESC
LIMIT 10;

-- Step 11 :- Customer Profit Ranking

WITH customer_profit AS (
	SELECT
		"Customer ID",
		"Customer Name",
		ROUND(SUM("sales"), 2) AS total_sales,
		ROUND(SUM("profit"), 2) AS total_profit,
		COUNT(DISTINCT "Order ID") AS total_orders
	FROM superstore_sales
	GROUP BY "Customer ID", "Customer Name"
)

SELECT
	"Customer ID", "Customer Name",
	total_sales,
	total_profit,
	total_orders,
	RANK() OVER(
		ORDER BY total_profit DESC
	) AS profit_rank
from customer_profit
ORDER BY profit_rank
LIMIT 10;

-- Step 12 :- Region Perfomance Ranking

WITH region_performance AS (
	SELECT
		"Region",
		ROUND(SUM("sales"), 2) AS total_sales,
		ROUND(SUM("profit"), 2) AS total_profit,
		COUNT(DISTINCT "Order ID") AS total_orders,
        SUM("quantity") AS total_quantity
    FROM superstore_sales
    GROUP BY "Region"
)

SELECT
    "Region",
    total_sales,
    total_profit,
    total_orders,
    total_quantity,
    ROUND(
        (total_profit / NULLIF(total_sales, 0))::NUMERIC * 100,
        2
    ) AS profit_margin_pct,
    RANK() OVER (
        ORDER BY total_profit DESC
    ) AS profit_rank
FROM region_performance
ORDER BY profit_rank;

-- Step 13 :- Returns Analysis by Category

SELECT
    "Category",
    COUNT(*) AS total_rows,
    SUM("returns") AS returned_rows,
    ROUND(
        (SUM("returns")::NUMERIC / COUNT(*)) * 100,
        2
    ) AS return_rate_pct
FROM superstore_sales
GROUP BY "Category"
ORDER BY return_rate_pct DESC;

-- Step 14 :- Payment Mode Performance

SELECT
    "Payment Mode",
    ROUND(SUM("sales"), 2) AS total_sales,
    ROUND(SUM("profit"), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders,
    SUM("quantity") AS total_quantity,
    ROUND(
        (SUM("profit") / NULLIF(SUM("sales"), 0))::NUMERIC * 100,
        2
    ) AS profit_margin_pct
FROM superstore_sales
GROUP BY "Payment Mode"
ORDER BY total_profit DESC;

-- Step 15 :- Monthly Sales & Profit Trend

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', "Order Date") AS order_month,
        ROUND(SUM("sales"), 2) AS total_sales,
        ROUND(SUM("profit"), 2) AS total_profit
    FROM superstore_sales
    GROUP BY DATE_TRUNC('month', "Order Date")
)

SELECT
    TO_CHAR(order_month, 'YYYY-MM') AS order_month,
    total_sales,
    total_profit,
    LAG(total_sales) OVER (
        ORDER BY order_month
    ) AS previous_month_sales,
    ROUND(
        (
          (total_sales - LAG(total_sales) OVER (ORDER BY order_month))
           / NULLIF(LAG(total_sales) OVER (ORDER BY order_month), 0)
        )::NUMERIC * 100,
        2
    ) AS sales_mom_growth_pct
FROM monthly_sales
ORDER BY order_month;

-- Step 16 :- Top 2 Profitable Sub-Categories Within Each Category

WITH subcategory_profit AS (
    SELECT
        "Category",
        "Sub-Category",
        ROUND(SUM("sales"), 2) AS total_sales,
        ROUND(SUM("profit"), 2) AS total_profit
    FROM superstore_sales
    GROUP BY
        "Category",
        "Sub-Category"
),

ranked_subcategories AS (
    SELECT
        "Category",
        "Sub-Category",
        total_sales,
        total_profit,
        RANK() OVER (
            PARTITION BY "Category"
            ORDER BY total_profit DESC
        ) AS profit_rank
    FROM subcategory_profit
)

SELECT
    "Category",
    "Sub-Category",
    total_sales,
    total_profit,
    profit_rank
FROM ranked_subcategories
WHERE profit_rank <= 2
ORDER BY
    "Category",
    profit_rank;