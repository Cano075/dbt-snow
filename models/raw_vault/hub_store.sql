{{ config(materialized='table') }}

{%- set yaml_metadata -%}
src_pk: STORE_HK
src_nk: STORE_ID
src_ldts: LOAD_DATE
src_source: RECORD_SOURCE
source_model: v_stg_stores
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{{ automate_dv.hub(**metadata_dict) }}
