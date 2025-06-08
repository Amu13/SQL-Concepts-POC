-- ==========================================================
-- SQL Script: Implementing Locking Mechanisms in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains different locking mechanisms 
-- to prevent modifications in Customers until a transaction is completed.
-- ==========================================================

-- ==========================================================
-- What is Locking in SQL Server?
-- ==========================================================

-- Locking ensures that a table or rows cannot be modified by other transactions 
-- while a critical operation (like MERGE or UPDATE) is running.

-- Why Use Locking?
-- ? Prevents new inserts, updates, or deletes in a table during a transaction.
-- ? Ensures data consistency while performing bulk operations.
-- ? Avoids conflicts when multiple transactions access the same table.

-- ==========================================================
-- 1. Using TABLOCKX to Lock the Entire Table
-- ==========================================================

-- TABLOCKX (Exclusive Table Lock) prevents any other transaction from modifying 
-- Customers until the current transaction is completed.

BEGIN TRANSACTION;

-- Apply an exclusive lock on the entire table
SELECT * FROM Customers WITH (TABLOCKX);

-- Perform operations
UPDATE Customers SET Name = 'Updated Name' WHERE CustomerID = 1;

COMMIT TRANSACTION;

-- ==========================================================
-- 2. Using SERIALIZABLE Isolation Level to Prevent Inserts
-- ==========================================================

-- SERIALIZABLE ensures that no new rows can be inserted into Customers 
-- while the transaction is running.

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

-- Perform operations
UPDATE Customers SET Name = 'Updated Name' WHERE CustomerID = 1;

COMMIT TRANSACTION;

-- ==========================================================
-- 3. Using XLOCK to Lock Rows for Exclusive Access
-- ==========================================================

-- XLOCK (Exclusive Lock) prevents other transactions from modifying locked rows.

BEGIN TRANSACTION;

-- Lock specific rows to prevent modifications
SELECT * FROM Customers WITH (XLOCK, HOLDLOCK) WHERE CustomerID = 1;

-- Perform operations
UPDATE Customers SET Name = 'Updated Name' WHERE CustomerID = 1;

COMMIT TRANSACTION;

-- ==========================================================
-- 4. Using UPDLOCK to Prevent Updates but Allow Inserts
-- ==========================================================

-- UPDLOCK prevents other transactions from updating locked rows but allows inserts.

BEGIN TRANSACTION;

-- Lock rows for update but allow inserts
SELECT * FROM Customers WITH (UPDLOCK) WHERE CustomerID = 1;

-- Perform operations
UPDATE Customers SET Name = 'Updated Name' WHERE CustomerID = 1;

COMMIT TRANSACTION;

-- ==========================================================
-- 5. Using ROWLOCK for Fine-Grained Row-Level Locking
-- ==========================================================

-- ROWLOCK locks only specific rows, allowing other rows to be modified.

BEGIN TRANSACTION;

-- Lock a single row for modification
SELECT * FROM Customers WITH (ROWLOCK) WHERE CustomerID = 1;

-- Perform operations
UPDATE Customers SET Name = 'Updated Name' WHERE CustomerID = 1;

COMMIT TRANSACTION;

-- ==========================================================
-- 6. Using HOLDLOCK to Retain Locks Until Transaction Ends
-- ==========================================================

-- HOLDLOCK ensures that locks remain active until the transaction is committed.

BEGIN TRANSACTION;

-- Lock rows until transaction ends
SELECT * FROM Customers WITH (HOLDLOCK) WHERE CustomerID = 1;

-- Perform operations
UPDATE Customers SET Name = 'Updated Name' WHERE CustomerID = 1;

COMMIT TRANSACTION;

-- ==========================================================
-- Summary: Best Locking Mechanisms for Preventing Changes
-- ==========================================================

-- | Locking Method | Prevents Inserts? | Prevents Updates? | Prevents Deletes? | Scope |
-- |---------------|------------------|------------------|------------------|--------|
-- | TABLOCKX      | ? Yes | ? Yes | ? Yes | Entire Table |
-- | SERIALIZABLE  | ? Yes | ? Yes | ? Yes | Transaction Scope |
-- | XLOCK         | ? Yes | ? Yes | ? Yes | Row-Level |
-- | UPDLOCK       | ? No | ? Yes | ? No | Row-Level |
-- | ROWLOCK       | ? No | ? Yes | ? Yes | Single Row |
-- | HOLDLOCK      | ? Yes | ? Yes | ? Yes | Transaction Scope |

-- ==========================================================
-- Choosing the Right Locking Mechanism
-- ==========================================================

-- ? Use TABLOCKX if you want to lock the entire table and prevent all modifications.
-- ? Use SERIALIZABLE if you want to prevent new inserts but allow updates to existing rows.
-- ? Use XLOCK if you want to lock specific rows instead of the entire table.
-- ? Use UPDLOCK if you want to prevent updates but allow inserts.
-- ? Use ROWLOCK if you want fine-grained row-level locking.
-- ? Use HOLDLOCK if you want locks to persist until the transaction ends.

-- ==========================================================
-- End of Script
