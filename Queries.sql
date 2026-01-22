USE ecommerce_retention;

-- 1. TOTAL REVENUE
SELECT 
    SUM(quantity * selling_price) AS total_revenue
FROM order_items;

------------------------------------------------------------

-- 2. MONTHLY REVENUE TREND
SELECT 
    DATE_FORMAT(o.order_date,'%Y-%m') AS month,
    SUM(oi.quantity * oi.selling_price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;


------------------------------------------------------------

-- 3. MONTH-OVER-MONTH REVENUE GROWTH
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(o.order_date,'%Y-%m') AS month,
        SUM(oi.quantity * oi.selling_price) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY month
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month)) /
        LAG(revenue) OVER (ORDER BY month) * 100, 2
    ) AS growth_percentage
FROM monthly_revenue;

------------------------------------------------------------

-- 4. TOTAL VS REPEAT CUSTOMERS
SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) AS repeat_customers
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t;

------------------------------------------------------------

-- 5. REPEAT PURCHASE RATE
SELECT
    ROUND(
        COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) /
        COUNT(DISTINCT customer_id) * 100, 2
    ) AS repeat_purchase_rate
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t;

------------------------------------------------------------

-- 6. CUSTOMER FIRST ORDER (COHORT ASSIGNMENT)
WITH first_order AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    DATE_FORMAT(first_order_date,'%Y-%m') AS cohort_month
FROM first_order;

------------------------------------------------------------

-- 7. COHORT RETENTION MATRIX (CORE QUERY)
WITH first_order AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
),
cohort_data AS (
    SELECT
        o.customer_id,
        DATE_FORMAT(f.first_order_date,'%Y-%m') AS cohort_month,
        TIMESTAMPDIFF(
            MONTH,
            f.first_order_date,
            o.order_date
        ) AS months_since_first_order
    FROM orders o
    JOIN first_order f ON o.customer_id = f.customer_id
)
SELECT
    cohort_month,
    months_since_first_order,
    COUNT(DISTINCT customer_id) AS active_customers
FROM cohort_data
GROUP BY cohort_month, months_since_first_order
ORDER BY cohort_month, months_since_first_order;

------------------------------------------------------------

-- 8. CUSTOMER LIFETIME VALUE (CLV)
SELECT
    c.customer_id,
    c.name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.selling_price) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.name
ORDER BY lifetime_value DESC;

------------------------------------------------------------

-- 9. AVERAGE CUSTOMER LTV
SELECT
    ROUND(AVG(customer_ltv),2) AS avg_clv
FROM (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.selling_price) AS customer_ltv
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id
) t;

------------------------------------------------------------

-- 10. TOP 5 PRODUCTS BY REVENUE
SELECT
    p.product_name,
    SUM(oi.quantity * oi.selling_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

------------------------------------------------------------

-- 11. CATEGORY-WISE REVENUE
SELECT
    c.category_name,
    SUM(oi.quantity * oi.selling_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

------------------------------------------------------------

-- 12. PRODUCT-LEVEL PROFIT
SELECT
    p.product_name,
    SUM(oi.quantity * (oi.selling_price - p.cost)) AS profit
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY profit DESC;

------------------------------------------------------------

-- 13. CATEGORY PROFIT MARGIN (%)
SELECT
    c.category_name,
    ROUND(
        SUM(oi.quantity * (oi.selling_price - p.cost)) /
        SUM(oi.quantity * oi.selling_price) * 100, 2
    ) AS profit_margin_percentage
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;

------------------------------------------------------------

-- 14. PAYMENT METHOD DISTRIBUTION
SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM payments
GROUP BY payment_method
ORDER BY total_transactions DESC;

/* ===================== END ===================== */