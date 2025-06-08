-- ==========================================================
-- SQL Script: Understanding MERGE in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains the concept of MERGE, 
-- demonstrates its syntax, and provides examples for data synchronization.
-- ==========================================================

-- ==========================================================
-- What is MERGE?
-- ==========================================================

-- The MERGE statement in SQL Server allows you to perform INSERT, UPDATE, or DELETE 
-- operations in a target table based on matching conditions with a source table.

-- Why Use MERGE?
-- ? Combines INSERT, UPDATE, and DELETE into a single statement.
-- ? Reduces multiple queries into one, improving performance.
-- ? Useful for data synchronization between tables.
-- ? Ensures consistency when merging data from different sources.

-- ==========================================================
-- Syntax of MERGE
-- ==========================================================

-- MERGE INTO TargetTable AS Target
-- USING SourceTable AS Source
-- ON Target.Column = Source.Column
-- WHEN MATCHED THEN
--     UPDATE SET Target.Column1 = Source.Column1
-- WHEN NOT MATCHED THEN
--     INSERT (Column1, Column2) VALUES (Source.Column1, Source.Column2)
-- WHEN NOT MATCHED BY SOURCE THEN
--     DELETE;

-- ==========================================================
-- Example: Synchronizing Customers Data
-- ==========================================================

-- Step 1: Create the Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15) UNIQUE
);

-- Step 2: Insert Initial Data
INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES (1, 'Alice', 'alice@example.com', '9876543210');
INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES (2, 'Bob', 'bob@example.com', '8765432109');

-- ==========================================================
-- Step 3: Create a Temporary Table with New Data
-- ==========================================================

CREATE TABLE NewCustomers (
    CustomerID INT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

INSERT INTO NewCustomers (CustomerID, Name, Email, Phone) VALUES (1, 'Alice Johnson', 'alice@example.com', '9876543210'); -- Updated Name
INSERT INTO NewCustomers (CustomerID, Name, Email, Phone) VALUES (3, 'Charlie', 'charlie@example.com', '7654321098'); -- New Customer

-- ==========================================================
-- Step 4: Use MERGE to Synchronize Data
-- ==========================================================

BEGIN TRANSACTION;

MERGE INTO Customers AS Target
USING NewCustomers AS Source
ON Target.CustomerID = Source.CustomerID

WHEN MATCHED THEN
    UPDATE SET Target.Name = Source.Name, Target.Email = Source.Email, Target.Phone = Source.Phone

WHEN NOT MATCHED THEN
    INSERT (CustomerID, Name, Email, Phone) VALUES (Source.CustomerID, Source.Name, Source.Email, Source.Phone)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

COMMIT TRANSACTION;

-- ==========================================================
-- Expected Results After MERGE
-- ==========================================================

-- | CustomerID | Name          | Email              | Phone      |
-- |------------|--------------|--------------------|------------|
-- | 1          | Alice Johnson | alice@example.com | 9876543210 |
-- | 3          | Charlie       | charlie@example.com | 7654321098 |

-- ? Alice's name is updated
-- ? Charlie is inserted as a new customer
-- ? Bob is deleted because he is not in NewCustomers

-- ==========================================================
-- Example: Checking Data After MERGE
-- ==========================================================

SELECT * FROM Customers;

-- ==========================================================
-- Summary:
-- ? MERGE combines INSERT, UPDATE, and DELETE into one statement.
-- ? Useful for synchronizing tables efficiently.
-- ? Ensures consistency when merging data from different sources.
-- ? Can be wrapped in transactions for data integrity.
-- ==========================================================

-- End of Script
