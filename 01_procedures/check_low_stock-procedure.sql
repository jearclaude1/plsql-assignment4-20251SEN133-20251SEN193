  -- 3. PROCEDURE: CHECK_LOW_STOCK
    -- Displays products whose quantity is at or below reorder level.
    ------------------------------------------------------------
    CREATE OR REPLACE PROCEDURE check_low_stock
    AS
        v_found BOOLEAN := FALSE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Products that need restocking:');

        FOR product_rec IN (
            SELECT product_id, product_name, quantity, reorder_level
            FROM products
            WHERE quantity <= reorder_level
            ORDER BY product_id
        )
        LOOP
            v_found := TRUE;

            DBMS_OUTPUT.PUT_LINE(
                'ID: ' || product_rec.product_id ||
                ' | Name: ' || product_rec.product_name ||
                ' | Quantity: ' || product_rec.quantity ||
                ' | Reorder level: ' || product_rec.reorder_level
            );
        END LOOP;

        IF NOT v_found THEN
            DBMS_OUTPUT.PUT_LINE('No products are currently low in stock.');
        END IF;
    END;
    
    
-- Test this add_stock procedures 

BEGIN
    check_low_stock;
END;
/

-- end test of add_stock procedures