-- INVENTORY CONTROL SYSTEM
-- Step 3C: PL/SQL Collections
-- Demonstrates associative array, nested table and VARRAY.
-- Run after inserting sample data.

SET SERVEROUTPUT ON;

DECLARE
    -- 1. Associative array: stores quantities using product IDs as indexes.
    TYPE quantity_map_type IS TABLE OF NUMBER
        INDEX BY PLS_INTEGER;
    v_quantities quantity_map_type;

    -- 2. Nested table: stores a list of product IDs.
    TYPE product_id_table_type IS TABLE OF NUMBER;
    v_product_ids product_id_table_type :=
        product_id_table_type(1, 2, 3, 4, 5);

    -- 3. VARRAY: stores a limited list of product names.
    TYPE product_name_array_type IS VARRAY(5) OF VARCHAR2(120);
    v_product_names product_name_array_type :=
        product_name_array_type(
            'Laptop',
            'Wireless Mouse',
            'Keyboard',
            'Rice 5kg',
            'Cooking Oil 1L'
        );

    i PLS_INTEGER;

BEGIN
    -- Fill the associative array from the PRODUCTS table.
    FOR product_row IN (
        SELECT product_id, quantity
        FROM products
        WHERE product_id BETWEEN 1 AND 5
        ORDER BY product_id
    ) LOOP
        v_quantities(product_row.product_id) := product_row.quantity;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('1. ASSOCIATIVE ARRAY');
    DBMS_OUTPUT.PUT_LINE('Product ID 1 quantity: ' || v_quantities(1));
    DBMS_OUTPUT.PUT_LINE('Product ID 2 quantity: ' || v_quantities(2));
    DBMS_OUTPUT.PUT_LINE('Product ID 3 quantity: ' || v_quantities(3));

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('2. NESTED TABLE - PRODUCT IDS');

    FOR i IN 1 .. v_product_ids.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Product ID: ' || v_product_ids(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('3. VARRAY - PRODUCT NAMES');

    FOR i IN 1 .. v_product_names.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Product Name: ' || v_product_names(i));
    END LOOP;
END;
/
