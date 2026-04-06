{{ config(materialized='table') }}

SELECT
  order_id,
  SUM(payment_value) AS total_payment
FROM {{ ref('stg_order_payments') }}
GROUP BY order_id