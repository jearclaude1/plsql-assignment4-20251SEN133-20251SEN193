-- INVENTORY CONTROL SYSTEM
-- Step 3B: Using %ROWTYPE
-- Run after inserting sample data.

SET SERVEROUTPUT ON;

DECLARE
    -- This variable can hold a complete row from PRODUCTS.
    v_product products%ROWTYPE;

BEGIN
    SELECT *
    INTO v_product
    FROM products
    WHERE product_id = 2;

    DBMS_OUTPUT.PUT_LINE('%ROWTYPE RECORD');
    DBMS_OUTPUT.PUT_LINE('Product ID: ' || v_product.product_id);
    DBMS_OUTPUT.PUT_LINE('Product Name: ' || v_product.product_name);
    DBMS_OUTPUT.PUT_LINE('Quantity: ' || v_product.quantity);
    DBMS_OUTPUT.PUT_LINE('Unit Price: ' || v_product.unit_price);
    DBMS_OUTPUT.PUT_LINE('Reorder Level: ' || v_product.reorder_level);
END;
/
