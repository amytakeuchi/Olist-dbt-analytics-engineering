-- revenue by order
select distinct order_id, 
    round(sum(number_of_items*price), 2) as item_revenue,
    round(sum(freight_value), 0) as freight_revenue,
    round(sum(number_of_items * price) + sum(freight_value), 0) as gross_revenue
from {{ ref('stg_order_items') }}
group by 1