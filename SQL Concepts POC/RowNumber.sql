-- The ROW_NUMBER function assigns a unique row number to each record based on the specified ordering.
-- It is useful for pagination, ranking, and selecting specific rows from a dataset.

-- Syntax:
-- ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY column_name)
-- It generates a sequential row number for each partition of a result set.

-- Create a sample Employees table
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert sample data
INSERT INTO Employees (ID, FirstName, LastName, Department) VALUES 
(1, 'John', 'Doe', 'HR'),
(2, 'Jane', 'Smith', 'HR'),
(3, 'Robert', 'Brown', 'IT'),
(4, 'Emily', 'Davis', 'IT'),
(5, 'Michael', 'Wilson', 'Finance'),
(6, 'Sarah', 'Johnson', 'Finance');

-- Use ROW_NUMBER to assign row numbers to employees within each department
SELECT ID, FirstName, LastName, Department,
       ROW_NUMBER() OVER (PARTITION BY Department ORDER BY FirstName) AS RowNum
FROM Employees;

-- Expected Output:
-- | ID | FirstName | LastName | Department | RowNum |
-- |----|----------|----------|------------|--------|
-- | 1  | John     | Doe      | HR         | 1      |
-- | 2  | Jane     | Smith    | HR         | 2      |
-- | 3  | Robert   | Brown    | IT         | 2      |
-- | 4  | Emily    | Davis    | IT         | 1      |
-- | 5  | Michael  | Wilson   | Finance    | 2      |
-- | 6  | Sarah    | Johnson  | Finance    | 1      |
--
-- Explanation:
-- - The `ROW_NUMBER` function generates unique row numbers within each department.
-- - The numbering restarts for each department (`PARTITION BY Department`).
-- - Records are ordered alphabetically by `FirstName` before assigning row numbers.

