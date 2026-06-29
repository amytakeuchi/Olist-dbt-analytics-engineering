select customer_id,
-- need to update here later from order_items table
    count(order_id) as total_orders,
    sum(order_revenue) as total_spent,
    avg(order_revenue) as avg_order_value,
    min(purchased_at) as first_order_date,
    max(purchased_at) as last_order_date
from {{ ref('int_customer_orders') }}
group by customer_id