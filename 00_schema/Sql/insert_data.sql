-- INVENTORY CONTROL SYSTEM
-- Step 2: Insert sample data
-- Run after successfully creating the four tables.

SET SERVEROUTPUT ON;

-- 1. Insert categories
INSERT INTO categories (category_id, category_name)
VALUES (1, 'Electronics');

INSERT INTO categories (category_id, category_name)
VALUES (2, 'Food');

INSERT INTO categories (category_id, category_name)
VALUES (3, 'Furniture');

INSERT INTO categories (category_id, category_name)
VALUES (4, 'Clothing');

INSERT INTO categories (category_id, category_name)
VALUES (5, 'Stationery');


-- 2. Insert suppliers
INSERT INTO suppliers (supplier_id, supplier_name, phone, email)
VALUES (1, 'Kigali Tech Supplies', '0788000001', 'tech@example.com');

INSERT INTO suppliers (supplier_id, supplier_name, phone, email)
VALUES (2, 'Fresh Foods Rwanda', '0788000002', 'foods@example.com');

INSERT INTO suppliers (supplier_id, supplier_name, phone, email)
VALUES (3, 'Modern Furniture Ltd', '0788000003', 'furniture@example.com');

INSERT INTO suppliers (supplier_id, supplier_name, phone, email)
VALUES (4, 'Style Clothing Store', '0788000004', 'clothing@example.com');

INSERT INTO suppliers (supplier_id, supplier_name, phone, email)
VALUES (5, 'Office Stationers', '0788000005', 'stationery@example.com');


-- 3. Insert products
-- quantity represents the current available stock.
INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (1, 'Laptop', 1, 1, 20, 850000, 5);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (2, 'Wireless Mouse', 1, 1, 8, 12000, 10);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (3, 'Keyboard', 1, 1, 15, 25000, 5);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (4, 'Rice 5kg', 2, 2, 30, 8500, 10);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (5, 'Cooking Oil 1L', 2, 2, 6, 3500, 10);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (6, 'Office Chair', 3, 3, 12, 95000, 3);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (7, 'Office Desk', 3, 3, 4, 180000, 5);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (8, 'T-Shirt', 4, 4, 25, 8000, 10);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (9, 'Notebook', 5, 5, 50, 1500, 15);

INSERT INTO products
    (product_id, product_name, category_id, supplier_id,
     quantity, unit_price, reorder_level)
VALUES
    (10, 'Pen', 5, 5, 100, 500, 20);


-- 4. Insert initial stock transactions.
-- Each IN transaction records the initial quantity of its product.
INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (1, 1, 'IN', 20);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (2, 2, 'IN', 8);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (3, 3, 'IN', 15);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (4, 4, 'IN', 30);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (5, 5, 'IN', 6);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (6, 6, 'IN', 12);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (7, 7, 'IN', 4);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (8, 8, 'IN', 25);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (9, 9, 'IN', 50);

INSERT INTO stock_transactions
    (transaction_id, product_id, transaction_type, quantity)
VALUES (10, 10, 'IN', 100);


-- Save all inserted records.
COMMIT;


-- 5. Verify the inserted data
PROMPT === CATEGORIES ===
SELECT * FROM categories ORDER BY category_id;

PROMPT === SUPPLIERS ===
SELECT * FROM suppliers ORDER BY supplier_id;

PROMPT === PRODUCTS ===
SELECT * FROM products ORDER BY product_id;

PROMPT === STOCK TRANSACTIONS ===
SELECT * FROM stock_transactions ORDER BY transaction_id;


-- 6. Display products with their category and supplier names.
PROMPT === INVENTORY DETAILS ===
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    s.supplier_name,
    p.quantity,
    p.unit_price,
    p.reorder_level
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
ORDER BY p.product_id;
