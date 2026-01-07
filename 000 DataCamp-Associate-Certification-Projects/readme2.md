# FoodYum Product Analysis - SQL Data Cleaning Project 🍎

## 📄 Project Overview
This project is part of the **DataCamp Data Analyst Associate Certification** practical exam. The goal was to audit, clean, and analyze a dataset for "FoodYum" (a food logistics company) using SQL.

The raw data contained missing values, inconsistent data types, and formatting errors. The project demonstrates proficiency in:
* **Data Validation:** Handling NULLs and type casting.
* **Data Cleaning:** Using Regex (`REGEXP_REPLACE`) to clean numeric fields.
* **Imputation:** Calculating Median and Mode for missing values.
* **Reporting:** Aggregating data for business insights.




# TASK 1
Write a query to determine how many products have the year_added value missing. Your output should be a single column, missing_year, with a single row giving the number of missing values.

---

SELECT 
    COUNT(*) AS missing_year
FROM 
    public.products
WHERE 
    year_added IS NULL;





# TASK 2
The dataset contains the following columns with specific cleaning requirements:

| Column Name | Type | Description | Cleaning Criteria (Missing/Invalid Values) |
| :--- | :--- | :--- | :--- |
| `product_id` | Nominal | Unique identifier of the product. | No missing values possible (Primary Key). |
| `product_type` | Nominal | Category of the product. | Must be one of: **Produce, Meat, Dairy, Bakery, Snacks**. Replace missing with **"Unknown"**. |
| `brand` | Nominal | The brand of the product. | Replace missing with **"Unknown"**. |
| `weight` | Continuous | Weight of the product in grams. | Remove units/non-numeric chars. Round to 2 decimals. Replace missing with **Overall Median Weight**. |
| `price` | Continuous | Selling price in US Dollars ($). | Remove currency symbols. Round to 2 decimals. Replace missing with **Overall Median Price**. |
| `average_units_sold` | Discrete | Avg. number of units sold/month. | Replace missing with **0**. |
| `year_added` | Nominal | Year product was added to stock. | Replace missing with **2022**. |
| `stock_location` | Nominal | Warehouse location origin. | Must be one of: **A, B, C, D**. Replace missing with **"Unknown"**. |

---

WITH median_values AS (
    SELECT

        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY REGEXP_REPLACE(weight, '[^0-9.]', '', 'g')::NUMERIC
        ) AS median_weight,

        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY price
        ) AS median_price
    FROM public.products
    WHERE
        -- Filter data sampah
        REGEXP_REPLACE(weight, '[^0-9.]', '', 'g') <> ''
        AND price > 0
)

SELECT
    product_id,
    CASE
        WHEN product_type NOT IN ('Produce', 'Meat', 'Dairy', 'Bakery', 'Snacks') OR product_type IS NULL
        THEN 'Unknown'
        ELSE product_type
    END AS product_type,

    CASE
        WHEN brand IS NULL OR brand = '-' THEN 'Unknown'
        ELSE brand
    END AS brand,

    ROUND(
        COALESCE(
            REGEXP_REPLACE(weight, '[^0-9.]','', 'g')::NUMERIC, 
            (SELECT median_weight FROM median_values)
        )::NUMERIC, 
    2) AS weight,

    ROUND(
        COALESCE(
            price, 
            (SELECT median_price FROM median_values)
        )::NUMERIC, 
    2) AS price,

    -- [FIXED] Hapus "OR = ''" karena ini kolom angka
    CASE
        WHEN average_units_sold IS NULL THEN 0
        ELSE average_units_sold
    END AS average_units_sold,

    -- [FIXED] Hapus "OR = ''" karena ini kolom angka
    CASE
        WHEN year_added IS NULL THEN 2022
        ELSE year_added
    END AS year_added,

    CASE
        WHEN LOWER(stock_location) = 'a' THEN 'A'
        WHEN LOWER(stock_location) = 'b' THEN 'B'
        WHEN LOWER(stock_location) = 'c' THEN 'C'
        WHEN LOWER(stock_location) = 'd' THEN 'D'
        ELSE 'Unknown' 
    END AS stock_location

FROM public.products;


# TASK 3
To find out how the range varies for each product type, your manager has asked you to determine the minimum and maximum values for each product type.

Write a query to return the product_type, min_price and max_price columns.

---
-- Write your query for task 3 in this cell
SELECT 
    product_type, 
    MIN(price) AS min_price, 
    MAX(price) AS max_price
FROM 
    public.products
WHERE 
    price IS NOT NULL -- Ensure valid price values
GROUP BY 
    product_type

# TASK 4
The team want to look in more detail at meat and dairy products where the average units sold was greater than ten.

Write a query to return the product_id, price and average_units_sold of the rows of interest to the team.
---
SELECT 
    product_id, 
    price, 
    average_units_sold
FROM 
    public.products
WHERE 
    product_type IN ('Meat', 'Dairy') -- Focus on meat and dairy products
    AND average_units_sold > 10 -- Filter rows where average units sold is greater than 10
