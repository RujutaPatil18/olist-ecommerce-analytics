USE olist_ecommerce;
-- Total sales revenu
SELECT
	ROUND(SUM(price),2) AS total_revenue,
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT order_id) AS total_orders
FROM order_items;

-- Analyze monthly sales trends 
SELECT
    DATE_FORMAT(
        STR_TO_DATE(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(oi.price), 2) AS monthly_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
GROUP BY sales_month
ORDER BY sales_month;

-- Top 10 Product Categories which generate most of revenue

SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(*) AS items_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 10;

-- Analyze order delivery performance

SELECT
    CASE
        WHEN order_delivered_customer_date IS NULL
             OR order_delivered_customer_date = ''
            THEN 'Not Delivered'
        WHEN STR_TO_DATE(
                 order_delivered_customer_date,
                 '%Y-%m-%d %H:%i:%s'
             ) >
             STR_TO_DATE(
                 order_estimated_delivery_date,
                 '%Y-%m-%d %H:%i:%s'
             )
            THEN 'Late'
        ELSE 'On Time or Early'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- Calculate the late delivery percentage using SQL

SELECT
    COUNT(*) AS delivered_orders,
    SUM(
        CASE
            WHEN STR_TO_DATE(
                order_delivered_customer_date,
                '%Y-%m-%d %H:%i:%s'
            ) >
            STR_TO_DATE(
                order_estimated_delivery_date,
                '%Y-%m-%d %H:%i:%s'
            )
            THEN 1
            ELSE 0
        END
    ) AS late_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN STR_TO_DATE(
                    order_delivered_customer_date,
                    '%Y-%m-%d %H:%i:%s'
                ) >
                STR_TO_DATE(
                    order_estimated_delivery_date,
                    '%Y-%m-%d %H:%i:%s'
                )
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date <> '';

-- Analyse customer satisfaction

SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM order_reviews),
        2
    ) AS percentage
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

-- Find the monthly order trend

SELECT
    DATE_FORMAT(
        STR_TO_DATE(
            order_purchase_timestamp,
            '%Y-%m-%d %H:%i:%s'
        ),
        '%Y-%m'
    ) AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- Calculate the average order value (AOV)


SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price), 2) AS total_item_revenue,
    ROUND(
        SUM(price) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM order_items;



SELECT
    DATE_FORMAT(
        STR_TO_DATE(
            o.order_purchase_timestamp,
            '%Y-%m-%d %H:%i:%s'
        ),
        '%Y-%m'
    ) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY order_month;
