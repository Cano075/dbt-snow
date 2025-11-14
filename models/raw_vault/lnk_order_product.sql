{{ config(materialized='table') }}

{%- set yaml_metadata -%}
src_pk: ORDER_PRODUCT_HK
src_fk:
  - ORDER_HK
  - PRODUCT_HK
src_ldts: LOAD_DATE
src_source: RECORD_SOURCE
source_model: {{ ref('v_stg_orders') }}
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{{ automate_dv.link(**metadata_dict) }}
