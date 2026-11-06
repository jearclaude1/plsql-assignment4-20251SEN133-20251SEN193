-- 6. TEST THE PROCEDURES
    -- These examples temporarily add 5 units to product 1 and
    -- remove 2 units from product 1.
    ------------------------------------------------------------
    BEGIN
        add_stock(1, 5);
        remove_stock(1, 2);
        check_low_stock;
    END;
    /

    ------------------------------------------------------------
    -- 7. TEST THE FUNCTIONS
    ------------------------------------------------------------
    BEGIN
        DBMS_OUTPUT.PUT_LINE(
            'Value of product 1: ' || stock_value(1)
        );

        DBMS_OUTPUT.PUT_LINE(
            'Total inventory value: ' || total_inventory_value
        );
    END;
    /
