-- INVENTORY CONTROL SYSTEM
-- Step 3A: User-defined record
-- Run after inserting sample data.

SET SERVEROUTPUT ON;

DECLARE
    -- Create our own record structure.
    TYPE product_record_type IS RECORD (
        product_id   products.product_id%TYPE,
        product_name products.product_name%TYPE,
        quantity     products.quantity%TYPE,
        unit_price   products.unit_price%TYPE
    );

    -- Create a variable using the record structure.
    v_product product_record_type;

BEGIN
    -- Put one product's information into the record.
    SELECT product_id, product_name, quantity, unit_price
    INTO v_product
    FROM products
    WHERE product_id = 1;

    -- Display the record values.
    DBMS_OUTPUT.PUT_LINE('USER-DEFINED RECORD');
    DBMS_OUTPUT.PUT_LINE('Product ID: ' || v_product.product_id);
    DBMS_OUTPUT.PUT_LINE('Product Name: ' || v_product.product_name);
    DBMS_OUTPUT.PUT_LINE('Quantity: ' || v_product.quantity);
    DBMS_OUTPUT.PUT_LINE('Unit Price: ' || v_product.unit_price);
END;
/
