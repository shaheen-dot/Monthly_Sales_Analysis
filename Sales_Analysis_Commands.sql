
-- 1. Verify Data
SELECT *
FROM SampleSuperstore
LIMIT 5;

-- 2. Check Date Format
SELECT order_date
FROM SampleSuperstore
LIMIT 10;

-- 3. Monthly Revenue and Order Volume
SELECT
    substr(order_date, -4) AS Year,
    CASE
        WHEN instr(order_date,'/') > 0
        THEN printf('%02d',
             CAST(substr(order_date,1,
             instr(order_date,'/')-1) AS INTEGER))
    END AS Month,
    ROUND(SUM(sales),2) AS Revenue,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM SampleSuperstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- 4. Monthly Revenue Only
SELECT
    substr(order_date, -4) AS Year,
    printf('%02d',
        CAST(substr(order_date,1,
        instr(order_date,'/')-1) AS INTEGER)
    ) AS Month,
    ROUND(SUM(sales),2) AS Revenue
FROM SampleSuperstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- 5. Monthly Order Volume Only
SELECT
    substr(order_date, -4) AS Year,
    printf('%02d',
        CAST(substr(order_date,1,
        instr(order_date,'/')-1) AS INTEGER)
    ) AS Month,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM SampleSuperstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- 6. Analyze Specific Year (2017)
SELECT
    substr(order_date, -4) AS Year,
    printf('%02d',
        CAST(substr(order_date,1,
        instr(order_date,'/')-1) AS INTEGER)
    ) AS Month,
    ROUND(SUM(sales),2) AS Revenue,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM SampleSuperstore
WHERE substr(order_date,-4)='2017'
GROUP BY Year, Month
ORDER BY Month;

-- 7. Top 5 Revenue Months
SELECT
    substr(order_date,-4) AS Year,
    printf('%02d',
        CAST(substr(order_date,1,
        instr(order_date,'/')-1) AS INTEGER)
    ) AS Month,
    ROUND(SUM(sales),2) AS Revenue
FROM SampleSuperstore
GROUP BY Year, Month
ORDER BY Revenue DESC
LIMIT 5;

-- 8. Create Results Table
CREATE TABLE sales_trend_results AS
SELECT
    substr(order_date,-4) AS Year,
    printf('%02d',
        CAST(substr(order_date,1,
        instr(order_date,'/')-1) AS INTEGER)
    ) AS Month,
    ROUND(SUM(sales),2) AS Revenue,
    COUNT(DISTINCT order_id) AS Order_Volume
FROM SampleSuperstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- 9. View Results Table
SELECT *
FROM sales_trend_results;