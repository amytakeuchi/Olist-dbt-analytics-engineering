-- grain: order_id
-- from stg_orders: delivered_at, Delivered_date, estimated delivery date
-- from stg_order_items: ship_by, date_ship_by
select o.order_id,
    o.delivered_at,
    o.delivered_date,
    o.estimated_delivery_date,
    oi.ship_by,
    oi.date_ship_by
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id