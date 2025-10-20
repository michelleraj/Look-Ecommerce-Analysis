SELECT 
  COUNT(DISTINCT order_id) AS total_orders
FROM 
  `bigquery-public-data.thelook_ecommerce.orders`
WHERE 
  status NOT IN ('cancelled', 'returned');

--schema
SELECT column_name, data_type
FROM `bigquery-public-data.thelook_ecommerce.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'users';

--table
SELECT table_name
FROM `bigquery-public-data.thelook_ecommerce.INFORMATION_SCHEMA.TABLES`
ORDER BY table_name;

-- Look at 5 rows from all tables
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.users`
LIMIT 5;
--distribution_center
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.distribution_centers`
LIMIT 5;
--events
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.events`
LIMIT 5;
--inventory-items
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.inventory_items`
LIMIT 5;

-- the schema of dataset
SELECT
  table_name,
  column_name,
  data_type,
  is_nullable
FROM `bigquery-public-data.thelook_ecommerce.INFORMATION_SCHEMA.COLUMNS`
ORDER BY table_name, ordinal_position;

-- check all table sizes
-- How many rows are in each table
SELECT 'users' AS table_name, COUNT(*) AS num_rows FROM `bigquery-public-data.thelook_ecommerce.users`
UNION ALL
SELECT 'events', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.events`
UNION ALL
SELECT 'orders', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.orders`
UNION ALL
SELECT 'order_items', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.order_items`
UNION ALL
SELECT 'products', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.products`
UNION ALL
SELECT 'inventory_items', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.inventory_items`
UNION ALL
SELECT 'distribution_centers', COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.distribution_centers`;

--check for missing data
-- Example for users table
SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS missing_first_name,
  SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS missing_last_name,
  SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS missing_email,
  SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
  SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS missing_gender,
  SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS missing_state,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS missing_created_at
FROM `bigquery-public-data.thelook_ecommerce.users`;

SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS missing_user_id,
  SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS missing_status,
  SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS missing_gender,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS missing_created_at,
  SUM(CASE WHEN shipped_at IS NULL THEN 1 ELSE 0 END) AS missing_shipped_at,
  SUM(CASE WHEN delivered_at IS NULL THEN 1 ELSE 0 END) AS missing_delivered_at
FROM `bigquery-public-data.thelook_ecommerce.orders`;

SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS missing_name,
  SUM(CASE WHEN cost IS NULL THEN 1 ELSE 0 END) AS missing_cost,
  SUM(CASE WHEN retail_price IS NULL THEN 1 ELSE 0 END) AS missing_retail_price,
  SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS missing_category,
  SUM(CASE WHEN brand IS NULL THEN 1 ELSE 0 END) AS missing_brand
FROM `bigquery-public-data.thelook_ecommerce.products`;

SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS missing_user_id,
  SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS missing_session_id,
  SUM(CASE WHEN event_type IS NULL THEN 1 ELSE 0 END) AS missing_event_type,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS missing_created_at
FROM `bigquery-public-data.thelook_ecommerce.events`;

SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS missing_created_at,
  SUM(CASE WHEN sold_at IS NULL THEN 1 ELSE 0 END) AS missing_sold_at,
  SUM(CASE WHEN cost IS NULL THEN 1 ELSE 0 END) AS missing_cost,
  SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS missing_category,
  SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS missing_name,
  SUM(CASE WHEN product_brand IS NULL THEN 1 ELSE 0 END) AS missing_brand,
  SUM(CASE WHEN product_retail_price IS NULL THEN 1 ELSE 0 END) AS missing_retail_price,
  SUM(CASE WHEN product_department IS NULL THEN 1 ELSE 0 END) AS missing_department,
  SUM(CASE WHEN product_sku IS NULL THEN 1 ELSE 0 END) AS missing_sku,
  SUM(CASE WHEN product_distribution_center_id IS NULL THEN 1 ELSE 0 END) AS missing_distribution_center_id
FROM
  `bigquery-public-data.thelook_ecommerce.inventory_items`;

SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS missing_name,
  SUM(CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS missing_latitude,
  SUM(CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS missing_longitude
FROM `bigquery-public-data.thelook_ecommerce.distribution_centers`;



SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
  SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS missing_user_id,
  SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
  SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS missing_status,
  SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS missing_created_at,
  SUM(CASE WHEN sale_price IS NULL THEN 1 ELSE 0 END) AS missing_sale_price
FROM `bigquery-public-data.thelook_ecommerce.order_items`;

-- create a column for the usertype anonymmous and known for events table
SELECT
  id,
  user_id, -- This is the column with many NULLs
  session_id,
  event_type,
  created_at,
  traffic_source,
  -- THE NEXT STEP: Create the user segment
  CASE
    WHEN user_id IS NULL THEN 'anonymous'
    ELSE 'known'
  END AS user_type
FROM
  `bigquery-public-data.thelook_ecommerce.events`;
-- LIMIT 100


--order_items table analyzing the fullfillment table analysis 
SELECT
  id,
  order_id,
  user_id,
  status,
  created_at,
  shipped_at,
  delivered_at,
  returned_at,
  -- THE NEXT STEP: Create a detailed status for each item
  CASE
    WHEN returned_at IS NOT NULL THEN 'Returned'
    WHEN delivered_at IS NOT NULL THEN 'Delivered'
    WHEN shipped_at IS NOT NULL THEN 'Shipped'
    ELSE 'Processing'
  END AS item_status
FROM
  `bigquery-public-data.thelook_ecommerce.order_items`


  
--LIMIT 1000
-- create average shipping time for order table
SELECT
  AVG(DATE_DIFF(shipped_at, created_at, DAY)) AS avg_days_to_ship,
  COUNT(*) AS number_of_orders_shipped
FROM
  `bigquery-public-data.thelook_ecommerce.orders`
WHERE
  shipped_at IS NOT NULL; -- Critical filter


--categorise orders by fulfillment status 
SELECT
  order_id,
  user_id,
  status,
  created_at,
  shipped_at,
  delivered_at,
  -- THE NEXT STEP: Create a new status based on date fields
  CASE
    WHEN delivered_at IS NOT NULL THEN 'Delivered'
    WHEN shipped_at IS NOT NULL THEN 'Shipped (Not Yet Delivered)'
    ELSE 'Processing (Not Yet Shipped)'
  END AS fulfillment_status
FROM
  `bigquery-public-data.thelook_ecommerce.orders`
ORDER BY created_at DESC
--LIMIT 1000;
-----------
--Cleaning name and brand data from the product table
SELECT
  id,
  cost,
  category,
  department,
  -- THE NEXT STEP: Clean the text fields
  COALESCE(name, 'Unknown Product Name') AS product_name_clean,
  COALESCE(brand, 'Unknown Brand') AS brand_clean,
  retail_price
FROM
  `bigquery-public-data.thelook_ecommerce.products`
-- WHERE brand IS NULL -- Use this to check thenull value rows


-----------
--Having NULL values for sold_at in the inventory_items typically means that those inventory items have not been sold yet
SELECT
  id,
  product_id,
  created_at,
  sold_at, -- This is the key column for NULL analysis
  cost,
  -- THE NEXT STEP: Categorize inventory status
  CASE
    WHEN sold_at IS NOT NULL THEN 'Sold'
    ELSE 'In Stock'
  END AS inventory_status
FROM
  `bigquery-public-data.thelook_ecommerce.inventory_items`
--LIMIT 1000

--------
SELECT
  traffic_source,
  COUNT(DISTINCT session_id) as total_sessions,
  COUNT(DISTINCT CASE WHEN user_type = 'known' THEN session_id END) as known_user_sessions,
  COUNT(DISTINCT CASE WHEN user_type = 'anonymous' THEN session_id END) AS anonymous_user_sessions,
  COUNT(DISTINCT user_id) as unique_users -- Counts only known users
FROM (
  SELECT *,
    CASE WHEN user_id IS NULL THEN 'anonymous' ELSE 'known' END AS user_type
  FROM `bigquery-public-data.thelook_ecommerce.events`
)
GROUP BY 1
ORDER BY total_sessions DESC;

--------

SELECT
  u.country,
  u.state,
  u.city,
  COUNT(*) as event_count
FROM `bigquery-public-data.thelook_ecommerce.events` e
JOIN `bigquery-public-data.thelook_ecommerce.users` u ON e.user_id = u.id
WHERE e.user_id IS NOT NULL -- Analyze only known users for geography
GROUP BY 1, 2, 3
ORDER BY event_count DESC;
----------

--conversion funnel analysis --Identify where users drop off in the journey from visit to purchase.
--Website Performance & Conversion Funnels
--The Question: "How well are we converting visitors into customers?"
WITH session_events AS (
  SELECT
    session_id,
    MAX(CASE WHEN event_type = 'product' THEN 1 ELSE 0 END) as viewed_product,
    MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) as added_to_cart,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) as made_purchase
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY session_id
)

SELECT
  COUNT(session_id) as total_sessions,
  SUM(viewed_product) as reached_view,
  SUM(added_to_cart) as reached_cart,
  SUM(made_purchase) as reached_purchase,

  ROUND(SAFE_DIVIDE(SUM(viewed_product), COUNT(session_id)) * 100, 2) AS view_rate,
  ROUND(SAFE_DIVIDE(SUM(added_to_cart), SUM(viewed_product)) * 100, 2) AS cart_rate,
  ROUND(SAFE_DIVIDE(SUM(made_purchase), SUM(added_to_cart)) * 100, 2) AS purchase_rate


FROM session_events;

-- Cohort Analysis and retention -  Track if groups of users (cohorts) continue to purchase over time
WITH first_orders AS (
  SELECT
    user_id,
    MIN(created_at) as first_order_date
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  WHERE status = 'Complete'
  GROUP BY user_id
),

second_orders AS (
  SELECT
    o.user_id,
    MIN(o.created_at) as second_order_date
  FROM `bigquery-public-data.thelook_ecommerce.orders` o
  JOIN first_orders fo ON o.user_id = fo.user_id
  WHERE o.created_at > fo.first_order_date
  AND o.status = 'Complete'
  GROUP BY o.user_id
)

SELECT
  COUNT(DISTINCT fo.user_id) as cohort_size,
  COUNT(DISTINCT so.user_id) as retained_users,
  ROUND(COUNT(DISTINCT so.user_id) / COUNT(DISTINCT fo.user_id) * 100, 2) as retention_rate
FROM first_orders fo
LEFT JOIN second_orders so ON fo.user_id = so.user_id;

----Find your best-selling products and analyze inventory turnover.
SELECT
  p.id,
  p.name,
  p.category,
  p.brand,
  SUM(oi.sale_price) as total_revenue,
  COUNT(oi.id) as units_sold
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p ON oi.product_id = p.id
WHERE oi.status NOT IN ('Returned', 'Cancelled')
GROUP BY 1, 2, 3, 4
ORDER BY total_revenue DESC
LIMIT 20;
SELECT
  product_category,
  AVG(DATE_DIFF(sold_at, created_at, DAY)) as avg_days_to_sell
FROM `bigquery-public-data.thelook_ecommerce.inventory_items`
WHERE sold_at IS NOT NULL -- Only look at items that have sold
GROUP BY 1
ORDER BY avg_days_to_sell;

----------Measure the efficiency of your shipping and delivery processes
SELECT
  -- Analyze by shipping status
  CASE
    WHEN delivered_at IS NOT NULL THEN 'Delivered'
    WHEN shipped_at IS NOT NULL THEN 'Shipped'
    ELSE 'Processing'
  END AS status_category,

  COUNT(*) as order_count,
  -- Average time for each stage (only for completed stages)
  AVG(DATE_DIFF(shipped_at, created_at, DAY)) AS avg_process_days,
  AVG(DATE_DIFF(delivered_at, shipped_at, DAY)) AS avg_transit_days,
  AVG(DATE_DIFF(delivered_at, created_at, DAY)) AS avg_total_days

FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status = 'Complete' -- Only look at completed orders
GROUP BY 1
ORDER BY order_count DESC;

-- The Question: "Where should we be investing our marketing budget?"
SELECT
  traffic_source,
  COUNT(DISTINCT session_id) AS sessions,
  COUNT(DISTINCT user_id) AS users,
  -- Calculate the CVR: (Sessions with a Purchase / Total Sessions)
  ROUND(100 * COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN session_id END) 
        / COUNT(DISTINCT session_id), 2) AS session_conversion_rate,
  -- Calculate the volume of orders generated
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN e.user_id END) AS orders
FROM `bigquery-public-data.thelook_ecommerce.events` e
GROUP BY traffic_source
ORDER BY sessions DESC;


------------------------------ Quarterly Revenue-------------------------------------------
WITH session_data AS (
  -- Count all sessions and purchasing sessions per quarter
  SELECT
    DATE_TRUNC(DATE(created_at), QUARTER) AS quarter,
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN session_id END) AS purchase_sessions
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY quarter
),

order_data AS (
  -- Calculate revenue and count orders per quarter
  SELECT
    DATE_TRUNC(DATE(oi.created_at), QUARTER) AS quarter,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.sale_price) AS total_revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
  WHERE oi.status NOT IN ('Returned', 'Cancelled') -- Only count successful orders
  GROUP BY quarter
)

-- Join the session and order data together to calculate the rates
SELECT
  s.quarter,
  s.total_sessions,
  o.total_orders,
  o.total_revenue,
  
  -- 1. Session to Order Conversion Rate
  ROUND( (o.total_orders / s.total_sessions) * 100, 2 ) AS conversion_rate_pct,
  
  -- 2. Revenue Per Order (AOV)
  ROUND( o.total_revenue / o.total_orders, 2 ) AS revenue_per_order,
  
  -- 3. Revenue Per Session
  ROUND( o.total_revenue / s.total_sessions, 2 ) AS revenue_per_session

FROM session_data s
JOIN order_data o ON s.quarter = o.quarter
ORDER BY s.quarter;





