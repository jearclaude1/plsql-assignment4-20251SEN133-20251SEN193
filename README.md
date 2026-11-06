# Inventory Control System — Oracle PL/SQL Assignment IV

## Group members

| Full name | Student ID |
|---|---|
| HARERIMANA Jean Claude | 20251SEN133 |
| UDAHEMUKA Manzi Lin Shalom | 20251SEN193 |


## 1. Application overview

This project implements an **Inventory Control System** using Oracle Database and PL/SQL. It manages products, their categories and suppliers, current stock quantities, and stock movement history.

The application is intended to support common inventory activities:

- Register categories and suppliers.
- Store products and their current quantities, prices, and reorder levels.
- Add stock and record an `IN` transaction.
- Remove stock and record an `OUT` transaction.
- Identify products that have reached or fallen below their reorder level.
- Calculate the value of an individual product and the total inventory.

## 2. Database design

The project creates four tables:

| Table | Purpose |
|---|---|
| `CATEGORIES` | Stores product categories. |
| `SUPPLIERS` | Stores supplier names and contact details. |
| `PRODUCTS` | Stores products, category and supplier references, quantity, unit price, and reorder level. |
| `STOCK_TRANSACTIONS` | Stores stock movements, their type (`IN` or `OUT`), quantity, and date. |

### Relationships and constraints

- One category can be associated with many products (one-to-many).
- One supplier can supply many products (one-to-many).
- One product can have many stock transactions (one-to-many).
- Primary keys identify records, and foreign keys enforce the relationships.
- Unique constraints are used for category names and supplier emails.
- Check constraints prevent negative product quantities, prices, or reorder levels, and restrict transaction types to `IN` or `OUT` and transaction quantities to positive values.

## 3. Repository structure

The scripts are organized as follows:


PL/<br>
├── 📁 **[00_schema/](./00_schema/)**<br>
│   ├── 📄 [03A_user_defined_record.sql](./00_schema/03A_user_defined_record.sql)<br>
│   ├── 📄 [03B_rowtype_record.sql](./00_schema/03B_rowtype_record.sql)<br>
│   ├── 📄 [03C_collections.sql](./00_schema/03C_collections.sql)<br>
│   ├── 📄 [04A_implicit_cursor.sql](./00_schema/04A_implicit_cursor.sql)<br>
│   ├── 📄 [04B_explicit_cursor.sql](./00_schema/04B_explicit_cursor.sql)<br>
│   ├── 📄 [04C_cursor_for_loop.sql](./00_schema/04C_cursor_for_loop.sql)<br>
│   ├── 📄 [05_bulk_processing.sql](./00_schema/05_bulk_processing.sql)<br>
│   └── 📁 **[Sql/](./00_schema/Sql/)**<br>
│       ├── 📄 [creation_of_table.sql](./00_schema/Sql/creation_of_table.sql)<br>
│       └── 📄 [insert_data.sql](./00_schema/Sql/insert_data.sql)<br>
├── 📁 **[01_procedures/](./01_procedures/)**<br>
│   ├── 📄 [add_stock_procedure.sql](./01_procedures/add_stock_procedure.sql)<br>
│   ├── 📄 [check_low_stock_procedure.sql](./01_procedures/check_low_stock_procedure.sql)<br>
│   └── 📄 [remove_stock_procedure.sql](./01_procedures/remove_stock_procedure.sql)<br>
├── 📁 **[02_functions/](./02_functions/)**<br>
│   ├── 📄 [stock_value_function.sql](./02_functions/stock_value_function.sql)<br>
│   └── 📄 [total_inventory_value.sql](./02_functions/total_inventory_value.sql)<br>
├── 📁 **[03_tests/](./03_tests/)**<br>
│   └── 📁 **[Sql/](./03_tests/Sql/)**<br>
│       └── 📄 [test.sql](./03_tests/Sql/test.sql)<br>
├── 📁 **[screenshots/](./screenshots/)**<br>
├── 📁 **[docs/](./docs/)**<br>
│   └── 📄 [IMPLEMENTATION_NOTES.md](./docs/IMPLEMENTATION_NOTES.md)<br>
└── 📄 **[README.md](./README.md)**




