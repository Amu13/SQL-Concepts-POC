-- The COALESCE function in SQL Server returns the first non-null value from a list of expressions.
-- It is useful for handling NULL values and ensuring that queries return meaningful data.

-- Syntax:
-- COALESCE(expression1, expression2, ..., expressionN)
-- It evaluates the expressions in order and returns the first non-null value.

-- Create a sample Employees table
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    MiddleName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Insert sample data
INSERT INTO Employees (ID, FirstName, MiddleName, LastName) VALUES 
(1, 'John', NULL, 'Doe'),   -- MiddleName is NULL
(2, 'Jane', 'Marie', 'Smith'), -- MiddleName has a value
(3, 'Robert', NULL, 'Brown');  -- MiddleName is NULL

-- Select data using COALESCE to handle NULL values
SELECT ID, FirstName, COALESCE(MiddleName, 'N/A') AS MiddleName, LastName,
       FirstName + ' ' + COALESCE(MiddleName, '') + ' ' + LastName AS FullName
FROM Employees;

-- Expected Output:
-- | ID | FirstName | MiddleName | LastName | FullName        |
-- |----|----------|------------|----------|----------------|
-- | 1  | John     | N/A        | Doe      | John Doe       |
-- | 2  | Jane     | Marie      | Smith    | Jane Marie Smith |
-- | 3  | Robert   | N/A        | Brown    | Robert Brown   |
--
-- Explanation:
-- - If MiddleName is NULL, it is replaced with 'N/A' in the output for better readability.
-- - The FullName column concatenates FirstName, MiddleName (if present), and LastName.
