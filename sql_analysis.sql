-- Olist E-Commerce Analytics
-- Database: olist_ecommerce

USE olist_ecommerce;

-- 1. Total revenue, order items, and orders with items
SELECT
    ROUND(SUM(price), 2) AS total_revenue,
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT order_id) AS orders_with_items
FROM order_items;

-- 2. Average order value
SELECT
    ROUND(SUM(price) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM order_items;

-- 3. Monthly revenue trend
SELECT
    DATE_FORMAT(
        STR_TO_DATE(o.order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'),
        '%Y-%m'
    ) AS order_month,
    ROUND(SUM(oi.price), 2) AS monthly_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
  AND o.order_purchase_timestamp <> ''
GROUP BY order_month
ORDER BY order_month;

-- 4. Top product categories by revenue
SELECT
    COALESCE(ct.product_category_name_english,
             p.product_category_name) AS product_category,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(*) AS total_items
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. Delivery performance
SELECT
    CASE
        WHEN order_delivered_customer_date IS NULL
             OR order_delivered_customer_date = ''
            THEN 'Not Delivered'
        WHEN STR_TO_DATE(order_delivered_customer_date,
                         '%Y-%m-%d %H:%i:%s')
             <= STR_TO_DATE(order_estimated_delivery_date,
                            '%Y-%m-%d %H:%i:%s')
            THEN 'On Time or Early'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- 6. Customer review ratings
SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM order_reviews),
        2
    ) AS percentage_of_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- 7. Order status breakdown
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
