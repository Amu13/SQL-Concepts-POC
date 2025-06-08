-- ==========================================================
-- SQL Script: Understanding T-SQL (Transact-SQL) in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains T-SQL features, demonstrates syntax, 
-- and provides examples for variables, conditional logic, transactions, and error handling.
-- ==========================================================

-- ==========================================================
-- 1. What is T-SQL?
-- ==========================================================

-- ? T-SQL (Transact-SQL) is an extension of SQL developed by Microsoft for SQL Server.
-- ? Adds procedural programming features to standard SQL.
-- ? Supports advanced querying, transaction control, error handling, and stored procedures.

-- ==========================================================
-- 2. Difference Between SQL and T-SQL
-- ==========================================================

-- | Feature | SQL (Standard SQL) | T-SQL (Transact-SQL) |
-- |---------|------------------|------------------|
-- | Basic Queries | ? Yes | ? Yes |
-- | Procedural Logic (IF, WHILE) | ? No | ? Yes |
-- | Variables (DECLARE, SET) | ? No | ? Yes |
-- | Transaction Control (BEGIN TRANSACTION, COMMIT, ROLLBACK) | ? No | ? Yes |
-- | Error Handling (TRY...CATCH) | ? No | ? Yes |
-- | Stored Procedures & Functions | ? No | ? Yes |

-- ==========================================================
-- 3. Using Variables in T-SQL
-- ==========================================================

-- T-SQL allows declaring and using variables.

DECLARE @CustomerName VARCHAR(100);
SET @CustomerName = 'Alice';

SELECT * FROM Customers WHERE Name = @CustomerName;

-- ==========================================================
-- 4. Using IF...ELSE for Conditional Logic
-- ==========================================================

-- T-SQL supports conditional execution.

DECLARE @OrderAmount DECIMAL(10,2);
SET @OrderAmount = 500;

IF @OrderAmount > 1000
    PRINT 'High-value order';
ELSE
    PRINT 'Regular order';

-- ==========================================================
-- 5. Using Transactions for Data Integrity
-- ==========================================================

-- Transactions ensure data consistency.

BEGIN TRANSACTION;

UPDATE Orders SET Amount = Amount - 50 WHERE OrderID = 101;

IF @@ERROR = 0
    COMMIT TRANSACTION;
ELSE
    ROLLBACK TRANSACTION;

-- ==========================================================
-- 6. Using TRY...CATCH for Error Handling
-- ==========================================================

-- T-SQL allows handling errors gracefully.

BEGIN TRY
    INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (110, 2, NULL); -- Error: NULL not allowed
END TRY
BEGIN CATCH
    PRINT 'Error occurred: ' + ERROR_MESSAGE();
END CATCH;

-- ==========================================================
-- Summary:
-- ? T-SQL extends SQL with procedural programming features.
-- ? Supports variables, conditional logic, transactions, and error handling.
-- ? Used for complex queries, stored procedures, and automation.
-- ==========================================================

-- End of Script
