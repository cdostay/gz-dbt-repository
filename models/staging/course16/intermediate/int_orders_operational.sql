WITH orders_margin AS (

    SELECT *
    FROM {{ ref('int_orders_margin') }}

),

ships AS (

    SELECT *
    FROM {{ ref('stg_course16__gwz_ships') }}

),

joined AS (

    SELECT
        orders_margin.orders_id,
        orders_margin.date_date,
        orders_margin.marj,
        ships.shipping_fee,
        ships.log_cost,
        ships.ship_cost
    FROM orders_margin
    LEFT JOIN ships
        ON orders_margin.orders_id = ships.orders_id

)

SELECT
    orders_id,
    date_date,
    marj + shipping_fee - log_cost - ship_cost AS operasyonel_marj
FROM joined