select order_id,
    payment_sequential as payment_sequence_number,
    payment_type,
    payment_installments as number_of_installments,
    payment_value as payment_amount
from {{ source('orders_raw','order_payments_raw') }}