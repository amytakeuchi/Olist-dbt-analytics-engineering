-- raw staging only
-- int_products_enriched.sql has category name in english
select p.product_id,
    t.category_english as category,
    p.product_name_lenght as name_length,
    p.product_description_lenght as description_length,
    p.product_photos_qty as number_of_photos,
    p.product_weight_g as weight_g
from {{ source('orders_raw', 'products_raw') }} p
left join olist_dev_staging.stg_category_name_translation t
    on p.product_category_name = t.category_portuguese