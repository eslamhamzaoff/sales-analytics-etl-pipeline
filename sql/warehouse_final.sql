DROP TABLE IF EXISTS fact_sales CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;
DROP TABLE IF EXISTS dim_product CASCADE;
DROP TABLE IF EXISTS dim_date CASCADE;

CREATE TABLE dim_customer (

    customer_key SERIAL PRIMARY KEY,

    customer_id VARCHAR(50),

    customer_name VARCHAR(255),

    segment VARCHAR(100),

    country VARCHAR(100),

    city VARCHAR(100),

    state VARCHAR(100),

    postal_code VARCHAR(20),

    region VARCHAR(100)
);




CREATE TABLE dim_product (

    product_key SERIAL PRIMARY KEY,

    product_id VARCHAR(50),

    category VARCHAR(100),

    sub_category VARCHAR(100),

    product_name VARCHAR(255)
);





CREATE TABLE dim_date (

    date_key SERIAL PRIMARY KEY,

    full_date DATE,

    year INT,

    quarter INT,

    month INT,

    month_name VARCHAR(20),

    week INT,

    day INT,

    weekday VARCHAR(20)
);




CREATE TABLE fact_sales (

    sales_key SERIAL PRIMARY KEY,

    order_id VARCHAR(50),

    ship_mode VARCHAR(100),

    customer_key INT REFERENCES dim_customer(customer_key),

    product_key INT REFERENCES dim_product(product_key),

    order_date_key INT REFERENCES dim_date(date_key),

    ship_date_key INT REFERENCES dim_date(date_key),

    sales NUMERIC,

    quantity INT,

    discount NUMERIC,

    profit NUMERIC,

    profit_margin NUMERIC
);




INSERT INTO dim_customer (

    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region
)

SELECT DISTINCT

    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region

FROM stg_orders;


INSERT INTO dim_product (

    product_id,
    category,
    sub_category,
    product_name
)

SELECT DISTINCT

    product_id,
    category,
    sub_category,
    product_name

FROM stg_orders;


INSERT INTO dim_date (

    full_date,
    year,
    quarter,
    month,
    month_name,
    week,
    day,
    weekday
)

SELECT DISTINCT

    order_date::DATE,

    EXTRACT(YEAR FROM order_date),

    EXTRACT(QUARTER FROM order_date),

    EXTRACT(MONTH FROM order_date),

    TO_CHAR(order_date, 'Month'),

    EXTRACT(WEEK FROM order_date),

    EXTRACT(DAY FROM order_date),

    TO_CHAR(order_date, 'Day')

FROM stg_orders

UNION

SELECT DISTINCT

    ship_date::DATE,

    EXTRACT(YEAR FROM ship_date),

    EXTRACT(QUARTER FROM ship_date),

    EXTRACT(MONTH FROM ship_date),

    TO_CHAR(ship_date, 'Month'),

    EXTRACT(WEEK FROM ship_date),

    EXTRACT(DAY FROM ship_date),

    TO_CHAR(ship_date, 'Day')

FROM stg_orders;




INSERT INTO fact_sales (

    order_id,

    ship_mode,

    customer_key,

    product_key,

    order_date_key,

    ship_date_key,

    sales,

    quantity,

    discount,

    profit,

    profit_margin
)

SELECT

    s.order_id,

    s.ship_mode,

    dc.customer_key,

    dp.product_key,

    od.date_key AS order_date_key,

    sd.date_key AS ship_date_key,

    s.sales,

    s.quantity,

    s.discount,

    s.profit,

    s.profit_margin

FROM stg_orders s

LEFT JOIN dim_customer dc
ON s.customer_id = dc.customer_id

LEFT JOIN dim_product dp
ON s.product_id = dp.product_id

LEFT JOIN dim_date od
ON s.order_date::DATE = od.full_date

LEFT JOIN dim_date sd
ON s.ship_date::DATE = sd.full_date;