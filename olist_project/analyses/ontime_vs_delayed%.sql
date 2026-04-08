-- Business Question:
-- What percentage of orders are delivered on time vs delayed?

SELECT
  is_delayed,
  COUNT(*) AS total_orders,
  COUNT(*) / SUM(COUNT(*)) OVER () AS percentage
FROM `olist-e-commerce-analysis.olist_raw.fact_orders`
WHERE order_status = 'delivered'
GROUP BY is_delayed;