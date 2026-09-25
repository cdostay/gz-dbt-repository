with 

source as (

    select * from {{ source('course16', 'gwz_ships') }}

),

renamed as (

    select
        orders_id,
        shipping_fee,
        log_cost,
        CAST(ship_cost AS INT64) AS ship_cost
    from source

)

select * from renamed