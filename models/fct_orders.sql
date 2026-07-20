WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

items AS (
    SELECT * FROM {{ ref('stg_items') }}
),

order_item_summary AS (
    SELECT 
        order_id,
        COUNT(item_id) AS total_items
    FROM items
    GROUP BY 1
),

final AS (
    SELECT 
        orders.order_id,
        orders.customer_id,
        orders.store_id,
        orders.ordered_at,
        orders.subtotal,
        orders.tax_paid,
        orders.order_total,
        COALESCE(order_item_summary.total_items, 0) AS total_items
    FROM orders
    LEFT JOIN order_item_summary USING (order_id)
)

SELECT * FROM final