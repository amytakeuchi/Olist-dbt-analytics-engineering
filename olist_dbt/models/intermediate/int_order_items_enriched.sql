select  
    o.order_id,
    oi.number_of_items,
    o.purchased_at,
    o.order_status,
    oi.product_id,
    p.category as product_category,
    oi.seller_id,
    s.seller_city,
    s.seller_state,
    r.item_revenue,
    r.freight_revenue,
    r.gross_revenue,
    oi.date_ship_by
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
left join {{ ref('stg_products') }} p
    on p.product_id = oi.product_id
left join {{ ref('stg_sellers') }} s
    on s.seller_id = oi.seller_id
left join {{ ref('int_order_revenue') }} r
    on o.order_id = r.order_id