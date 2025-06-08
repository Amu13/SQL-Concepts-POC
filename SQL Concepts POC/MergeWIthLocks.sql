-- ==========================================================
-- SQL Script: Implementing Locking Mechanisms in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains different locking mechanisms 
-- to prevent modifications in NewCustomers until a transaction is completed.
-- ==========================================================

-- ==========================================================
-- What is Locking in SQL Server?
-- ==========================================================

-- Locking ensures that a table or rows cannot be modified by other transactions 
-- while a critical operation (like MERGE) is running.

-- Why Use Locking?
-- ? Prevents new inserts, updates, or deletes in a table during a transaction.
-- ? Ensures data consistency while performing bulk operations.
-- ? Avoids conflicts when multiple transactions access the same table.

-- ==========================================================
-- 1. Using TABLOCKX to Lock the Entire Table
-- ==========================================================

-- TABLOCKX (Exclusive Table Lock) prevents any other transaction from modifying 
-- NewCustomers until the current transaction is completed.

BEGIN TRANSACTION;

-- Apply an exclusive lock on NewCustomers to prevent changes
SELECT * FROM NewCustomers WITH (TABLOCKX);

-- Run the MERGE operation
MERGE INTO Customers AS Target
USING NewCustomers AS Source
ON Target.CustomerID = Source.CustomerID

WHEN MATCHED THEN
    UPDATE SET Target.Name = Source.Name, Target.Email = Source.Email, Target.Phone = Source.Phone

WHEN NOT MATCHED THEN
    INSERT (CustomerID, Name, Email, Phone) VALUES (Source.CustomerID, Source.Name, Source.Email, Source.Phone)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Commit the transaction, releasing the lock
COMMIT TRANSACTION;

-- ==========================================================
-- 2. Using SERIALIZABLE Isolation Level to Prevent Inserts
-- ==========================================================

-- SERIALIZABLE ensures that no new rows can be inserted into NewCustomers 
-- while MERGE is running.

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

-- Run the MERGE operation
MERGE INTO Customers AS Target
USING NewCustomers AS Source
ON Target.CustomerID = Source.CustomerID

WHEN MATCHED THEN
    UPDATE SET Target.Name = Source.Name, Target.Email = Source.Email, Target.Phone = Source.Phone

WHEN NOT MATCHED THEN
    INSERT (CustomerID, Name, Email, Phone) VALUES (Source.CustomerID, Source.Name, Source.Email, Source.Phone)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Commit the transaction, allowing new inserts
COMMIT TRANSACTION;

-- ==========================================================
-- 3. Using XLOCK to Lock Rows for Exclusive Access
-- ==========================================================

-- XLOCK (Exclusive Lock) prevents other transactions from modifying locked rows.

BEGIN TRANSACTION;

-- Lock all rows in NewCustomers to prevent changes
SELECT * FROM NewCustomers WITH (XLOCK, HOLDLOCK);

-- Run the MERGE operation
MERGE INTO Customers AS Target
USING NewCustomers AS Source
ON Target.CustomerID = Source.CustomerID

WHEN MATCHED THEN
    UPDATE SET Target.Name = Source.Name, Target.Email = Source.Email, Target.Phone = Source.Phone

WHEN NOT MATCHED THEN
    INSERT (CustomerID, Name, Email, Phone) VALUES (Source.CustomerID, Source.Name, Source.Email, Source.Phone)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Commit the transaction, releasing the lock
COMMIT TRANSACTION;

-- ==========================================================
-- Summary: Best Locking Mechanisms for Preventing Changes
-- ==========================================================

-- | Locking Method | Prevents Inserts? | Prevents Updates? | Prevents Deletes? | Scope |
-- |---------------|------------------|------------------|------------------|--------|
-- | TABLOCKX      | ? Yes | ? Yes | ? Yes | Entire Table |
-- | SERIALIZABLE  | ? Yes | ? Yes | ? Yes | Transaction Scope |
-- | XLOCK         | ? Yes | ? Yes | ? Yes | Row-Level |

-- ==========================================================
-- Choosing the Right Locking Mechanism
-- ==========================================================

-- ? Use TABLOCKX if you want to lock the entire table and prevent all modifications.
-- ? Use SERIALIZABLE if you want to prevent new inserts but allow updates to existing rows.
-- ? Use XLOCK if you want to lock specific rows instead of the entire table.

-- ==========================================================
-- End of Script
