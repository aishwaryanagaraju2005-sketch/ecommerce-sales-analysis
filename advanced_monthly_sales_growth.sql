USE ecommerce_sales;
WITH RECURSIVE monthly_calendar AS (
    SELECT DATE('2016-09-01') AS sales_month
    UNION ALL
    SELECT DATE_ADD(sales_month, INTERVAL 1 MONTH)
    FROM monthly_calendar
    WHERE sales_month < '2018-10-01'
),
monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS sales_month,
        ROUND(SUM(oi.price), 2) AS total_sales
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01')
),
complete_monthly_sales AS (
    SELECT
        c.sales_month,
        COALESCE(ms.total_sales, 0) AS total_sales
    FROM monthly_calendar c
    LEFT JOIN monthly_sales ms
        ON c.sales_month = ms.sales_month
),
sales_with_previous_month AS (
    SELECT
        sales_month,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY sales_month
        ) AS previous_month_sales
    FROM complete_monthly_sales
)
SELECT
    DATE_FORMAT(sales_month, '%Y-%m') AS sales_month,
    total_sales,
    previous_month_sales,
    CASE
        WHEN previous_month_sales IS NULL
          OR previous_month_sales = 0
        THEN NULL
        ELSE ROUND(
            (total_sales - previous_month_sales)
            / previous_month_sales * 100,
            2
        )
    END AS mom_growth_percentage
FROM sales_with_previous_month
ORDER BY sales_month;