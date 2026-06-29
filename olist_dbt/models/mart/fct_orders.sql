select
    o.order_id,
    oi.number_of_items,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    o.purchased_at,
    oi.price,
    oi.freight_value,
    r.gross_revenue
    from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
left join {{ ref('int_order_revenue') }} r
    on o.order_id = r.order_id
