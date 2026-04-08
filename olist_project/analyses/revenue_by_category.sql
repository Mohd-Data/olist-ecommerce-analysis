-- Business Question:
-- Which product categories generated the most revenue?

SELECT
  COALESCE(product_category_name, 'Unknown') AS product_category_name,
  COUNT(DISTINCT order_id) AS total_orders,
  COUNT(*) AS total_items,
  SUM(price) AS total_revenue,
  AVG(price) AS avg_item_price
FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fct_order_items`
GROUP BY product_category_name
ORDER BY total_revenue DESC;