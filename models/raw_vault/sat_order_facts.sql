{{ config(schema='RAW_VAULT', materialized='table') }}

SELECT
  {{ dv_hashkey(["'ORD|'", "order_id"]) }}              AS hk_order,
  {{ dv_hashdiff(["TO_VARCHAR(order_date)", "TO_VARCHAR(quantity)", "TO_VARCHAR(amount)"]) }} AS hd_order,
  order_date,
  quantity,
  amount,
  CURRENT_TIMESTAMP()                                   AS load_ts,
  'stg_orders'                                          AS record_source
FROM {{ ref('stg_orders') }};
