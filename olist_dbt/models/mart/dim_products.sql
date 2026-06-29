select  
    p.product_id,
    p.category,
    p.weight_g


from {{ ref('stg_products') }} p