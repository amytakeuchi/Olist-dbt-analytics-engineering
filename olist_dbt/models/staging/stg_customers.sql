select customer_id,
    customer_unique_id,
    customer_city as city,
    customer_state as state
from {{ source('orders_raw','customers_raw') }}