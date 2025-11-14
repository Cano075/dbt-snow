{{ config(materialized='table', schema='MART') }}

SELECT
    cust.region,
    prod.category,
    bridge.total_orders,
    bridge.first_order_date,
    bridge.last_order_date
FROM {{ ref('bridge_customer_product') }} AS bridge
JOIN {{ ref('sat_customer_details') }} AS cust
    ON bridge.hk_customer = cust.hk_customer
JOIN {{ ref('sat_product_details') }} AS prod
    ON bridge.hk_product = prod.hk_product;
