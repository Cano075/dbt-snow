{{ config(schema='RAW_VAULT', materialized='table') }}

WITH src AS (
  SELECT DISTINCT order_id, product_id
  FROM {{ ref('stg_orders') }}
)
SELECT
  {{ dv_hashkey(["'ORD|'", "order_id"]) }}              AS hk_order,
  {{ dv_hashkey(["'PROD|'", "product_id"]) }}           AS hk_product,
  {{ dv_hashkey(["'LNK_OP|'", "order_id", "product_id"]) }} AS hk_lnk_order_product,
  CURRENT_TIMESTAMP()                                   AS load_ts,
  'stg_orders'                                          AS record_source
FROM src;
