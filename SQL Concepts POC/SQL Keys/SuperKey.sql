-- ==========================================================
-- SQL Script: Best Practices for Designing with Super Keys
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script demonstrates best practices for 
-- using super keys in SQL Server database design.
-- ==========================================================

-- ==========================================================
-- 1. Choose Minimal Super Keys as Primary Keys
-- ==========================================================
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,  -- Minimal super key
    Email VARCHAR(100) UNIQUE,   -- Alternative super key
    Phone VARCHAR(15) UNIQUE     -- Alternative super key
);

-- ==========================================================
-- 2. Use Unique Constraints for Alternative Super Keys
-- ==========================================================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,  -- Minimal super key
    Email VARCHAR(100) UNIQUE,   -- Alternative super key
    Phone VARCHAR(15) UNIQUE     -- Alternative super key
);

-- ==========================================================
-- 3. Avoid Redundant Attributes in Super Keys
-- ==========================================================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,     -- Minimal super key
    CustomerID INT,
    OrderDate DATETIME,
    UNIQUE (CustomerID, OrderDate)  -- Minimal super key ensuring uniqueness
);

-- ==========================================================
-- 4. Optimize Indexing for Super Keys
-- ==========================================================
CREATE UNIQUE INDEX idx_email ON Customers(Email);
CREATE UNIQUE INDEX idx_phone ON Customers(Phone);

-- ==========================================================
-- 5. Use Composite Super Keys Only When Necessary
-- ==========================================================
CREATE TABLE ProductReviews (
    CustomerID INT,
    ProductID INT,
    ReviewText TEXT,
    PRIMARY KEY (CustomerID, ProductID)  -- Composite super key
);

-- ==========================================================
-- 6. Normalize Tables to Avoid Super Key Duplication
-- ==========================================================
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,  -- Minimal super key
    Name VARCHAR(100),
    SKU VARCHAR(20) UNIQUE      -- Alternative super key
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    StockQuantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ==========================================================
-- 7. Use Foreign Keys to Maintain Referential Integrity
-- ==========================================================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,  -- Minimal super key
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- ==========================================================
-- 8. Avoid Changing Super Keys Frequently
-- ==========================================================
CREATE TABLE Users (
    UserID INT PRIMARY KEY,  -- Stable identifier (Minimal super key)
    Email VARCHAR(100) UNIQUE,  -- Alternative super key
    Phone VARCHAR(15) UNIQUE    -- Alternative super key
);

-- ==========================================================
-- 9. Consider Performance When Choosing Super Keys
-- ==========================================================
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,  -- Efficient numeric key (Minimal super key)
    SKU VARCHAR(20) UNIQUE,     -- Alternative super key
    Name VARCHAR(100)
);

-- ==========================================================
-- 10. Document Super Keys for Future Maintenance
-- ==========================================================
-- ProductID is the primary key (minimal super key)
-- SKU is a unique identifier (alternative super key)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    SKU VARCHAR(20) UNIQUE,
    Name VARCHAR(100)
);

-- ==========================================================
-- Real-World Example: E-Commerce System
-- ==========================================================
-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,  -- Minimal super key
    Email VARCHAR(100) UNIQUE,   -- Alternative super key
    Phone VARCHAR(15) UNIQUE     -- Alternative super key
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,  -- Minimal super key
    CustomerID INT,
    OrderDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,  -- Minimal super key
    SKU VARCHAR(20) UNIQUE,     -- Alternative super key
    Name VARCHAR(100)
);

-- Reviews Table (Many-to-Many Relationship)
CREATE TABLE ProductReviews (
    CustomerID INT,
    ProductID INT,
    ReviewText TEXT,
    PRIMARY KEY (CustomerID, ProductID)  -- Composite super key
);

-- ==========================================================
-- Optimized Queries Using Super Keys
-- ==========================================================
-- Finding a Customer by Email
SELECT * FROM Customers WHERE Email = 'user@example.com';

-- Fetching Orders for a Customer
SELECT * FROM Orders WHERE CustomerID = 101;

-- ==========================================================
-- End of Script
-- ==========================================================
