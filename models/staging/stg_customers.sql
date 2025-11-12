{{ config(schema='STAGING', materialized='view') }}

SELECT
  customer_id,
  name,
  region,
  TO_TIMESTAMP_NTZ(created_at) AS created_at
FROM {{ source('landing', 'customers') }}
