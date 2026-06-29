select
    o.order_id,
    o.customer_id,
    c.city,
    c.state,

    o.purchased_at,
    o.delivered_at,
    o.order_status,

    date_diff(o.delivered_at, o.purchased_at, day) as delivery_duration,

    r.gross_revenue as order_revenue,

    case
        when o.delivered_at is null then 0
        else 1
    end as is_delivered

from {{ ref('stg_orders') }} o
left join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id
left join {{ ref('int_order_revenue') }} r
    on o.order_id = r.order_id