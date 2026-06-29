select o.order_id,
    o.customer_id,
    o.purchased_at,
    r.gross_revenue,
    oi.number_of_items,
    c.delivery_duration,
    o.order_status
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
left join {{ ref('int_order_revenue') }} r
    on o.order_id = r.order_id
left join {{ ref('int_customer_orders') }} c
    on o.order_id = c.order_id
