-- ==========================================================
-- SQL Script: Understanding SQL Execution Order in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains the logical execution order of SQL clauses, 
-- demonstrates their syntax, and provides examples with expected output.
-- ==========================================================

-- ==========================================================
-- 1. Logical Execution Order of SQL Clauses
-- ==========================================================

-- SQL Server processes queries in the following order:
-- 1. FROM ? Identifies source tables and joins data.
-- 2. WHERE ? Filters rows before grouping.
-- 3. GROUP BY ? Groups filtered rows.
-- 4. HAVING ? Filters grouped records.
-- 5. SELECT ? Determines which columns to return.
-- 6. ORDER BY ? Sorts the final result set.
-- 7. LIMIT / OFFSET ? Restricts the number of rows returned (pagination).

-- ==========================================================
-- 2. Example Query with Execution Order
-- ==========================================================

-- Business Case:
-- A company wants to count the number of orders per customer, 
-- but only for orders where the amount is greater than $100.
-- The result should be sorted by total orders in descending order, 
-- and only the top 5 customers should be displayed.

-- Step 1: Create the Customers and Orders tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Step 2: Insert Sample Data
INSERT INTO Customers (CustomerID, Name) VALUES (1, 'Alice');
INSERT INTO Customers (CustomerID, Name) VALUES (2, 'Bob');
INSERT INTO Customers (CustomerID, Name) VALUES (3, 'Charlie');
INSERT INTO Customers (CustomerID, Name) VALUES (4, 'David');
INSERT INTO Customers (CustomerID, Name) VALUES (5, 'Eve');

INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (101, 1, 250.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (102, 1, 150.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (103, 2, 300.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (104, 2, 100.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (105, 3, 50.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (106, 4, 500.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (107, 4, 200.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (108, 5, 600.00);

-- Step 3: Execute Query with Logical Execution Order
SELECT Customers.Name, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID  -- Step 1: FROM
WHERE Orders.Amount > 100  -- Step 2: WHERE (Filters orders below $100)
GROUP BY Customers.Name  -- Step 3: GROUP BY (Groups filtered records)
HAVING COUNT(Orders.OrderID) > 1  -- Step 4: HAVING (Filters grouped records)
ORDER BY TotalOrders DESC  -- Step 5: ORDER BY (Sorts final result)
OFFSET 0 ROWS  -- Step 6: OFFSET (Used for pagination, optional)
LIMIT 5;  -- Step 6: LIMIT (Restricts rows returned)

-- ==========================================================
-- 3. Expected Output
-- ==========================================================

-- | Name    | TotalOrders |
-- |---------|------------|
-- | David   | 2          |
-- | Alice   | 2          |
-- | Bob     | 1          |

-- Explanation:
-- ? Orders below $100 are filtered out by WHERE.
-- ? Customers are grouped by name.
-- ? Only customers with more than one order are included (HAVING).
-- ? Results are sorted by total orders in descending order.
-- ? Only the top 5 customers are displayed.

-- ==========================================================
-- 4. Summary: SQL Execution Order vs. Writing Order
-- ==========================================================

-- | Writing Order | Execution Order |
-- |--------------|----------------|
-- | SELECT       | FROM           |
-- | FROM         | WHERE          |
-- | WHERE        | GROUP BY       |
-- | GROUP BY     | HAVING         |
-- | HAVING       | SELECT         |
-- | ORDER BY     | ORDER BY       |
-- | LIMIT        | LIMIT          |

-- Key Takeaways:
-- ? SQL executes FROM first, even though SELECT is written first.
-- ? WHERE filters rows before grouping, while HAVING filters grouped records.
-- ? ORDER BY is always executed last, after filtering and aggregation.

-- ==========================================================
-- End of Script
