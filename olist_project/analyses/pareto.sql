WITH customer_revenue AS (SELECT 
                            customer_unique_id, 
                            SUM(total_payment) AS total_revenue
                          FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fact_orders`
                          WHERE order_status = "delivered" AND total_payment IS NOT NULL
                          GROUP BY customer_unique_id
                          ORDER BY total_revenue DESC),

ranked_customers AS (SELECT
                        customer_unique_id,
                        total_revenue,
                        COUNT(*) OVER () AS total_customer,
                        SUM(total_revenue) OVER () AS total_revenue_all,
                        ROW_NUMBER()OVER(ORDER BY total_revenue DESC) AS customer_rank,
                        SUM(total_revenue)OVER(ORDER BY total_revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cummilative_total 
                      FROM customer_revenue)

SELECT
   customer_unique_id,
  total_revenue,
  customer_rank,
  cummilative_total,
  ROUND(SAFE_DIVIDE(customer_rank,total_customer)) AS customer_percent,
  ROUND(SAFE_DIVIDE(cummilative_total,total_revenue_all)) AS revenue_percent
FROM ranked_customers