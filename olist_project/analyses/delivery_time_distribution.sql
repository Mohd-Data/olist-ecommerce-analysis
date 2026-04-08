-- Business Question:
-- How are delivery times distributed across orders?

SELECT
  CASE
    WHEN delivery_days <= 3 THEN '0-3 days'
    WHEN delivery_days <= 7 THEN '4-7 days'
    WHEN delivery_days <= 14 THEN '8-14 days'
    ELSE '15+ days'
  END AS delivery_bucket,
  COUNT(*) AS total_orders
FROM `olist-e-commerce-analysis.olist_raw.fact_orders`
WHERE order_status = 'delivered'
GROUP BY delivery_bucket
ORDER BY delivery_bucket;