-- INVENTORY CONTROL SYSTEM
-- Step 4B: Explicit cursor
-- Displays products that have reached or fallen below their reorder level.
-- Run after creating tables and inserting sample data.

SET SERVEROUTPUT ON;

DECLARE
    -- Declare an explicit cursor.
    CURSOR low_stock_cursor IS
        SELECT product_id, product_name, quantity, reorder_level
        FROM products
        WHERE quantity <= reorder_level
        ORDER BY product_id;

    -- Variables to receive each fetched row.
    v_product_id    products.product_id%TYPE;
    v_product_name  products.product_name%TYPE;
    v_quantity      products.quantity%TYPE;
    v_reorder_level products.reorder_level%TYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('PRODUCTS WITH LOW STOCK');
    DBMS_OUTPUT.PUT_LINE('-----------------------');

    OPEN low_stock_cursor;

    LOOP
        FETCH low_stock_cursor
        INTO v_product_id, v_product_name, v_quantity, v_reorder_level;

        EXIT WHEN low_stock_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_product_id ||
            ' | Product: ' || v_product_name ||
            ' | Quantity: ' || v_quantity ||
            ' | Reorder Level: ' || v_reorder_level
        );
    END LOOP;

    CLOSE low_stock_cursor;
END;
/
