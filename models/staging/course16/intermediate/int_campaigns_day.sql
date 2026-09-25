WITH campaigns AS (

    SELECT *
    FROM {{ ref('int_campaigns') }}

)

SELECT
    date_date,
    SUM(cost) AS ads_cost,
    SUM(impression) AS ads_impression,
    SUM(click) AS ads_clicks
FROM campaigns
GROUP BY date_date
ORDER BY date_date DESC