SELECT COUNT(*)
FROM dim_customer;

SELECT COUNT(*)
FROM dim_product;

SELECT COUNT(*)
FROM dim_date;

SELECT COUNT(*)
FROM fact_sales;

--SALES KPI

SELECT
    ROUND(SUM(sales), 2) AS total_sales
FROM fact_sales;

--TOP CUSTOMERS

SELECT

    dc.customer_name,

    ROUND(SUM(fs.sales), 2) AS total_sales

FROM fact_sales fs

JOIN dim_customer dc
ON fs.customer_key = dc.customer_key

GROUP BY dc.customer_name

ORDER BY total_sales DESC

LIMIT 10;

--SALES BY CATEGORY

SELECT

    dp.category,

    ROUND(SUM(fs.sales), 2) AS total_sales

FROM fact_sales fs

JOIN dim_product dp
ON fs.product_key = dp.product_key

GROUP BY dp.category

ORDER BY total_sales DESC;


--MONTHLY TREND

SELECT

    dd.year,

    dd.month,

    ROUND(SUM(fs.sales), 2) AS monthly_sales

FROM fact_sales fs

JOIN dim_date dd
ON fs.order_date_key = dd.date_key

GROUP BY dd.year, dd.month

ORDER BY dd.year, dd.month;