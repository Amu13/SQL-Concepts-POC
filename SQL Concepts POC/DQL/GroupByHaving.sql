-- ==========================================================
-- SQL Script: Real-Time Scenarios for GROUP BY and HAVING in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains real-world use cases for GROUP BY and HAVING, 
-- demonstrates their syntax, and provides input data with expected output.
-- ==========================================================

-- ==========================================================
-- What are GROUP BY and HAVING?
-- ==========================================================

-- ? GROUP BY ? Groups records based on a column and applies aggregate functions.
-- ? HAVING ? Filters grouped records based on aggregate conditions.

-- ==========================================================
-- Scenario 1: Counting Orders Per Customer
-- ==========================================================

-- Business Case:
-- A company wants to know how many orders each customer has placed.

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

-- Step 3: Use GROUP BY to Count Orders Per Customer
SELECT Customers.Name, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.Name;

-- Expected Output:
-- | Name    | TotalOrders |
-- |---------|------------|
-- | Alice   | 2          |
-- | Bob     | 2          |
-- | Charlie | 1          |

-- ==========================================================
-- Scenario 2: Filtering Customers with More Than One Order
-- ==========================================================

-- Business Case:
-- The company wants to find customers who have placed more than one order.

SELECT Customers.Name, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.Name
HAVING COUNT(Orders.OrderID) > 1;

-- Expected Output:
-- | Name    | TotalOrders |
-- |---------|------------|
-- | Alice   | 2          |
-- | Bob     | 2          |

-- ==========================================================
-- Scenario 3: Finding Total Sales Per Product and Filtering High-Selling Products
-- ==========================================================

-- Business Case:
-- A store wants to find total sales per product and filter products with total sales above $500.

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
INSERT INTO Products (ProductID, Name) VALUES (1, 'Laptop');
INSERT INTO Products (ProductID, Name) VALUES (2, 'Mouse');
INSERT INTO Products (ProductID, Name) VALUES (3, 'Keyboard');

INSERT INTO Sales (SaleID, ProductID, Quantity, Price) VALUES (201, 1, 2, 600.00);
INSERT INTO Sales (SaleID, ProductID, Quantity, Price) VALUES (202, 2, 5, 50.00);
INSERT INTO Sales (SaleID, ProductID, Quantity, Price) VALUES (203, 3, 3, 100.00);
INSERT INTO Sales (SaleID, ProductID, Quantity, Price) VALUES (204, 1, 1, 600.00);

-- Step 3: Use GROUP BY to Calculate Total Sales Per Product
SELECT Products.Name, SUM(Sales.Quantity * Sales.Price) AS TotalSales
FROM Products
JOIN Sales ON Products.ProductID = Sales.ProductID
GROUP BY Products.Name;

-- Expected Output:
-- | Name     | TotalSales |
-- |----------|-----------|
-- | Laptop   | 1800.00   |
-- | Mouse    | 250.00    |
-- | Keyboard | 300.00    |

-- Step 4: Use HAVING to Filter High-Selling Products
SELECT Products.Name, SUM(Sales.Quantity * Sales.Price) AS TotalSales
FROM Products
JOIN Sales ON Products.ProductID = Sales.ProductID
GROUP BY Products.Name
HAVING SUM(Sales.Quantity * Sales.Price) > 500;

-- Expected Output:
-- | Name    | TotalSales |
-- |---------|-----------|
-- | Laptop  | 1800.00   |

-- ==========================================================
-- Summary:
-- ? GROUP BY ? Groups records based on a column and applies aggregate functions.
-- ? HAVING ? Filters grouped records based on aggregate conditions.
-- ? Real-world use cases:
--    - Counting orders per customer.
--    - Filtering customers with more than one order.
--    - Finding total sales per product and filtering high-selling products.
-- ==========================================================

-- End of Script
