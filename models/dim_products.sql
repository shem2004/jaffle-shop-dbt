with products as (
    select * from {{ ref('stg_products') }}
),

supplies as (
    select * from {{ ref('stg_supplies') }}
),


supply_costs as (
    select
        product_sku,
        sum(cost) as total_supply_cost
    from supplies
    group by 1
),


final as (
    select
        products.product_sku,
        products.product_name,
        products.price,
        supply_costs.total_supply_cost,
        (products.price - supply_costs.total_supply_cost) as profit_margin
    from products
    left join supply_costs on products.product_sku = supply_costs.product_sku
)

select * from final