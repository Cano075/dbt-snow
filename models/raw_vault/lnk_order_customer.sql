{{ config(materialized='table') }}

{%- set yaml_metadata -%}
src_pk: LNK_ORDER_CUSTOMER_HK
src_fk:
  - ORDER_HK
  - CUSTOMER_HK
src_ldts: LOAD_DATE
src_source: RECORD_SOURCE
source_model: v_stg_orders
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{{ automate_dv.link(**metadata_dict) }}
