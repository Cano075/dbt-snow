{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  staging: "ORDERS"
derived_columns:
  RECORD_SOURCE: "!STG_ORDERS"
  LOAD_DATE: "ORDER_DATE"
  EFFECTIVE_FROM: "ORDER_DATE"
hashed_columns:
  ORDER_HK: "ORDER_ID"
  CUSTOMER_HK: "CUSTOMER_ID"
  PRODUCT_HK: "PRODUCT_ID"
  STORE_HK: "STORE_ID"
  ORDER_HASHDIFF:
    is_hashdiff: true
    columns:
      - "ORDER_DATE"
      - "QUANTITY"
      - "GROSS_AMOUNT"
      - "DISCOUNT_AMOUNT"
      - "NET_AMOUNT"
{%- endset -%}

{% set metadata_dict   = fromyaml(yaml_metadata) %}
{% set source_model    = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns  = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(
     include_source_columns=true,
     source_model=source_model,
     derived_columns=derived_columns,
     null_columns=none,
     hashed_columns=hashed_columns,
     ranked_columns=none
) }}
