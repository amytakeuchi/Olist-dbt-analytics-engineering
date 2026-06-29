select 
    order_id,
    estimated_delivery_date,
    delivered_at as actual_delivery_date,
    date_diff(date(estimated_delivery_date), date(delivered_at), DAY) as delivery_delay_days,
    date_ship_by
from {{ ref('int_order_delivery_metrics') }}