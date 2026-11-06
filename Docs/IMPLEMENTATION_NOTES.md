# Implementation Notes

## 1. Application selected

The group implemented an **Inventory Control System** using Oracle Database and PL/SQL. The system keeps product information, category and supplier details, available stock, reorder levels, and a history of stock movements.

The implementation uses four relational tables: `CATEGORIES`, `SUPPLIERS`, `PRODUCTS`, and `STOCK_TRANSACTIONS`.

## 2. Database schema and relationships

### Tables

- `CATEGORIES`: `category_id` is the primary key and `category_name` is required and unique.
- `SUPPLIERS`: `supplier_id` is the primary key. Supplier name is required, and supplier email has a unique constraint.
- `PRODUCTS`: stores the product name, category, supplier, current quantity, unit price, and reorder level. It has foreign keys to `CATEGORIES` and `SUPPLIERS`.
- `STOCK_TRANSACTIONS`: stores the product, transaction type, quantity, and transaction date. It has a foreign key to `PRODUCTS`.

### Relationships

The schema implements these one-to-many relationships:

1. One category can have multiple products.
2. One supplier can supply multiple products.
3. One product can have multiple stock transaction records.

The schema also uses primary keys, foreign keys, unique constraints, default values, and check constraints. The product constraints disallow negative quantity, price, and reorder level. The transaction constraints permit only `IN` and `OUT` and require a positive transaction quantity.

## 3. Records

The project demonstrates two record approaches.

### User-defined record

`00_schema/03A_user_defined_record.sql` declares `product_record_type` with product ID, product name, quantity, and unit price fields. It selects product 1 into `v_product` and displays the record fields.

This shows how a programmer can define a record containing selected related fields needed by a PL/SQL operation.

### `%ROWTYPE`

`00_schema/03B_rowtype_record.sql` declares `v_product products%ROWTYPE`. It retrieves product 2 and displays fields from the complete row structure of the `PRODUCTS` table.

`%ROWTYPE` follows the table's row structure, reducing the need to declare each field separately.

## 4. Collections

`00_schema/03C_collections.sql` demonstrates three collection types:

- **Associative array:** `quantity_map_type` maps product IDs to quantities. The script fills it from products 1 to 5 and displays selected quantities.
- **Nested table:** `product_id_table_type` stores a list of product IDs (1 through 5), which the script loops through and displays.
- **VARRAY:** `product_name_array_type` stores up to five product names and displays them.

These examples show how PL/SQL can hold and process multiple values in memory.

## 5. Cursor processing

### Implicit cursor

`00_schema/04A_implicit_cursor.sql` runs `UPDATE` statements and checks the implicit cursor attributes:

- `SQL%FOUND` indicates that the first update affected a row.
- `SQL%NOTFOUND` indicates that the second update, using a non-existing product ID, affected no rows.
- `SQL%ROWCOUNT` displays the number of rows affected by each update.

The script rolls back its demonstration changes so that the sample quantities remain unchanged.

### Explicit cursor with manual control

`00_schema/04B_explicit_cursor.sql` declares `low_stock_cursor`, which selects products whose quantity is less than or equal to their reorder level. It explicitly uses `OPEN`, `FETCH`, checks `%NOTFOUND` to exit the loop, and then `CLOSE`.

### Cursor FOR loop

`00_schema/04C_cursor_for_loop.sql` uses a cursor `FOR` loop to display all products. Oracle manages opening, fetching, and closing the cursor for this loop.

## 6. Bulk processing

`00_schema/05_bulk_processing.sql` declares a PL/SQL record type and a collection of those records.

1. `BULK COLLECT` retrieves product IDs and a quantity-to-add value into `v_updates` in a single bulk fetch.
2. `FORALL` performs updates to the matching product rows.
3. A second `FORALL` inserts corresponding `IN` records into `STOCK_TRANSACTIONS`.
4. The script displays the number of rows retrieved and the SQL row counts for the bulk DML operations.

Bulk processing reduces repeated PL/SQL-to-SQL context switches compared with issuing one SQL statement per row in a conventional PL/SQL loop. It is useful when processing many rows. The example is a demonstration and rolls back its changes after execution to preserve the original sample data.

The exception section rolls back and re-raises unexpected errors. The current script does **not** use `SAVE EXCEPTIONS` or inspect `SQL%BULK_EXCEPTIONS`; therefore, it does not demonstrate collecting individual row-level bulk DML errors. If the assignment marker expects explicit bulk-DML error details, this should be added and tested.

## 7. Stored procedures

### `ADD_STOCK`

File: `01_procedures/add_stock_procedure.sql`

Inputs: `p_product_id`, `p_quantity`.

