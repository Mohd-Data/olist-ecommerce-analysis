-- Business Question:
-- How many orders do customers typically place?

WITH customer_orders AS (
  SELECT
    customer_unique_id,
    COUNT(DISTINCT order_id) AS total_orders
  FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fact_orders`
  WHERE order_status = 'delivered'
  GROUP BY customer_unique_id
)

SELECT
  total_orders,
  COUNT(*) AS customer_count
FROM customer_orders
GROUP BY total_orders
ORDER BY total_orders;