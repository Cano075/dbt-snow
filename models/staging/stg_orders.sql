{{ config(schema='STAGING', materialized='view') }}

SELECT
  order_id,
  customer_id,
  product_id,
  TO_TIMESTAMP_NTZ(order_date) AS order_date,
  quantity::NUMBER(18,0) AS quantity,
  amount::NUMBER(18,2)  AS amount
FROM {{ source('landing', 'orders') }}