The procedure checks that the quantity is greater than zero, increases the product's current quantity, checks `SQL%ROWCOUNT` to detect a product ID that did not match a row, and inserts an `IN` transaction into `STOCK_TRANSACTIONS`.

It raises application errors for an invalid quantity (`-20001`) and a product that was not found (`-20002`).

### `REMOVE_STOCK`

File: `01_procedures/remove_stock_procedure.sql`

Inputs: `p_product_id`, `p_quantity`.

The procedure checks that the requested quantity is positive, selects the product quantity using `SELECT ... FOR UPDATE`, verifies that enough stock is available, decreases the product quantity, and inserts an `OUT` transaction.

It raises application errors for invalid quantity (`-20003`), insufficient stock (`-20004`), and a missing product (`-20005`, mapped from `NO_DATA_FOUND`).

`FOR UPDATE` locks the selected product row while the stock-removal operation is being performed, helping prevent conflicting updates to that row.

### `CHECK_LOW_STOCK`

File: `01_procedures/check_low_stock-procedure.sql`

This procedure loops through products whose quantity is less than or equal to their reorder level and prints their details. A Boolean flag is used to print a message if no products need restocking.

## 8. Stored functions

### `STOCK_VALUE`

File: `02_functions/stock_value_function.sql`

Input: `p_product_id`.

Returns the value of one product's current stock, calculated as:

`quantity * unit_price`

If the product does not exist, the function raises application error `-20006` after handling `NO_DATA_FOUND`.

### `TOTAL_INVENTORY_VALUE`

File: `02_functions/total_inventory_value.sql`

Returns the sum of `quantity * unit_price` for all products. `NVL` makes the result zero if the aggregate has no value (for example, when the table has no rows).

## 9. Exception handling

The implementation uses `RAISE_APPLICATION_ERROR` to return meaningful application errors for invalid quantities, missing products, and insufficient stock. It also handles the predefined `NO_DATA_FOUND` exception in `REMOVE_STOCK` and `STOCK_VALUE`.

The bulk-processing anonymous block has a `WHEN OTHERS` handler that rolls back and re-raises the error rather than silently suppressing it.

**Items to strengthen against the assignment checklist:**

- The current `ADD_STOCK` and `CHECK_LOW_STOCK` procedures do not have their own exception sections.
- The code does not currently demonstrate `TOO_MANY_ROWS` or a separately declared user-defined exception.
- The implicit cursor example demonstrates the cursor attributes using `UPDATE`; it does not demonstrate them with `INSERT` and `DELETE`.
- The supplied test folder contains a general `test.sql` script and screenshots, but no separate `test_success_cases.sql` and `test_error_cases.sql` scripts in the ZIP.
- The bulk script handles unexpected errors with rollback and re-raise, but does not use `FORALL ... SAVE EXCEPTIONS` or report `SQL%BULK_EXCEPTIONS`.

These are observations about the supplied files, not claims that the missing demonstrations have been implemented. The group should address any checklist items required by the instructor before final submission.

## 10. Testing and screenshots

The ZIP includes screenshots of table creation, sample-data insertion, procedure execution, function output, low-stock output, and test/error output. The SQL test script at `03_tests/Sql/test.sql` calls `ADD_STOCK`, `REMOVE_STOCK`, `CHECK_LOW_STOCK`, `STOCK_VALUE`, and `TOTAL_INVENTORY_VALUE`.

The procedure calls in that test script change the database data and do not include a final `ROLLBACK`. Run tests in a development/test schema, or reset the sample data before repeating them. The implicit-cursor and bulk-processing demonstrations explicitly roll back their temporary changes.

Before submission, the group should verify that every screenshot matches the final code and retain clear evidence of both successful and error test cases.

## 11. Performance and transaction considerations

- `BULK COLLECT` fetches multiple rows into a collection rather than fetching each row individually.
- `FORALL` sends bulk DML operations for collection elements, reducing context-switch overhead between the PL/SQL and SQL engines.
- Cursor `FOR` loops simplify row-by-row processing because Oracle manages cursor opening, fetching, and closing.
- The low-stock cursor filters in SQL (`quantity <= reorder_level`) so only relevant rows are processed by that demonstration.
- `REMOVE_STOCK` uses `SELECT ... FOR UPDATE` before checking and changing the available quantity.
- `COMMIT` in the sample-data script saves the initial records. The implicit cursor and bulk-processing demonstrations use `ROLLBACK` to avoid leaving their demonstration changes in the sample data.

For a much larger inventory, the bulk example could be extended with a `LIMIT` clause to fetch batches, and bulk DML error reporting could be added with `SAVE EXCEPTIONS` and `SQL%BULK_EXCEPTIONS`.

## 12. AI assistance disclosure

An AI assistant was used to understand the base of the project and some error handling and debugging in that order.
