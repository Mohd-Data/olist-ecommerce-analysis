{{ config(materialized='table') }}

SELECT
  o.order_id,
  o.customer_id,
  c.customer_unique_id,
  o.order_status,
  o.order_purchase_timestamp,
  o.order_approved_at,
  o.order_delivered_customer_date,
  o.order_estimated_delivery_date,
  o.delivery_days,
  o.approval_days,
  o.is_delayed,
  p.total_payment,
  i.item_count,
  i.total_price,
  i.freight_value,
  r.review_score

FROM {{ ref('int_orders_enriched') }} o
LEFT JOIN {{ ref('stg_customers') }} c USING (customer_id)
LEFT JOIN {{ ref('int_order_payments_aggs') }} p USING (order_id)
LEFT JOIN {{ ref('int_order_items_aggs') }} i USING (order_id)
LEFT JOIN {{ ref('stg_order_reviews') }} r USING (order_id)