{{ config(materialized='table') }}


WITH orders_margin AS (

    SELECT *
    FROM {{ ref('int_orders_margin') }}

),

operational AS (

    SELECT *
    FROM {{ ref('int_orders_operational') }}

),

ships AS (

    SELECT *
    FROM {{ ref('stg_course16__gwz_ships') }}

),

joined AS (

    SELECT
        orders_margin.date_date,
        orders_margin.gelir,
        orders_margin.miktar,
        orders_margin.`satın_alma_maliyeti`,
        operational.operasyonel_marj,
        ships.shipping_fee,
        ships.log_cost
    FROM orders_margin
    LEFT JOIN operational
        ON orders_margin.orders_id = operational.orders_id
    LEFT JOIN ships
        ON orders_margin.orders_id = ships.orders_id

)

SELECT
    date_date,
    ROUND(SUM(gelir),2) AS toplam_gelir,
    ROUND(SUM(operasyonel_marj),2) AS toplam_operasyonel_marj,
    ROUND(SUM(`satın_alma_maliyeti`),2) AS `toplam_satın_alma_maliyeti`,
    ROUND(SUM(shipping_fee),2) AS toplam_nakliye_ucreti,
    ROUND(SUM(log_cost),2) AS toplam_log_maliyeti,
    SUM(miktar) AS toplam_miktar
FROM joined
GROUP BY date_date