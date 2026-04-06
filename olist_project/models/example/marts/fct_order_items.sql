{{ config(materialized='table') }}

SELECT
  oi.order_id,
  oi.product_id,
  p.product_category_name,
  oi.price,
  oi.freight_value

FROM {{ ref('stg_order_items') }} oi
LEFT JOIN {{ ref('stg_products') }} p USING (product_id)