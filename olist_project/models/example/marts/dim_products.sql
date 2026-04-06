{{ config(materialized='table') }}

SELECT
  product_id,
  product_category_name
FROM {{ ref('stg_products') }}