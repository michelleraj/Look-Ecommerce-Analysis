----SEGMENT ANALYSIS
WITH session_data AS (
  SELECT
    traffic_source, -- Segment by channel
    DATE_TRUNC(DATE(created_at), QUARTER) AS quarter,
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN session_id END) AS purchase_sessions
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY traffic_source, quarter
),

order_data AS (
  SELECT
    traffic_source, -- Join on the segment key
    DATE_TRUNC(DATE(oi.created_at), QUARTER) AS quarter,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.sale_price) AS total_revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
  JOIN `bigquery-public-data.thelook_ecommerce.events` e ON oi.user_id = e.user_id -- Join to get the traffic_source
  WHERE oi.status NOT IN ('Returned', 'Cancelled')
  GROUP BY traffic_source, quarter
)

SELECT
  s.quarter,
  s.traffic_source, -- The segment
  s.total_sessions,
  o.total_orders,
  o.total_revenue,
  ROUND( (o.total_orders / s.total_sessions) * 100, 2 ) AS conversion_rate_pct,
  ROUND( o.total_revenue / o.total_orders, 2 ) AS revenue_per_order,
  ROUND( o.total_revenue / s.total_sessions, 2 ) AS revenue_per_session
FROM session_data s
JOIN order_data o 
  ON s.traffic_source = o.traffic_source 
  AND s.quarter = o.quarter
ORDER BY s.quarter, revenue_per_session DESC; -- Order by most efficient channel first

----segment by geography
WITH session_data AS (
  SELECT
    u.country, -- Segment by geography
    DATE_TRUNC(DATE(e.created_at), QUARTER) AS quarter,
    COUNT(DISTINCT e.session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN e.event_type = 'purchase' THEN e.session_id END) AS purchase_sessions
  FROM `bigquery-public-data.thelook_ecommerce.events` e
  JOIN `bigquery-public-data.thelook_ecommerce.users` u ON e.user_id = u.id -- Join to get geography
  WHERE e.user_id IS NOT NULL -- Need a user_id to link to geography
  GROUP BY u.country, quarter
),

order_data AS (
  SELECT
    u.country, -- Segment by geography
    DATE_TRUNC(DATE(oi.created_at), QUARTER) AS quarter,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.sale_price) AS total_revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
  JOIN `bigquery-public-data.thelook_ecommerce.users` u ON oi.user_id = u.id
  WHERE oi.status NOT IN ('Returned', 'Cancelled')
  GROUP BY u.country, quarter
)

SELECT
  s.quarter,
  s.country, -- The segment
  s.total_sessions,
  o.total_orders,
  o.total_revenue,
  ROUND( (o.total_orders / s.total_sessions) * 100, 2 ) AS conversion_rate_pct,
  ROUND( o.total_revenue / o.total_orders, 2 ) AS revenue_per_order,
  ROUND( o.total_revenue / s.total_sessions, 2 ) AS revenue_per_session
FROM session_data s
JOIN order_data o 
  ON s.country = o.country 
  AND s.quarter = o.quarter
ORDER BY s.quarter, revenue_per_session DESC;


-------------------Advanced Analysis: Category-Level Seasonality


WITH monthly_product_revenue AS (
  SELECT
    p.id AS product_id,
    p.name AS product_name,
    p.category AS product_category,
    DATE_TRUNC(DATE(oi.created_at), MONTH) AS order_month, -- Use QUARTER for quarterly analysis
    SUM(oi.sale_price) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS number_of_orders,
    SUM(oi.sale_price) / COUNT(DISTINCT oi.order_id) AS avg_order_value
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
  JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
  WHERE oi.status NOT IN ('Returned', 'Cancelled')
  GROUP BY product_id, product_name, product_category, order_month
)

SELECT
  order_month,
  product_id,
  product_name,
  product_category,
  total_revenue,
  number_of_orders,
  avg_order_value,
  DENSE_RANK() OVER (PARTITION BY order_month ORDER BY total_revenue DESC) AS revenue_rank_monthly
FROM monthly_product_revenue
QUALIFY revenue_rank_monthly <= 3 -- Adjust N for top N products per period
ORDER BY order_month DESC, revenue_rank_monthly ASC;

--------The Question: "What is the best hour of the day to launch a promotion or send a marketing email?"

SELECT
  EXTRACT(HOUR FROM created_at AT TIME ZONE 'UTC') AS hour_of_day,
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(sale_price) AS total_revenue,
  ROUND(SUM(sale_price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status NOT IN ('Returned', 'Cancelled')
GROUP BY hour_of_day
ORDER BY total_revenue DESC;


----The Question: "Which days of the week are most profitable?"

SELECT
  FORMAT_DATE('%A', DATE(created_at)) AS day_of_week,
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status NOT IN ('Returned', 'Cancelled')
GROUP BY day_of_week
ORDER BY total_revenue DESC;

---- The Question: "What are our peak selling seasons? When should we run major promotions?"

SELECT
  EXTRACT(YEAR FROM created_at) AS year,
  EXTRACT(MONTH FROM created_at) AS month,
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(sale_price) AS total_revenue,
  ROUND(SUM(sale_price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status NOT IN ('Returned', 'Cancelled')
GROUP BY year, month
ORDER BY year, month;

----The Question: "Is our business growing? Which months are performing better or worse than last year?"

WITH monthly_data AS (
  SELECT
    EXTRACT(YEAR FROM created_at) AS year,
    EXTRACT(MONTH FROM created_at) AS month,
    COUNT(DISTINCT order_id) AS orders,
    SUM(sale_price) AS revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE status NOT IN ('Returned', 'Cancelled')
  GROUP BY year, month
)

SELECT
  year,
  month,
  orders,
  revenue,
  -- Calculate Year-over-Year (YoY) growth for each month
  LAG(revenue) OVER (PARTITION BY month ORDER BY year) AS revenue_prev_year,
  ROUND( (revenue - LAG(revenue) OVER (PARTITION BY month ORDER BY year)) 
    / LAG(revenue) OVER (PARTITION BY month ORDER BY year) * 100, 2) AS yoy_growth_percent
FROM monthly_data
ORDER BY year, month;

