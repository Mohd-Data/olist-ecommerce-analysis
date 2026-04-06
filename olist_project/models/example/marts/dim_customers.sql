{{ config(materialized='table') }}

WITH ranked AS (select      customer_unique_id, 
                            customer_city, 
                            customer_state,
                            ROW_NUMBER()OVER(PARTITION BY customer_unique_id ORDER BY customer_id) AS rn

                FROM {{ ref('stg_customers') }})

SELECT    customer_unique_id,
          customer_city, 
          customer_state
FROM      ranked
WHERE     rn = 1