The ZIP also contains screenshots in `00_schema/screenshot/` and `03_tests/`, as well as additional output screenshots in `screenshots/`.

## 4. Requirements and implementation

The project demonstrates the main PL/SQL topics in the assignment:

- **Records:** a user-defined product record and `products%ROWTYPE`.
- **Collections:** an associative array, nested table, and VARRAY.
- **Implicit cursor:** `SQL%FOUND`, `SQL%NOTFOUND`, and `SQL%ROWCOUNT` after `UPDATE` statements.
- **Explicit cursors:** a cursor using `OPEN`, `FETCH`, and `CLOSE`, and a cursor `FOR` loop.
- **Bulk processing:** `BULK COLLECT` retrieves product IDs and quantities into a collection; `FORALL` performs bulk updates and inserts.
- **Stored procedures:** `ADD_STOCK`, `REMOVE_STOCK`, and `CHECK_LOW_STOCK`.
- **Stored functions:** `STOCK_VALUE` and `TOTAL_INVENTORY_VALUE`.
- **Exception handling:** application errors are raised for invalid quantities, missing products, and insufficient stock; `NO_DATA_FOUND` is handled in the removal procedure and product-value function.

See [`docs/IMPLEMENTATION_NOTES.md`](docs/IMPLEMENTATION_NOTES.md) for more detail and for implementation limitations to review before submission.

## 5. Requirements

- Oracle Database with PL/SQL support.
- SQL*Plus, and Oracle SQL Developer.
- A database user with permission to create tables, procedures, and functions.
- Access to the `DBMS_OUTPUT` output panel/setting to view messages.

## 6. How to run

Connect to the intended Oracle schema first. Run the scripts in this order.

### Step 1 — Create the tables

Run:

```sql
@00_schema/Sql/creation_of_table.sql
```

### Step 2 — Insert sample data

Run:

```sql
@00_schema/Sql/insert_data.sql
```

This inserts sample categories, suppliers, ten products, and initial stock transactions, then commits the sample data.

### Step 3 — Run the record and collection demonstrations

```sql
@00_schema/03A_user_defined_record.sql
@00_schema/03B_rowtype_record.sql
@00_schema/03C_collections.sql
```

### Step 4 — Run cursor demonstrations

```sql
@00_schema/04A_implicit_cursor.sql
@00_schema/04B_explicit_cursor.sql
@00_schema/04C_cursor_for_loop.sql
```

The implicit-cursor demonstration rolls back its temporary updates.

### Step 5 — Run bulk processing

```sql
@00_schema/05_bulk_processing.sql
```

This demonstration uses `BULK COLLECT` and `FORALL`, then rolls back its demonstration changes.

### Step 6 — Compile the stored procedures

```sql
@01_procedures/add_stock_procedure.sql
@01_procedures/remove_stock_procedure.sql
@01_procedures/check_low_stock-procedure.sql
```

### Step 7 — Compile the stored functions

```sql
@02_functions/stock_value_function.sql
@02_functions/total_inventory_value.sql
```

### Step 8 — Run the test block

```sql
@03_tests/Sql/test.sql
```

The test script calls the stock procedures and functions. The stock procedure calls in this test script are not automatically rolled back, so use a test schema or restore the sample data if you need a clean starting state.

Enable output in SQL*Plus/Oracle SQL Developer with:

```sql
SET SERVEROUTPUT ON;
```

In SQL Developer, enable the DBMS Output panel for the active connection.

## 7. Screenshots

The repository contains screenshots showing table creation, sample-data insertion, procedure execution, function results, low-stock output, and test/error output. Review the screenshots and ensure they correspond to the final versions of the scripts before submission.

## 8. AI use disclosure

An AI assistant was used to help 
