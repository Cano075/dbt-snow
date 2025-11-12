{% macro create_table_as(temporary, relation, sql) -%}
    create or replace {{ temporary }} table {{ relation }} as
    {{ sql }}
{%- endmacro %}