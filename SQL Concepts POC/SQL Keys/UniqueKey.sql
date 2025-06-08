-- ==========================================================
-- SQL Script: Understanding Unique Keys in SQL Server (With Named Constraints)
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains the concept of Unique Keys, 
-- demonstrates their usage with named constraints, and shows how 
-- to add a unique key using a primary key.
-- ==========================================================

-- ==========================================================
-- Unique Key ? A constraint that ensures all values in a column (or set of columns) are unique.
-- ==========================================================

-- Unique keys ensure:
-- ? No duplicate values in the specified column(s).
-- ? Allow NULL values (Unlike Primary Keys, which do not allow NULLs).
-- ? Can be applied to multiple columns in a table.
-- ? Can be explicitly named for better management.

-- ==========================================================
-- Syntax for Creating a Unique Key
-- ==========================================================

-- Method 1: Define Unique Key at Column Level (With Named Constraint)
-- CREATE TABLE TableName (
--     ColumnName DataType,
--     CONSTRAINT UniqueKeyName UNIQUE (ColumnName)
-- );

-- Method 2: Define Unique Key at Table Level (Composite Unique Key)
-- CREATE TABLE TableName (
--     Column1 DataType,
--     Column2 DataType,
--     CONSTRAINT UniqueKeyName UNIQUE (Column1, Column2)  -- Named Unique Key
-- );

-- ==========================================================
-- Example: Unique Key in Customers Table (With Named Constraints)
-- ==========================================================

-- Step 1: Create the Customers table with named Unique Keys
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,  -- Primary Key (Unique Identifier)
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    CONSTRAINT UQ_Customers_Email UNIQUE (Email),  -- Named Unique Key for Email
    CONSTRAINT UQ_Customers_Phone UNIQUE (Phone)   -- Named Unique Key for Phone
);

ALTER TABLE Customers ADD CONSTRAINT UQ_Customers_Email UNIQUE (Email);
ALTER TABLE Customers ADD CONSTRAINT UQ_Customers_Phone UNIQUE (Phone);
-- ==========================================================
-- Example: Composite Unique Key in Orders Table (With Named Constraints)
-- ==========================================================

-- Step 2: Create the Orders table with a Composite Unique Key
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,     -- Primary Key
    CustomerID INT,              -- Foreign Key referencing Customers
    OrderDate DATETIME,
    Amount DECIMAL(10,2),
    CONSTRAINT UQ_Orders_CustomerDate UNIQUE (CustomerID, OrderDate)  -- Named Composite Unique Key
);

-- ==========================================================
-- Example: Adding a Unique Key Using Primary Key
-- ==========================================================

-- Step 3: Create the Products table with a Unique Key on SKU
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,  -- Primary Key (Automatically Unique)
    Name VARCHAR(100),
    SKU VARCHAR(20),
    CONSTRAINT UQ_Products_SKU UNIQUE (SKU)  -- Named Unique Key for SKU
);

-- ==========================================================
-- Example Queries to Demonstrate Unique Key Behavior
-- ==========================================================

-- Insert data into Customers (Valid Entries)
INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES (1, 'Alice', 'alice@example.com', '9876543210');
INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES (2, 'Bob', 'bob@example.com', '8765432109');

-- Attempt to Insert Duplicate Email (Will Fail)
BEGIN TRY
    INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES (3, 'Charlie', 'alice@example.com', '7654321098');  -- ERROR: Duplicate Email
END TRY
BEGIN CATCH
    PRINT 'Error: Duplicate Email detected!';
END CATCH;

-- Attempt to Insert Duplicate Phone (Will Fail)
BEGIN TRY
    INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES (4, 'David', 'david@example.com', '9876543210');  -- ERROR: Duplicate Phone
END TRY
BEGIN CATCH
    PRINT 'Error: Duplicate Phone detected!';
END CATCH;

-- ==========================================================
-- Example: Checking Unique Constraints in System Tables
-- ==========================================================

-- Query to Find Unique Constraints in a Table
SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
WHERE TABLE_NAME = 'Customers';

-- ==========================================================
-- Summary:
-- ? Unique Key ? Ensures uniqueness in a column or set of columns.
-- ? Allows NULL values (Unlike Primary Keys).
-- ? Can be applied to single or multiple columns (Composite Unique Key).
-- ? Can be explicitly named for better management.
-- ? Primary Keys are inherently unique, but additional unique constraints can be added.
-- ==========================================================

-- End of Script
