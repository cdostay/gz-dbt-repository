WITH sales_margin AS (

    SELECT *
    FROM {{ ref('int_sales_margin') }}

)

SELECT
    orders_id,
    MIN(date_date) AS date_date,
    SUM(turnover) AS gelir,
    SUM(qty) AS miktar,
    SUM(`satın_alma_maliyeti`) AS `satın_alma_maliyeti`,
    SUM(marj) AS marj
FROM sales_margin
GROUP BY orders_id