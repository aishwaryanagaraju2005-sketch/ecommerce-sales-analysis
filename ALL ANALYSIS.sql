USE ecommerce_sales;

SELECT COUNT(*) AS total_reviews
FROM reviews;

USE ecommerce_sales;

SELECT * FROM reviews LIMIT 5;
SHOW CREATE TABLE reviews;

USE ecommerce_sales;

SELECT COUNT(*) AS total_reviews FROM reviews;

SELECT review_id, COUNT(*) AS copies
FROM reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

SELECT DATABASE() AS current_database,
       @@hostname AS server_name,
       @@port AS server_port;


 USE ecommerce_sales;

SELECT 'customers' AS table_name, COUNT(*) AS total_records FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;    




USE ecommerce_sales;

SELECT
    ROUND(SUM(price), 2) AS total_sales_revenue
FROM order_items;

USE ecommerce_sales;

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;



USE ecommerce_sales;

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS sales_month,
    ROUND(SUM(oi.price), 2) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY monthly_revenue DESC
LIMIT 10;


USE ecommerce_sales;

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY total_orders DESC
LIMIT 10;


USE ecommerce_sales;

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;


USE ecommerce_sales;

SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_values;


USE ecommerce_sales;

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

USE ecommerce_sales;

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;