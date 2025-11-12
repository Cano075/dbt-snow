{% macro snowflake__create_table_as(relation, sql) -%}
  create or replace transient table {{ relation }} as
  {{ sql }}
{%- endmacro %}
