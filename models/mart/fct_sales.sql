{{ config(
    materialized='table',
    schema='MART'
) }}

WITH bridge AS (
    SELECT *
    FROM {{ ref('bridge_customer_product_store') }}
),

-- Dimensión Customer (última versión)
dim_customer AS (
    SELECT
        CUSTOMER_HK,
        CUSTOMER_NAME,
        SEGMENT,
        REGION,
        LOAD_DATE,
        ROW_NUMBER() OVER (
            PARTITION BY CUSTOMER_HK
            ORDER BY LOAD_DATE DESC
        ) AS rn
    FROM {{ ref('sat_customer_details') }}
),

current_customer AS (
    SELECT *
    FROM dim_customer
    WHERE rn = 1
),

-- Dimensión Product (última versión)
dim_product AS (
    SELECT
        PRODUCT_HK,
        PRODUCT_NAME,
        BRAND,
        CATEGORY,
        PACKAGE_TYPE,
        LIST_PRICE,
        LOAD_DATE,
        ROW_NUMBER() OVER (
            PARTITION BY PRODUCT_HK
            ORDER BY LOAD_DATE DESC
        ) AS rn
    FROM {{ ref('sat_product_details') }}
),

current_product AS (
    SELECT *
    FROM dim_product
    WHERE rn = 1
),

-- Dimensión Store (última versión)
dim_store AS (
    SELECT
        STORE_HK,
        STORE_NAME,
        CHANNEL,
        CITY,
        STATE,
        OPENED_AT,
        LOAD_DATE,
        ROW_NUMBER() OVER (
            PARTITION BY STORE_HK
            ORDER BY LOAD_DATE DESC
        ) AS rn
    FROM {{ ref('sat_store_details') }}
),

current_store AS (
    SELECT *
    FROM dim_store
    WHERE rn = 1
)

SELECT
    -- Keys
    b.CUSTOMER_HK,
    b.PRODUCT_HK,
    b.STORE_HK,

    -- Customer attrs
    c.CUSTOMER_NAME,
    c.SEGMENT       AS CUSTOMER_SEGMENT,
    c.REGION        AS CUSTOMER_REGION,

    -- Product attrs
    p.PRODUCT_NAME,
    p.BRAND,
    p.CATEGORY,
    p.PACKAGE_TYPE,
    p.LIST_PRICE,

    -- Store attrs
    s.STORE_NAME,
    s.CHANNEL      AS STORE_CHANNEL,
    s.CITY         AS STORE_CITY,
    s.STATE        AS STORE_STATE,

    -- Métricas
    b.TOTAL_QUANTITY,
    b.TOTAL_NET_AMOUNT,
    b.FIRST_ORDER_DATE,
    b.LAST_ORDER_DATE
FROM bridge b
LEFT JOIN current_customer c
    ON b.CUSTOMER_HK = c.CUSTOMER_HK
LEFT JOIN current_product p
    ON b.PRODUCT_HK = p.PRODUCT_HK
LEFT JOIN current_store s
    ON b.STORE_HK = s.STORE_HK
