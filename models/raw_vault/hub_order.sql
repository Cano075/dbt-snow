{{ config(schema='RAW_VAULT', materialized='table') }}

WITH src AS (
  SELECT DISTINCT order_id
  FROM {{ ref('stg_orders') }}
)
SELECT
  {{ dv_hashkey(["'ORD|'", "order_id"]) }}              AS hk_order,
  order_id                                              AS bk_order,
  CURRENT_TIMESTAMP()                                   AS load_ts,
  'stg_orders'                                          AS record_source
FROM src;
