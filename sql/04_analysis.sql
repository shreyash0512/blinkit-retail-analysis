-- 1. Overall revenue Apr-oct 2023 VS 2024
SELECT EXTRACT(YEAR FROM o.order_date)::int AS yr,
       COUNT(*) AS orders,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE EXTRACT(MONTH FROM o.order_date) BETWEEN 4 AND 10
GROUP BY 1 ORDER BY 1;

-- 2. Revenue change by category
WITH sales AS (
  SELECT p.category,
         EXTRACT(YEAR FROM o.order_date)::int AS yr,
         SUM(oi.quantity * oi.unit_price) AS revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p ON p.product_id = oi.product_id
  WHERE EXTRACT(MONTH FROM o.order_date) BETWEEN 4 AND 10
  GROUP BY 1, 2)
SELECT category,
       MAX(revenue) FILTER (WHERE yr = 2023) AS rev_2023,
       MAX(revenue) FILTER (WHERE yr = 2024) AS rev_2024,
       ROUND((MAX(revenue) FILTER (WHERE yr = 2024)
            / MAX(revenue) FILTER (WHERE yr = 2023) - 1) * 100, 1) AS pct_change
FROM sales
GROUP BY category
ORDER BY pct_change;

-- 3. Orders, units and avg price by category
SELECT p.category,
       EXTRACT(YEAR FROM o.order_date)::int AS yr,
       COUNT(*) AS orders,
       SUM(oi.quantity) AS units,
       ROUND(AVG(oi.unit_price), 2) AS avg_unit_price
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE EXTRACT(MONTH FROM o.order_date) BETWEEN 4 AND 10
GROUP BY 1, 2
ORDER BY 1, 2;