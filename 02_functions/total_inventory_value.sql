   -- 5. FUNCTION: TOTAL_INVENTORY_VALUE
    -- Returns the total value of all products in the inventory.
    ------------------------------------------------------------  
   CREATE OR REPLACE FUNCTION total_inventory_value
    RETURN NUMBER
    AS
        v_total NUMBER;
    BEGIN
        SELECT NVL(SUM(quantity * unit_price), 0)
        INTO v_total
        FROM products;

        RETURN v_total;
    END;
    /
-- Test this add_stock procedures 

BEGIN
     DBMS_OUTPUT.PUT_LINE(
            'Total inventory value: ' || total_inventory_value
        );
END;
/
-- end test of add_stock procedures
