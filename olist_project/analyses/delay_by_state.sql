-- Business Question:
-- Which states have the highest delivery delays?

SELECT
  c.customer_state,
  COUNT(*) AS total_orders,
  AVG(o.delivery_days) AS avg_delivery_days,
  AVG(o.is_delayed) AS delay_rate
FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fact_orders` o
LEFT JOIN `olist-e-commerce-analysis.olist_raw.dim_customers` c
  ON o.customer_unique_id = c.customer_unique_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY delay_rate DESC;