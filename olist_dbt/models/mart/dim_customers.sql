select c.customer_id,
    c.city,
    c.state,
    clv.first_order_date,
    clv.last_order_date
from {{ ref('stg_customers') }} c
left join {{ ref('int_customer_lifetime_value') }} clv
on c.customer_id = clv.customer_id