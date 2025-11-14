{{ config(
    materialized='view',
    schema='BUSINESS_VAULT'
) }}

WITH base AS (
    SELECT
        loc.CUSTOMER_HK,
        lop.PRODUCT_HK,
        los.STORE_HK,
        sof.ORDER_DATE,
        sof.QUANTITY,
        sof.NET_AMOUNT
    FROM {{ ref('lnk_order_customer') }} AS loc
    JOIN {{ ref('lnk_order_product') }} AS lop
        ON loc.ORDER_HK = lop.ORDER_HK
    JOIN {{ ref('lnk_order_store') }} AS los
        ON loc.ORDER_HK = los.ORDER_HK
    JOIN {{ ref('sat_order_facts') }} AS sof
        ON loc.ORDER_HK = sof.ORDER_HK
)

SELECT
    CUSTOMER_HK,
    PRODUCT_HK,
    STORE_HK,
    MIN(ORDER_DATE)      AS FIRST_ORDER_DATE,
    MAX(ORDER_DATE)      AS LAST_ORDER_DATE,
    SUM(QUANTITY)        AS TOTAL_QUANTITY,
    SUM(NET_AMOUNT)      AS TOTAL_NET_AMOUNT
FROM base
GROUP BY
    CUSTOMER_HK,
    PRODUCT_HK,
    STORE_HK
