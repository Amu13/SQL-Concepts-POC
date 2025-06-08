-- ==========================================================
-- SQL Script: Understanding Foreign Keys in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains the concept of Foreign Keys 
-- and demonstrates their usage with examples.
-- ==========================================================

-- ==========================================================
-- Foreign Key ? A column (or set of columns) that establishes a relationship 
--               between two tables by referencing the Primary Key of another table.
-- ==========================================================

-- Foreign keys ensure:
-- ? Referential integrity (Data consistency between tables)
-- ? Prevent orphaned records (Cannot insert a record without a valid reference)
-- ? Enable cascading actions (ON DELETE CASCADE, ON UPDATE CASCADE)

-- ==========================================================
-- Example: Foreign Key Relationship Between Customers and Orders
-- ==========================================================

-- Step 1: Create the Customers table with a Primary Key
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,  -- Primary Key (Referenced by Orders)
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);

-- Step 2: Create the Orders table with a Foreign Key referencing Customers
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,     -- Primary Key
    CustomerID INT,              -- Foreign Key referencing Customers(CustomerID)
    OrderDate DATETIME,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)  -- Foreign Key Definition
);

-- ==========================================================
-- Example: Foreign Key with Cascading Actions
-- ==========================================================

-- Step 3: Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,  -- Primary Key
    Name VARCHAR(100),
    Price DECIMAL(10,2)
);

-- Step 4: Create the OrderDetails table with a Foreign Key referencing Orders and Products
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY, -- Primary Key
    OrderID INT,                   -- Foreign Key referencing Orders(OrderID)
    ProductID INT,                  -- Foreign Key referencing Products(ProductID)
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) 
    ON DELETE CASCADE -- If an order is deleted, delete related order details
    ON UPDATE CASCADE, -- If an order ID changes, update related order details
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ==========================================================
-- Explanation of Cascading Actions:
-- ? ON DELETE CASCADE ? If an order is deleted, its related order details are also deleted.
-- ? ON UPDATE CASCADE ? If an order ID changes, the related order details are updated automatically.
-- ==========================================================

-- ==========================================================
-- Example Queries to Demonstrate Foreign Key Behavior
-- ==========================================================

-- Insert data into Customers
INSERT INTO Customers (CustomerID, Name, Email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Customers (CustomerID, Name, Email) VALUES (2, 'Bob', 'bob@example.com');

-- Insert data into Orders (Referencing Customers)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES (101, 1, '2025-06-08', 250.00);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES (102, 2, '2025-06-08', 150.00);

-- Insert data into Products
INSERT INTO Products (ProductID, Name, Price) VALUES (201, 'Laptop', 1200.00);
INSERT INTO Products (ProductID, Name, Price) VALUES (202, 'Mouse', 25.00);

-- Insert data into OrderDetails (Referencing Orders and Products)
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES (1, 101, 201, 1);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES (2, 102, 202, 2);

-- ==========================================================
-- Example: Deleting a Customer and Checking Cascading Effect
-- ==========================================================

-- Delete a customer (Will fail if referenced in Orders)
DELETE FROM Customers WHERE CustomerID = 1;  -- Will fail due to foreign key constraint

-- Delete an order (Will cascade delete related OrderDetails)
DELETE FROM Orders WHERE OrderID = 101;  -- OrderDetails with OrderID = 101 will also be deleted

-- ==========================================================
-- Summary:
-- ? Foreign Key ? Establishes relationships between tables.
-- ? Ensures referential integrity (Prevents orphaned records).
-- ? Supports cascading actions (ON DELETE CASCADE, ON UPDATE CASCADE).
-- ==========================================================

-- End of Script
