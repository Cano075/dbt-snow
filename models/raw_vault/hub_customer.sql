{{ config(materialized='table') }}

{%- set yaml_metadata -%}
src_pk: CUSTOMER_HK
src_nk: CUSTOMER_ID
src_ldts: LOAD_DATE
src_source: RECORD_SOURCE
source_model: {{ ref('v_stg_customers') }}
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{{ automate_dv.hub(**metadata_dict) }}
