-- Business Question:
-- What is the revenue contribution per customer?

SELECT
  customer_unique_id,
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(total_payment) AS total_revenue,
  AVG(total_payment) AS avg_order_value
FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fact_orders`
WHERE order_status = 'delivered' AND total_payment IS NOT NULL
GROUP BY customer_unique_id;