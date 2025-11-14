{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  staging: "CUSTOMERS"          # source('staging','CUSTOMERS')
derived_columns:
  RECORD_SOURCE: "!STG_CUSTOMERS"
  LOAD_DATE: "CREATED_AT"
  EFFECTIVE_FROM: "CREATED_AT"
hashed_columns:
  CUSTOMER_HK: "CUSTOMER_ID"
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - "CUSTOMER_NAME"
      - "SEGMENT"
      - "REGION"
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
