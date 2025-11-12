{{ config(schema='RAW_VAULT', materialized='table') }}

WITH src AS (
  SELECT DISTINCT order_id, customer_id
  FROM {{ ref('stg_orders') }}
)
SELECT
  {{ dv_hashkey(["'ORD|'", "order_id"]) }}              AS hk_order,
  {{ dv_hashkey(["'CUST|'", "customer_id"]) }}          AS hk_customer,
  {{ dv_hashkey(["'LNK_OC|'", "order_id", "customer_id"]) }} AS hk_lnk_order_customer,
  CURRENT_TIMESTAMP()                                   AS load_ts,
  'stg_orders'                                          AS record_source
FROM src;
