-- grain: customerid
with order_revenue as(
select o.order_id,
        o.customer_id,
        o.purchased_at,
        r.gross_revenue as revenue,
        oi.number_of_items
from {{ref('stg_orders') }} o
left join {{ref('int_order_revenue') }} r
on o.order_id = r.order_id
inner join {{ref('stg_order_items') }} oi
on o.order_id = oi.order_id
)
select
    customer_id,

    min(purchased_at)as first_order_date,
    max(purchased_at)as last_order_date,

count(distinct order_id)as total_orders,

    sum(revenue) as total_revenue,

    avg(revenue) as avg_order_value,
    
    number_of_items

from order_revenue
group by customer_id, number_of_items