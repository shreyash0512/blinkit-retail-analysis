-- 1. Order items whose product doesn't exist (expect 0)
SELECT COUNT(*) FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 2. Orders whose customer doesn't exist (expect 0)
SELECT COUNT(*) FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 3. Duplicate order items (expect no rows)
SELECT order_id, product_id, COUNT(*) FROM order_items
GROUP BY order_id, product_id HAVING COUNT(*) > 1;

-- 4. Missing delay reasons (expect 1902 nulls, only in this column)
SELECT COUNT(*) FILTER (WHERE reasons_if_delayed IS NULL) AS null_reasons FROM delivery_performance;

-- 5. Does order_total match quantity x unit price?
SELECT COUNT(*) AS orders,
       COUNT(*) FILTER (WHERE ROUND(o.order_total,2) <> ROUND(i.items_total,2)) AS mismatched
FROM orders o
JOIN (SELECT order_id, SUM(quantity * unit_price) AS items_total
      FROM order_items GROUP BY order_id) i ON o.order_id = i.order_id;

-- 6. Orders per month (look for partial months at the ends)
SELECT DATE_TRUNC('month', order_date)::date AS month, COUNT(*) AS orders
FROM orders GROUP BY 1 ORDER BY 1;