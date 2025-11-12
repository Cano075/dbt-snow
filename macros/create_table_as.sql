{% macro snowflake__create_table_as(temporary, relation, sql) -%}
    create or replace {% if temporary %}{{ temporary }}{% endif %} table {{ relation }} as
    {{ sql }}
{%- endmacro %}