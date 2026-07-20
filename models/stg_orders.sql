SELECT 
    id AS order_id,
    customer AS customer_id,
    ordered_at,
    store_id,
    subtotal,
    tax_paid,
    order_total
FROM `july-2026-project.raw_jaffle_shop.orders`