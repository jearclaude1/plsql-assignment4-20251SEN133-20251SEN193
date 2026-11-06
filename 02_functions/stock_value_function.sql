  -- 4. FUNCTION: STOCK_VALUE
    -- Returns the value of one product: quantity * unit_price.
    ------------------------------------------------------------
    CREATE OR REPLACE FUNCTION stock_value (
        p_product_id IN NUMBER
    )
    RETURN NUMBER
    AS
        v_value NUMBER;
    BEGIN
        SELECT quantity * unit_price
        INTO v_value
        FROM products
        WHERE product_id = p_product_id;

        RETURN v_value;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20006, 'Product was not found.');
    END;
    /

-- Test this add_stock procedures 

BEGIN
    DBMS_OUTPUT.PUT_LINE(
        'Value of product 1: ' || stock_value(1)
    );
END;
/
-- end test of add_stock procedures
