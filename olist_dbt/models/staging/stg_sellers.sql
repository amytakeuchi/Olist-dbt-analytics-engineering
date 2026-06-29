select seller_id,
    seller_city,
    seller_state
from {{ source('orders_raw','sellers_raw') }}