{{ config(
    schema='BUSINESS_VAULT',
    materialized='view',
    tags=['bridge']
) }}

WITH orders_enriched AS (
    SELECT
        lnk_order_customer.hk_customer,
        lnk_order_product.hk_product,
        sat_order.load_ts AS order_ts
    FROM {{ ref('lnk_order_customer') }} AS lnk_order_customer
    JOIN {{ ref('lnk_order_product') }}  AS lnk_order_product
        ON lnk_order_customer.hk_order = lnk_order_product.hk_order
    JOIN {{ ref('sat_order') }} AS sat_order
        ON lnk_order_customer.hk_order = sat_order.hk_order
)

SELECT
    hk_customer,
    hk_product,
    MIN(order_ts) AS first_order_date,
    MAX(order_ts) AS last_order_date,
    COUNT(*)      AS total_orders
FROM orders_enriched
GROUP BY 1,2
