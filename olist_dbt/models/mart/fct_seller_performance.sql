select 
    oi.seller_id,
    count(o.order_id) as total_orders,
    sum(r.gross_revenue) as total_revenue,
    round(avg(c.delivery_duration), 2) as avg_delivery_time,
    round(100.0*sum(case when c.is_delivered = 0 then 1 else 0 end)/count(o.order_id), 2) as cancellation_rate
from {{ ref('stg_order_items') }} oi
left join {{ ref('stg_orders') }} o
    on o.order_id = oi.order_id
left join {{ ref('int_order_revenue') }} r
    on o.order_id = r.order_id
left join {{ ref('int_customer_orders') }} c
    on o.customer_id = c.customer_id
group by 1