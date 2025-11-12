{{ config(schema='RAW_VAULT', materialized='table') }}

SELECT
  {{ dv_hashkey(["'CUST|'", "customer_id"]) }}          AS hk_customer,
  {{ dv_hashdiff(["name", "region"]) }}                 AS hd_customer,
  name,
  region,
  CURRENT_TIMESTAMP()                                   AS load_ts,
  'stg_customers'                                       AS record_source
FROM {{ ref('stg_customers') }};
