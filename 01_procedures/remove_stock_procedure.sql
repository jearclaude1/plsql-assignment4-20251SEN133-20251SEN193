------------------------------------------------------------
    -- 2. PROCEDURE: REMOVE_STOCK
    -- Reduces product quantity and records the OUT transaction.
    ------------------------------------------------------------
    SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE remove_stock (
    p_product_id IN NUMBER,
    p_quantity   IN NUMBER
)
AS
    v_current_quantity products.quantity%TYPE;
BEGIN
    IF p_quantity <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Quantity must be greater than zero.');
    END IF;

    SELECT quantity
    INTO v_current_quantity
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF v_current_quantity < p_quantity THEN
        RAISE_APPLICATION_ERROR(-20004, 'Not enough stock available.');
    END IF;

    UPDATE products
    SET quantity = quantity - p_quantity
    WHERE product_id = p_product_id;

    INSERT INTO stock_transactions (
        product_id, transaction_type, quantity, transaction_date
    )
    VALUES (
        p_product_id, 'OUT', p_quantity, SYSDATE
    );

    DBMS_OUTPUT.PUT_LINE('Stock removed successfully.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20005, 'Product was not found.');
END;
/

-- Test this add_stock procedures 

BEGIN
    remove_stock(1, 5);
END;
/

SELECT *
FROM stock_transactions
WHERE product_id = 1
ORDER BY transaction_date DESC;

-- end test of add_stock procedures
