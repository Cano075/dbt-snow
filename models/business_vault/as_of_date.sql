{{ config(
    materialized='table',
    schema='BUSINESS_VAULT'
) }}

{%- set datepart    = "day" -%}
{%- set start_date = "TO_DATE('2020-01-01','YYYY-MM-DD')" -%}
{%- set end_date   = "CURRENT_DATE() + 1" -%}

WITH as_of_date AS (
    {{ dbt_utils.date_spine(
        datepart=datepart,
        start_date=start_date,
        end_date=end_date
    ) }}
)

SELECT
    DATE_{{ datepart }} AS AS_OF_DATE
FROM as_of_date
