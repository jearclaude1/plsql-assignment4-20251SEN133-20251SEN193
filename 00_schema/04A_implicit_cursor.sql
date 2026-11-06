-- INVENTORY CONTROL SYSTEM
-- Step 4A: Implicit cursors
-- Demonstrates SQL%FOUND, SQL%NOTFOUND and SQL%ROWCOUNT.
-- Run after creating tables and inserting sample data.

SET SERVEROUTPUT ON;

DECLARE
    v_product_id NUMBER := 1;
BEGIN
    -- UPDATE example
    UPDATE products
    SET quantity = quantity + 5
    WHERE product_id = v_product_id;

    DBMS_OUTPUT.PUT_LINE('IMPLICIT CURSOR - UPDATE');

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('A product was found and updated.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No product was updated.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Rows affected: ' || SQL%ROWCOUNT);

    -- SQL%NOTFOUND example: use a product ID that does not exist.
    UPDATE products
    SET quantity = quantity + 5
    WHERE product_id = 9999;

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('IMPLICIT CURSOR - NO MATCH');

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No product was found.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('A product was found.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Rows affected: ' || SQL%ROWCOUNT);

    -- Undo the demonstration updates so the sample stock remains unchanged.
    ROLLBACK;
END;
/
