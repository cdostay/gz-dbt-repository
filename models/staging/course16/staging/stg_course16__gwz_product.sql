with 

source as (

    select * from {{ source('course16', 'gwz_product') }}

),

renamed as (

    select
        products_id,
        CAST(purchase_price AS FLOAT64) AS purchase_price
    from source

)

select * from renamed
