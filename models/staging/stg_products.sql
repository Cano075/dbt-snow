{{ config(schema='RAW_VAULT', materialized='view') }}

SELECT
  product_id,
  product_name,
  category,
  price::NUMBER(18,2) AS price
FROM {{ source('staging', 'products') }}
