WITH adwords AS (

    SELECT *
    FROM {{ ref('stg_course16__gz_adwords') }}

),

bing AS (

    SELECT *
    FROM {{ ref('stg_course16__gz_bing') }}

),

criteo AS (

    SELECT *
    FROM {{ ref('stg_course16__gz_criteo') }}

),

facebook AS (

    SELECT *
    FROM {{ ref('stg_course16__gz_facebook') }}

),

campaigns AS (

    SELECT * FROM adwords

    UNION ALL

    SELECT * FROM bing

    UNION ALL

    SELECT * FROM criteo

    UNION ALL

    SELECT * FROM facebook

)

SELECT *
FROM campaigns