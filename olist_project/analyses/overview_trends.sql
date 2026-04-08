-- Business Question:
-- How is the company performing over time?

SELECT
  DATE_TRUNC(order_purchase_timestamp, MONTH) AS order_month,
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(total_payment) AS total_revenue,
  AVG(total_payment) AS avg_order_value
FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fact_orders`
WHERE order_status = 'delivered' AND total_payment IS NOT NULL
GROUP BY order_month
ORDER BY order_month;

-- Found order_id = "bfbd0f9bdef84302105ad712db648a6c" has no payment record. so filtered it out as its negligable and its only one order. 