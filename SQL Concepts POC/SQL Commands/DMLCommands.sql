-- ==========================================================
-- SQL Script: Understanding DML (Data Manipulation Language) Commands in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains the concept of DML commands, 
-- demonstrates their syntax, and provides examples for each command.
-- ==========================================================

-- ==========================================================
-- What are DML Commands?
-- ==========================================================

-- DML (Data Manipulation Language) commands are used to manage and manipulate data in database tables.
-- These commands include:
-- ? INSERT ? Adds new records to a table.
-- ? UPDATE ? Modifies existing records in a table.
-- ? DELETE ? Removes records from a table.
-- ? MERGE ? Performs insert, update, or delete operations based on conditions.

-- ==========================================================
-- 1. INSERT Command ? Used to add new records to a table.
-- ==========================================================

-- Syntax:
-- INSERT INTO TableName (Column1, Column2, Column3) VALUES (Value1, Value2, Value3);

-- Example: Inserting data into Customers Table
INSERT INTO Customers (CustomerID, Name, Email, Phone) 
VALUES (1, 'Alice', 'alice@example.com', '9876543210');

INSERT INTO Customers (CustomerID, Name, Email, Phone) 
VALUES (2, 'Bob', 'bob@example.com', '8765432109');

-- ==========================================================
-- 2. UPDATE Command ? Used to modify existing records in a table.
-- ==========================================================

-- Syntax:
-- UPDATE TableName SET Column1 = Value1, Column2 = Value2 WHERE Condition;

-- Example: Updating a Customer's Email
UPDATE Customers SET Email = 'alice_new@example.com' WHERE CustomerID = 1;

-- Example: Updating Multiple Columns
UPDATE Customers SET Name = 'Robert', Phone = '7654321098' WHERE CustomerID = 2;

-- ==========================================================
-- 3. DELETE Command ? Used to remove records from a table.
-- ==========================================================

-- Syntax:
-- DELETE FROM TableName WHERE Condition;

-- Example: Deleting a Customer by ID
DELETE FROM Customers WHERE CustomerID = 2;

-- Example: Deleting All Customers (Use with caution!)
-- DELETE FROM Customers;

-- ==========================================================
-- 4. MERGE Command ? Used to perform INSERT, UPDATE, or DELETE based on conditions.
-- ==========================================================

-- Syntax:
-- MERGE INTO TargetTable AS Target
-- USING SourceTable AS Source
-- ON Target.Column = Source.Column
-- WHEN MATCHED THEN
--     UPDATE SET Target.Column1 = Source.Column1
-- WHEN NOT MATCHED THEN
--     INSERT (Column1, Column2) VALUES (Source.Column1, Source.Column2)
-- WHEN NOT MATCHED BY SOURCE THEN
--     DELETE;

-- Example: Merging Data from a Temporary Table into Customers
MERGE INTO Customers AS Target
USING (SELECT 1 AS CustomerID, 'Alice' AS Name, 'alice@example.com' AS Email, '9876543210' AS Phone) AS Source
ON Target.CustomerID = Source.CustomerID
WHEN MATCHED THEN
    UPDATE SET Target.Email = Source.Email
WHEN NOT MATCHED THEN
    INSERT (CustomerID, Name, Email, Phone) VALUES (Source.CustomerID, Source.Name, Source.Email, Source.Phone)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
-- ==========================================================
-- Example: Checking Data After DML Operations
-- ==========================================================

-- Query to Retrieve All Customers
SELECT * FROM Customers;

-- ==========================================================
-- Summary:
-- ? INSERT ? Adds new records to a table.
-- ? UPDATE ? Modifies existing records in a table.
-- ? DELETE ? Removes records from a table.
-- ? MERGE ? Performs insert, update, or delete operations based on conditions.
-- ==========================================================

-- End of Script
