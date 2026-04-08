-- Business Question:
-- Do delayed orders lead to lower review scores?

SELECT
  is_delayed,
  COUNT(*) AS total_orders,
  COUNT(review_score) AS reviewed_orders,
  ROUND(COUNT(review_score)/ COUNT(*) * 100,2) AS review_rate,
  ROUND(AVG(review_score),2) AS avg_review_score
FROM `olist-e-commerce-analysis.olist_raw.fact_orders`
WHERE order_status = 'delivered'
GROUP BY is_delayed
ORDER BY is_delayed;