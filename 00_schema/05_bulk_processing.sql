-- INVENTORY CONTROL SYSTEM
-- Step 5: Bulk Processing
-- Demonstrates BULK COLLECT and FORALL.
-- Run after creating tables and inserting sample data.

SET SERVEROUTPUT ON;

DECLARE
    -- Record structure for each product update.
    TYPE product_update_record IS RECORD (
        product_id products.product_id%TYPE,
        quantity_to_add NUMBER
    );

    -- Collection that stores multiple product update records.
    TYPE product_update_table IS TABLE OF product_update_record;

    v_updates product_update_table;

BEGIN
    -- 1. BULK COLLECT: retrieve all products into the collection.
    SELECT product_id, 2
    BULK COLLECT INTO v_updates
    FROM products
    ORDER BY product_id;

    DBMS_OUTPUT.PUT_LINE('BULK PROCESSING');
    DBMS_OUTPUT.PUT_LINE('Products retrieved: ' || v_updates.COUNT);

    -- 2. FORALL: update many product rows together.
    FORALL i IN 1 .. v_updates.COUNT
        UPDATE products
        SET quantity = quantity + v_updates(i).quantity_to_add
        WHERE product_id = v_updates(i).product_id;

    DBMS_OUTPUT.PUT_LINE(
        'Product rows updated: ' || SQL%ROWCOUNT
    );

    -- 3. FORALL: record each stock addition.
    FORALL i IN 1 .. v_updates.COUNT
        INSERT INTO stock_transactions
            (product_id, transaction_type, quantity)
        VALUES
            (v_updates(i).product_id, 'IN',
             v_updates(i).quantity_to_add);

    DBMS_OUTPUT.PUT_LINE(
        'Stock transaction rows inserted: ' || SQL%ROWCOUNT
    );

    -- 4. Roll back demonstration changes to preserve original sample data.
    ROLLBACK;

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE(
        'ROLLBACK completed. Original inventory data is preserved.'
    );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
/
