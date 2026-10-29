CREATE TABLE customers (
  customer_id BIGINT, customer_name TEXT, email TEXT, phone TEXT, address TEXT,
  area TEXT, pincode TEXT, registration_date DATE, customer_segment TEXT,
  total_orders INT, avg_order_value NUMERIC(10,2));

CREATE TABLE products (
  product_id BIGINT, product_name TEXT, category TEXT, brand TEXT,
  price NUMERIC(10,2), mrp NUMERIC(10,2), margin_percentage NUMERIC(5,2),
  shelf_life_days INT, min_stock_level INT, max_stock_level INT);

CREATE TABLE orders (
  order_id BIGINT, customer_id BIGINT, order_date TIMESTAMP,
  promised_delivery_time TIMESTAMP, actual_delivery_time TIMESTAMP,
  delivery_status TEXT, order_total NUMERIC(10,2), payment_method TEXT,
  delivery_partner_id BIGINT, store_id BIGINT);

CREATE TABLE order_items (
  order_id BIGINT, product_id BIGINT, quantity INT, unit_price NUMERIC(10,2));

CREATE TABLE delivery_performance (
  order_id BIGINT, delivery_partner_id BIGINT, promised_time TIMESTAMP,
  actual_time TIMESTAMP, delivery_time_minutes NUMERIC(6,1),
  distance_km NUMERIC(5,2), delivery_status TEXT, reasons_if_delayed TEXT);

CREATE TABLE customer_feedback (
  feedback_id BIGINT, order_id BIGINT, customer_id BIGINT, rating INT,
  feedback_text TEXT, feedback_category TEXT, sentiment TEXT, feedback_date DATE);

CREATE TABLE inventory (
  product_id BIGINT, stock_date TEXT, stock_received INT, damaged_stock INT);

CREATE TABLE marketing_performance (
  campaign_id BIGINT, campaign_name TEXT, campaign_date DATE, target_audience TEXT,
  channel TEXT, impressions INT, clicks INT, conversions INT,
  spend NUMERIC(12,2), revenue_generated NUMERIC(12,2), roas NUMERIC(6,2));