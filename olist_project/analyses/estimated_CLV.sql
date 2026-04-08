-- Business Question:
-- What is the estimated customer lifetime value using behavioral metrics?

WITH customer_metrics AS (
  SELECT
    customer_unique_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_payment) AS total_revenue,
    AVG(total_payment) AS avg_order_value,
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
  FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fact_orders`
  WHERE order_status = 'delivered' AND total_payment IS NOT NULL
  GROUP BY customer_unique_id
),

final AS (
  SELECT
    customer_unique_id,
    total_orders,
    total_revenue,
    avg_order_value,
    DATE_DIFF(last_order_date, first_order_date, DAY) AS customer_lifespan_days,
    SAFE_DIVIDE(total_orders, DATE_DIFF(last_order_date, first_order_date, DAY)) AS purchase_frequency_per_day
  FROM customer_metrics
)

SELECT
  customer_unique_id,
  total_orders,
  total_revenue,
  avg_order_value,
  customer_lifespan_days,
  purchase_frequency_per_day,
  avg_order_value * purchase_frequency_per_day * customer_lifespan_days AS estimated_clv
FROM final;