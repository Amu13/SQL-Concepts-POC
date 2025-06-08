-- ==========================================================
-- SQL Script: Real-Time Scenarios for GROUP BY and WHERE in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains real-world use cases for GROUP BY and WHERE, 
-- demonstrates their syntax, and provides input data with expected output.
-- ==========================================================

-- ==========================================================
-- What are GROUP BY and WHERE?
-- ==========================================================

-- ? GROUP BY ? Groups records based on a column and applies aggregate functions.
-- ? WHERE ? Filters individual rows before grouping.

-- ==========================================================
-- Scenario 1: Counting Orders Per Customer, Filtering Orders Above $100
-- ==========================================================

-- Business Case:
-- A company wants to count the number of orders per customer, but only for orders where the amount is greater than $100.

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

INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (101, 1, 250.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (102, 1, 150.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (103, 2, 300.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (104, 2, 100.00);
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES (105, 3, 50.00);

-- Step 3: Use WHERE and GROUP BY Together
SELECT Customers.Name, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.Amount > 100
GROUP BY Customers.Name;

-- Expected Output:
-- | Name    | TotalOrders |
-- |---------|------------|
-- | Alice   | 2          |
-- | Bob     | 1          |

-- ==========================================================
-- Scenario 2: Finding High-Selling Products
-- ==========================================================

-- Business Case:
-- A store wants to calculate total sales per product, but only for products priced above $50.

-- Step 1: Create the Products and Sales tables
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Step 2: Insert Sample Data
INSERT INTO Products (ProductID, Name) VALUES