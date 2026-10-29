-- 1. Convert inventory dates from text (dd-mm-yyyy) to real dates
ALTER TABLE inventory
  ALTER COLUMN stock_date TYPE DATE USING to_date(stock_date, 'DD-MM-YYYY');

-- 2. Remove personal data from customers
ALTER TABLE customers
  DROP COLUMN customer_name, DROP COLUMN email,
  DROP COLUMN phone, DROP COLUMN address;

-- 3. Primary keys (also act as a duplicate check)
ALTER TABLE products  ADD PRIMARY KEY (product_id);
ALTER TABLE customers ADD PRIMARY KEY (customer_id);
ALTER TABLE orders    ADD PRIMARY KEY (order_id);