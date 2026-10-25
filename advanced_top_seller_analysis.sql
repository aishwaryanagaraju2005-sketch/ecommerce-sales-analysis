use ecommerce_sales;
WITH seller_sales AS (
    SELECT
        oi.seller_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM order_items oi
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY oi.seller_id
),
ranked_sellers AS (
    SELECT
        seller_id,
        total_orders,
        total_revenue,
        DENSE_RANK() OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM seller_sales
)
SELECT
    revenue_rank,
    seller_id,
    total_orders,
    total_revenue
FROM ranked_sellers
WHERE revenue_rank <= 10
ORDER BY revenue_rank;