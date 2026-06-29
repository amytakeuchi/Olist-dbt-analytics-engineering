
select string_field_0 as category_portuguese,
    string_field_1 as category_english
from {{ source('orders_raw','category_name_translation_raw') }}