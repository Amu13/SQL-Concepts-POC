-- ==========================================================
-- SQL Script: Understanding DDL (Data Definition Language) Commands in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains the concept of DDL commands, 
-- demonstrates their syntax, and provides examples for each command.
-- ==========================================================

-- ==========================================================
-- What are DDL Commands?
-- ==========================================================

-- DDL (Data Definition Language) commands are used to define and manage database structures.
-- These commands include:
-- ? CREATE ? Creates a new database object (table, index, view, etc.).
-- ? ALTER ? Modifies an existing database object.
-- ? DROP ? Deletes a database object.
-- ? TRUNCATE ? Removes all records from a table but keeps its structure.
-- ? RENAME ? Changes the name of a database object (Not directly supported in SQL Server).

-- ==========================================================
-- 1. CREATE Command ? Used to create database objects.
-- ==========================================================

-- Syntax:
-- CREATE TABLE TableName (
--     Column1 DataType Constraints,
--     Column2 DataType Constraints
-- );

-- Example: Creating a Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,  -- Primary Key
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15) UNIQUE
);

-- Example: Creating an Index
CREATE INDEX idx_email ON Customers(Email);

-- ==========================================================
-- 2. ALTER Command ? Used to modify existing database objects.
-- ==========================================================

-- Syntax:
-- ALTER TABLE TableName ADD ColumnName DataType;
-- ALTER TABLE TableName DROP COLUMN ColumnName;
-- ALTER TABLE TableName ALTER COLUMN ColumnName DataType;

-- Example: Adding a New Column to Customers Table
ALTER TABLE Customers ADD Address VARCHAR(255);

-- Example: Modifying Column Data Type
ALTER TABLE Customers ALTER COLUMN Phone VARCHAR(20);

-- Example: Dropping a Column
ALTER TABLE Customers DROP COLUMN Address;

-- ==========================================================
-- 3. DROP Command ? Used to delete database objects.
-- ==========================================================

-- Syntax:
-- DROP TABLE TableName;
-- DROP INDEX IndexName ON TableName;

-- Example: Dropping the Customers Table
DROP TABLE Customers;

-- Example: Dropping an Index
DROP INDEX idx_email ON Customers;

-- ==========================================================
-- 4. TRUNCATE Command ? Used to remove all records from a table.
-- ==========================================================

-- Syntax:
-- TRUNCATE TABLE TableName;

-- Example: Truncating the Customers Table
TRUNCATE TABLE Customers;

-- Note:
-- ? TRUNCATE removes all rows but keeps the table structure.
-- ? Faster than DELETE because it does not log individual row deletions.

-- ==========================================================
-- 5. RENAME Command ? Used to rename database objects.
-- ==========================================================

-- SQL Server does not support direct renaming of tables using RENAME.
-- Instead, use sp_rename.

-- Syntax:
-- EXEC sp_rename 'OldTableName', 'NewTableName';

-- Example: Renaming Customers Table to Clients
EXEC sp_rename 'Customers', 'Clients';

-- ==========================================================
-- Summary:
-- ? CREATE ? Creates a new database object.
-- ? ALTER ? Modifies an existing database object.
-- ? DROP ? Deletes a database object.
-- ? TRUNCATE ? Removes all records but keeps the structure.
-- ? RENAME ? Changes the name of a database object (Using sp_rename in SQL Server).
-- ==========================================================

-- End of Script
