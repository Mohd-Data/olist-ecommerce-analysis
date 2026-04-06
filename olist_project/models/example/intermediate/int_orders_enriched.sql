{{ config(materialized='table') }}

SELECT
  order_id,
  customer_id,
  order_status,
  order_purchase_timestamp,
  order_approved_at,
  order_delivered_customer_date,
  order_estimated_delivery_date,
  
  TIMESTAMP_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) AS delivery_days,
  TIMESTAMP_DIFF(order_approved_at, order_purchase_timestamp, DAY) AS approval_days,
  CASE
    WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
    ELSE 0
  END AS is_delayed

FROM {{ ref('stg_orders') }}