{% macro dv_hashkey(args) -%}
    -- Returns a stable MD5 over concatenated args
    MD5(UPPER(TRIM(CONCAT({{ args | join(",") }}))))
{%- endmacro %}

{% macro dv_hashdiff(cols) -%}
    -- MD5 over a concatenation of descriptive columns (for Sats change capture)
    MD5(UPPER(TRIM(CONCAT({{ cols | join(",") }}))))
{%- endmacro %}
