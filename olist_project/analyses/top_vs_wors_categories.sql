-- Business Question:
-- Segment product categories based on revenue and customer satisfaction

WITH latest_review AS (SELECT 
                              order_id, 
                              review_score
                        FROM (SELECT 
                                    order_id, 
                                    review_score,
                                    ROW_NUMBER()OVER(PARTITION BY order_id ORDER BY review_creation_date DESC) AS rn
                              FROM `olist-e-commerce-analysis.olist_raw.stg_order_reviews`)
                        WHERE rn =1),

category_metrics AS (SELECT 
                              COALESCE(oi.product_category_name, "unknown") AS product_category_name,
                              SUM(oi.price) AS total_revenue,
                              AVG(lr.review_score) AS avg_review_score
                        FROM `olist-e-commerce-analysis.olist_raw_olist_raw.fct_order_items` oi
                        LEFT JOIN latest_review lr ON oi.order_id = lr.order_id
                        GROUP BY oi.product_category_name),

ranked AS (SELECT *,
                  NTILE(4)OVER(ORDER BY total_revenue DESC) AS revenue_quartile,
                  NTILE(4)OVER(ORDER BY avg_review_score) AS review_quartile
            FROM category_metrics
            ORDER BY revenue_quartile, review_quartile)

SELECT
      product_category_name, total_revenue, avg_review_score,
      CASE  WHEN revenue_quartile = 1 AND review_quartile = 1 THEN "Top Performer"
            WHEN revenue_quartile = 1 AND review_quartile <=3 THEN "High Revenue - Low Satisfaction"
            WHEN revenue_quartile >=3 AND review_quartile = 1 THEN "Low Revenue - High Satisfaction"
            WHEN revenue_quartile <=3 AND review_quartile <=3 THEN "Underperformers"
            ELSE "Mid Performers"
      END AS category_label
FROM ranked
ORDER BY total_revenue DESC