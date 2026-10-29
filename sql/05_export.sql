SELECT o.order_id,
       o.order_date::date AS order_date,
       EXTRACT(YEAR FROM o.order_date)::int AS year,
       EXTRACT(MONTH FROM o.order_date)::int AS month_num,
       TO_CHAR(o.order_date, 'Mon') AS month_name,
       CASE WHEN EXTRACT(MONTH FROM o.order_date) BETWEEN 4 AND 10
            THEN 'Apr-Oct' ELSE 'Other months' END AS period,
       p.category, p.product_name,
       oi.quantity, oi.unit_price,
       oi.quantity * oi.unit_price AS revenue,
       o.delivery_status, dp.distance_km,
       f.rating, f.sentiment, f.feedback_category
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN delivery_performance dp ON dp.order_id = o.order_id
JOIN customer_feedback f ON f.order_id = o.order_id;