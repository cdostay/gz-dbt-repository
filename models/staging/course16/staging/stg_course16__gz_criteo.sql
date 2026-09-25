WITH source AS (

    SELECT *
    FROM {{ source('course16', 'gz_criteo') }}

),

renamed AS (

    SELECT
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        cost,
        impression,
        click
    FROM source

)

SELECT *
FROM renamed