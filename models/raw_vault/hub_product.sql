{{ config(schema='RAW_VAULT', materialized='table') }}

WITH src AS (
  SELECT DISTINCT product_id
  FROM {{ ref('stg_products') }}
)
SELECT
  {{ dv_hashkey(["'PROD|'", "product_id"]) }}           AS hk_product,
  product_id                                            AS bk_product,
  CURRENT_TIMESTAMP()                                   AS load_ts,
  'stg_products'                                        AS record_source
FROM src;
