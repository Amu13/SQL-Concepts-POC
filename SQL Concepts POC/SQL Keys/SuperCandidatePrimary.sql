-- ==========================================================
-- SQL Script: Understanding Super Keys, Candidate Keys, and Primary Keys
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains the concepts of Super Keys, 
-- Candidate Keys, and Primary Keys using SQL comments and examples.
-- ==========================================================

-- ==========================================================
-- Super Key ? Any set of columns that uniquely identifies rows.
--              (May contain extra attributes)
-- ==========================================================

-- Example: In the Employees table, multiple columns can uniquely identify a row.
--          These are considered Super Keys.

CREATE TABLE Employees (
    EmployeeID INT,       -- Unique identifier (Super Key)
    Email VARCHAR(100),   -- Unique identifier (Super Key)
    Phone VARCHAR(15),    -- Unique identifier (Super Key)
    Name VARCHAR(100)
);

-- Possible Super Keys:
-- 1. {EmployeeID}
-- 2. {Email}
-- 3. {Phone}
-- 4. {EmployeeID, Email}
-- 5. {EmployeeID, Phone, Email} (Contains unnecessary attributes)

-- ==========================================================
-- Candidate Key ? A minimal super key (No unnecessary attributes)
-- ==========================================================

-- Candidate keys are the smallest possible super keys that uniquely identify rows.
-- In this case, the minimal super keys are:

-- 1. {EmployeeID}  ? Minimal and unique
-- 2. {Email}       ? Minimal and unique
-- 3. {Phone}       ? Minimal and unique

-- ==========================================================
-- Primary Key ? The best candidate key chosen for the table.
-- ==========================================================

-- The primary key should be:
-- ? Minimal (No extra attributes)
-- ? Stable (Does not change frequently)
-- ? Efficient for indexing and relationships

-- Choosing EmployeeID as the Primary Key:
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,  -- Best candidate key chosen
    Email VARCHAR(100) UNIQUE,   -- Alternative candidate key
    Phone VARCHAR(15) UNIQUE,    -- Alternative candidate key
    Name VARCHAR(100)
);

-- ==========================================================
-- Summary:
-- ? Super Key ? Any set of columns that uniquely identifies rows (may contain extra attributes).
-- ? Candidate Key ? A minimal super key (no unnecessary attributes).
-- ? Primary Key ? The best candidate key chosen for the table.
-- ==========================================================

-- End of Script
