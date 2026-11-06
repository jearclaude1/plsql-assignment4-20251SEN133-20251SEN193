-- 1. PROCEDURE: ADD_STOCK
-- Adds a quantity to an existing product and records the IN
-- transaction in STOCK_TRANSACTIONS.
------------------------------------------------------------
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE add_stock (
    p_product_id IN INT,
    p_quantity   IN NUMBER
)
AS
BEGIN
    IF p_quantity <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Quantity must be greater than zero.');
    END IF;

    UPDATE products
    SET quantity = quantity + p_quantity
    WHERE product_id = p_product_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Product was not found.');
    END IF;
    
   INSERT INTO stock_transactions (
        product_id, transaction_type, quantity, transaction_date
    )
    VALUES (
        p_product_id, 'IN', p_quantity, SYSDATE
    );
    
    DBMS_OUTPUT.PUT_LINE('Stock added successfully.');
END;
/

-- Test this add_stock procedures 

BEGIN
    add_stock(1, 5);
END;
/
-- end test of add_stock procedures
