{% macro snowflake__create_view_as(relation, sql) -%}
  {%- set sql_header = config.get('sql_header', none) -%}
  {%- set secure = config.get('secure', false) -%}

  create or replace
  {%- if secure %} secure{% endif %} view {{ relation }} as
  {%- if sql_header %} {{ sql_header }} {% endif -%}
  {{ sql }}
{%- endmacro %}
