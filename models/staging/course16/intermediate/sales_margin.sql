WITH sales AS (

    SELECT *
    FROM {{ ref('stg_gz_raw_data__raw_gz_sales') }}

),

product AS (

    SELECT *
    FROM {{ ref('stg_course16__gwz_product') }}

),

joined AS (

    SELECT
        sales.*,
        product.purchase_price
    FROM sales
    LEFT JOIN product
        ON sales.products_id = product.products_id

)

SELECT
    *,
    qty * purchase_price AS `satın_alma_maliyeti`,
    turnover - (qty * purchase_price) AS marj
FROM joined