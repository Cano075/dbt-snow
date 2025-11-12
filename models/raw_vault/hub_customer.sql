{{ config(schema='RAW_VAULT', materialized='table') }}

WITH src AS (
  SELECT DISTINCT customer_id
  FROM {{ ref('stg_customers') }}
)
SELECT
  {{ dv_hashkey(["'CUST|'", "customer_id"]) }}          AS hk_customer,
  customer_id                                           AS bk_customer,
  CURRENT_TIMESTAMP()                                   AS load_ts,
  'stg_customers'                                       AS record_source
FROM src;
