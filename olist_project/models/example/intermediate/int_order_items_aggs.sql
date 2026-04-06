{{ config(materialized='table') }}

SELECT      order_id, COUNT(order_id) AS item_count, 
            SUM(price) AS total_price, SUM(freight_value) AS freight_value
FROM        {{ ref('stg_order_items') }}
GROUP BY    order_id