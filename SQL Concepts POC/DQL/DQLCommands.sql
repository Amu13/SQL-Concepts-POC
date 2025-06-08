-- ==========================================================
-- SQL Script: Understanding DQL (Data Query Language) Commands in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains the concept of DQL commands, 
-- demonstrates their syntax, and provides examples for retrieving data.
-- ==========================================================

-- ==========================================================
-- What are DQL Commands?
-- ==========================================================

-- DQL (Data Query Language) commands are used to retrieve data from database tables.
-- These commands include:
-- ? SELECT ? Retrieves data from one or more tables.
-- ? WHERE ? Filters records based on conditions.
-- ? ORDER BY ? Sorts the result set.
-- ? GROUP BY ? Groups records based on a column.
-- ? HAVING ? Filters grouped records.
-- ? JOIN ? Combines data from multiple tables.

-- ==========================================================
-- 1. SELECT Command ? Used to retrieve data from a table.
-- ==========================================================

-- Syntax:
-- SELECT Column1, Column2 FROM TableName;

-- Example: Selecting all columns from Customers Table
SELECT * FROM Customers;

-- Example: Selecting specific columns
SELECT CustomerID, Name, Email FROM Customers;

-- ==========================================================
-- 2. WHERE Clause ? Used to filter records based on conditions.
-- ==========================================================

-- Syntax:
-- SELECT Column1, Column2 FROM TableName WHERE Condition;

-- Example: Selecting customers with a specific email
SELECT * FROM Customers WHERE Email = 'alice@example.com';

-- Example: Selecting customers with CustomerID greater than 2
SELECT * FROM Customers WHERE CustomerID > 2;

-- ==========================================================
-- 3. ORDER BY Clause ? Used to sort the result set.
-- ==========================================================

-- Syntax:
-- SELECT Column1, Column2 FROM TableName ORDER BY ColumnName ASC|DESC;

-- Example: Sorting customers by name in ascending order
SELECT * FROM Customers ORDER BY Name ASC;

-- Example: Sorting customers by CustomerID in descending order
SELECT * FROM Customers ORDER BY CustomerID DESC;

-- ==========================================================
-- 4. GROUP BY Clause ? Used to group records based on a column.
-- ==========================================================

-- Syntax:
-- SELECT Column1, COUNT(*) FROM TableName GROUP BY Column1;

-- Example: Counting customers by email domain
SELECT SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS Domain, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email));

-- ==========================================================
-- 5. HAVING Clause ? Used to filter grouped records.
-- ==========================================================

-- Syntax:
-- SELECT Column1, COUNT(*) FROM TableName GROUP BY Column1 HAVING Condition;

-- Example: Filtering groups where total customers are more than 1
SELECT SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS Domain, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email))
HAVING COUNT(*) > 1;

-- ==========================================================
-- 6. JOIN Clause ? Used to combine data from multiple tables.
-- ==========================================================

-- Syntax:
-- SELECT Table1.Column1, Table2.Column2 FROM Table1
-- JOIN Table2 ON Table1.CommonColumn = Table2.CommonColumn;

-- Example: Joining Customers and Orders tables
SELECT Customers.CustomerID, Customers.Name, Orders.OrderID, Orders.Amount
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- ==========================================================
-- Example: Checking Data After DQL Operations
-- ==========================================================

-- Query to Retrieve All Customers
SELECT * FROM Customers;

-- ==========================================================
-- Summary:
-- ? SELECT ? Retrieves data from one or more tables.
-- ? WHERE ? Filters records based on conditions.
-- ? ORDER BY ? Sorts the result set.
-- ? GROUP BY ? Groups records based on a column.
-- ? HAVING ? Filters grouped records.
-- ? JOIN ? Combines data from multiple tables.
-- ==========================================================

-- End of Script
