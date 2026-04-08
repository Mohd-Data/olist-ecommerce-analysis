-- Business Question:
-- What percentage of customers make repeat purchases?

WITH customer_orders AS (
  SELECT
    customer_unique_id,
    COUNT(DISTINCT order_id) AS total_orders
  FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fact_orders`
  WHERE order_status = 'delivered'
  GROUP BY customer_unique_id
)

SELECT
  COUNT(*) AS total_customers,
  COUNTIF(total_orders > 1) AS repeat_customers,
  SAFE_DIVIDE(COUNTIF(total_orders > 1), COUNT(*)) AS repeat_customer_rate
FROM customer_orders;