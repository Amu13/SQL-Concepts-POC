-- What is the LAG window function?
-- ---------------------------------
-- The LAG function is a window function in SQL Server that allows us to access 
-- the previous row's value without using complex self-joins or subqueries.
-- It helps in comparing the current row with the previous row in a defined order.

-- When to use LAG?
-- ----------------
-- - Tracking trends over time (e.g., comparing current and previous sales).
-- - Identifying changes in data (e.g., detecting revenue fluctuations).
-- - Finding previous event occurrences (e.g., last purchase date).
-- - Analyzing customer behavior (e.g., repeat purchases).

-- Syntax of LAG function:
-- -------------------------
-- LAG(column_name, offset, default_value) 
-- OVER (PARTITION BY partition_column ORDER BY order_column)
--
-- Explanation:
-- - column_name: The column from which to fetch the previous value.
-- - offset: Specifies how many rows behind to look (default is 1).
-- - default_value: Optional value returned when no previous row exists.
-- - PARTITION BY: Groups rows by a column (optional).
-- - ORDER BY: Determines the sequence of rows.

-- Creating a Sales table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    SaleDate DATE,
    SaleAmount DECIMAL(10,2)
);

-- Inserting sample data
INSERT INTO Sales (SaleID, CustomerName, SaleDate, SaleAmount)
VALUES
    (1, 'Alice', '2025-06-01', 500.00),
    (2, 'Bob', '2025-06-02', 700.00),
    (3, 'Charlie', '2025-06-03', 650.00),
    (4, 'Alice', '2025-06-04', 800.00),
    (5, 'Bob', '2025-06-05', 750.00);

-- Using LAG to get the previous sale amount for each customer
SELECT 
    SaleID,
    CustomerName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount, 1, 0) OVER (PARTITION BY CustomerName ORDER BY SaleDate) AS PreviousSaleAmount
FROM Sales;

-- Expected Output:
-- SaleID | CustomerName | SaleDate  | SaleAmount | PreviousSaleAmount
-- ---------------------------------------------------------------
-- 1      | Alice       | 2025-06-01 | 500.00     | 0
-- 4      | Alice       | 2025-06-04 | 800.00     | 500.00
-- 2      | Bob         | 2025-06-02 | 700.00     | 0
-- 5      | Bob         | 2025-06-05 | 750.00     | 700.00
-- 3      | Charlie     | 2025-06-03 | 650.00     | 0

-- Explanation:
-- - The LAG function retrieves the previous **sale amount** for each customer.
-- - If the customer