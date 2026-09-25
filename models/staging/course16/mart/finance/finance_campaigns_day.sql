{{ config(
    materialized='table',
    schema='finance'
) }}

WITH finance AS (

    SELECT *
    FROM {{ ref('finance_days') }}

),

campaigns AS (

    SELECT *
    FROM {{ ref('int_campaigns_day') }}

)

SELECT
    finance.date_date,
    finance.toplam_gelir,
    finance.toplam_operasyonel_marj,
    finance.`toplam_satın_alma_maliyeti`,
    finance.toplam_nakliye_ucreti,
    finance.toplam_log_maliyeti,
    finance.toplam_miktar,
    campaigns.ads_cost,
    campaigns.ads_impression,
    campaigns.ads_clicks,
    finance.toplam_operasyonel_marj - campaigns.ads_cost AS campaign_marj

FROM finance

LEFT JOIN campaigns
    ON finance.date_date = campaigns.date_date

ORDER BY finance.date_date DESC