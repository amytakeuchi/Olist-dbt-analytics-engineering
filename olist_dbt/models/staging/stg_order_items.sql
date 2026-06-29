with base as (

    select
        *,
        row_number() over (
            partition by order_id
            order by shipping_limit_date desc
        ) as rn

    from {{ source('orders_raw','order_items_raw') }}

)

select order_id,
    order_item_id as number_of_items,
    product_id,
    seller_id,
    shipping_limit_date as ship_by,
    date(shipping_limit_date) as date_ship_by,
    price,
    freight_value
from base
where rn = 1