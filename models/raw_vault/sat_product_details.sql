{{ config(schema='RAW_VAULT', materialized='table') }}

SELECT
  {{ dv_hashkey(["'PROD|'", "product_id"]) }}           AS hk_product,
  {{ dv_hashdiff(["product_name", "category", "TO_VARCHAR(price)"]) }} AS hd_product,
  product_name,
  category,
  price,
  CURRENT_TIMESTAMP()                                   AS load_ts,
  'stg_products'                                        AS record_source
FROM {{ ref('stg_products') }};
