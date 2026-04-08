-- Business Question:
-- Cohort analysis with retention

WITH base AS (SELECT
                customer_unique_id,
                DATE_TRUNC(order_purchase_timestamp, MONTH) AS order_month,
                DATE_TRUNC(MIN(order_purchase_timestamp) OVER (PARTITION BY customer_unique_id), MONTH) AS cohort_month
              FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fact_orders`
              WHERE order_status = "delivered"),

cohort_data AS (SELECT 
                  cohort_month,
                  DATE_DIFF(order_month, cohort_month, MONTH) month_number,
                  COUNT(DISTINCT customer_unique_id) AS customers
                FROM base
                GROUP BY cohort_month, order_month),

final AS (SELECT 
            *,
            MAX(CASE WHEN month_number = 0 THEN customers END) OVER (PARTITION BY cohort_month) AS cohort_size
          FROM cohort_data)
      

SELECT
  cohort_month,
  month_number,
  customers,
  cohort_size,
  SAFE_DIVIDE(customers, cohort_size) AS retention_rate
FROM  final
ORDER BY cohort_month, month_number