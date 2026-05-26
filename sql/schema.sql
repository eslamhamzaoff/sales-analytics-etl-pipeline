CREATE TABLE IF NOT EXISTS stg_orders (

    row_id INT,

    order_id VARCHAR(50),

    order_date TIMESTAMP,
    ship_date TIMESTAMP,

    ship_mode VARCHAR(100),

    customer_id VARCHAR(50),
    customer_name VARCHAR(255),
    segment VARCHAR(100),

    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(100),

    product_id VARCHAR(50),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    product_name VARCHAR(255),

    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC,

    order_year INT,
    order_month INT,
    profit_margin NUMERIC
);