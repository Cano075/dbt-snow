{{ config(schema='MART', materialized='table') }}

WITH joined AS (
  SELECT
    so.hk_order,
    sc.name                      AS customer_name,
    sp.product_name,
    so.quantity,
    so.amount,
    so.order_date
  FROM {{ ref('sat_order_facts') }} so
  JOIN {{ ref('lnk_order_customer') }} oc ON oc.hk_order = so.hk_order
  JOIN {{ ref('lnk_order_product')  }} op ON op.hk_order = so.hk_order
  JOIN {{ ref('sat_customer_details') }} sc ON sc.hk_customer = oc.hk_customer
  JOIN {{ ref('sat_product_details')  }} sp ON sp.hk_product  = op.hk_product
)
SELECT
  customer_name,
  product_name,
  COUNT(*)              AS order_count,
  SUM(quantity)         AS total_qty,
  SUM(amount)           AS total_sales,
  MIN(order_date)       AS first_order,
  MAX(order_date)       AS last_order
FROM joined
GROUP BY 1,2;
