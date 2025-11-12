{{ config(schema='BUSINESS_VAULT', materialized='view') }}

-- Simple PIT example: last load per order (for demo)
SELECT
  o.hk_order,
  MAX(o.load_ts) AS last_load_ts
FROM {{ ref('sat_order_facts') }} o
GROUP BY 1;
