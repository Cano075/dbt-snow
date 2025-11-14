{{ config(materialized='table') }}

{%- set yaml_metadata -%}
src_pk: PRODUCT_HK
src_nk: PRODUCT_ID
src_ldts: LOAD_DATE
src_source: RECORD_SOURCE
source_model: {{ ref('v_stg_products') }}
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{{ automate_dv.hub(**metadata_dict) }}
