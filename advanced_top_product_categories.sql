
use ecommerce_sales;
WITH category_sales AS (
    SELECT
        COALESCE(p.product_category_name, 'Unknown') AS category,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY COALESCE(p.product_category_name, 'Unknown')
),
ranked_categories AS (
    SELECT
        category,
        total_revenue,
        DENSE_RANK() OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM category_sales
)
SELECT
    revenue_rank,
    category,
    total_revenue
FROM ranked_categories
WHERE revenue_rank <= 5
ORDER BY revenue_rank;