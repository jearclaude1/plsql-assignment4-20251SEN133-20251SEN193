-- INVENTORY CONTROL SYSTEM
-- Step 4C: Explicit cursor FOR LOOP
-- Displays all products without manually using OPEN, FETCH and CLOSE.

SET SERVEROUTPUT ON;

DECLARE
    CURSOR product_cursor IS
        SELECT product_id, product_name, quantity, unit_price
        FROM products
        ORDER BY product_id;
BEGIN
    DBMS_OUTPUT.PUT_LINE('ALL INVENTORY PRODUCTS');
    DBMS_OUTPUT.PUT_LINE('----------------------');

    FOR product_row IN product_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || product_row.product_id ||
            ' | Name: ' || product_row.product_name ||
            ' | Quantity: ' || product_row.quantity ||
            ' | Unit Price: ' || product_row.unit_price
        );
    END LOOP;
END;
/
