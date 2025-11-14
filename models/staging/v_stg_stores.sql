{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  staging: "STORES"
derived_columns:
  RECORD_SOURCE: "!STG_STORES"
  LOAD_DATE: "OPENED_AT"
  EFFECTIVE_FROM: "OPENED_AT"
hashed_columns:
  STORE_HK: "STORE_ID"
  STORE_HASHDIFF:
    is_hashdiff: true
    columns:
      - "STORE_NAME"
      - "CHANNEL"
      - "CITY"
      - "STATE"
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
