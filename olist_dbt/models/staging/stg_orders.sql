-- the grain is order_id
with base as (

    select
        *,
        row_number() over (
            partition by order_id
            order by order_purchase_timestamp desc
        ) as rn

    from {{ source('orders_raw','orders_raw') }}

)
select
    order_id,
    customer_id,
    order_status,

order_purchase_timestamp as purchased_at,

order_delivered_customer_date as delivered_at,
-- create a separate date with timestamp as 00:00:00
date(order_purchase_timestamp)
        as purchased_date,
date(order_delivered_customer_date)
        as delivered_date,
date(order_estimated_delivery_date)
        as estimated_delivery_date
from base
where rn = 1