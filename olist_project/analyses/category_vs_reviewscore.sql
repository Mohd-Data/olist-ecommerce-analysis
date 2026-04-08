WITH latest_orders AS (SELECT order_id, review_score   
                        FROM
                            (SELECT 
                            order_id,
                            review_score,
                            ROW_NUMBER()OVER(PARTITION BY order_id ORDER BY review_creation_date DESC) AS rn
                            FROM `olist-e-commerce-analysis.olist_raw.stg_order_reviews`)
                        WHERE rn =1 )
  
SELECT 
    oi.product_category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(lr.order_id) AS reviewed_orders,
    SAFE_DIVIDE(COUNT(lr.order_id),COUNT(DISTINCT oi.order_id)) AS review_rate,
    AVG(lr.review_score) AS average_review,
    SUM(oi.price) AS total_revenue
FROM `olist-e-commerce-analysis.olist_raw.fct_order_items` oi
LEFT JOIN latest_orders lr ON oi.order_id = lr.order_id
GROUP BY oi.product_category_name
ORDER BY total_revenue DESC;