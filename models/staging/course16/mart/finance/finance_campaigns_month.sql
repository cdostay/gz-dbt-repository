{{ config(
    materialized='table',
    schema='finance'
) }}

WITH daily AS (

    SELECT *
    FROM {{ ref('finance_campaigns_day') }}

)

SELECT
    DATE_TRUNC(date_date, MONTH) AS datemonth,

    SUM(toplam_operasyonel_marj - ads_cost) AS ads_margin,
    SAFE_DIVIDE(SUM(toplam_gelir), SUM(toplam_miktar)) AS average_basket,
    SUM(toplam_operasyonel_marj) AS operational_margin,

    SUM(ads_cost) AS ads_cost,
    SUM(ads_impression) AS ads_impression,
    SUM(ads_clicks) AS ads_clicks,

    SUM(toplam_miktar) AS quantity,
    SUM(toplam_gelir) AS revenue,
    SUM(`toplam_satın_alma_maliyeti`) AS purchase_cost,

    SUM(toplam_operasyonel_marj
        - toplam_nakliye_ucreti
        + toplam_log_maliyeti
        + toplam_nakliye_ucreti) AS margin,

    SUM(toplam_nakliye_ucreti) AS shipping_fee,
    SUM(toplam_log_maliyeti) AS log_cost

FROM daily

GROUP BY datemonth

ORDER BY datemonth DESC