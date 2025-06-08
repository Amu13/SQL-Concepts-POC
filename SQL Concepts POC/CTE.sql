-- Definition of Common Table Expression (CTE)
-- A CTE is a temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement.
-- It improves query readability and helps break down complex queries.

-- Types of CTEs:
-- 1. Non-Recursive CTE: A simple query used for readability.
-- 2. Recursive CTE: A self-referencing query used for hierarchical data.

-- Syntax of a CTE:
--WITH cte_name (column1, column2, ...) AS (
--    -- SQL query definition
--)
--SELECT * FROM cte_name;

-- Example: Filtering Employees with Salary above 50,000
WITH HighSalaryEmployees AS (
    SELECT EmployeeID, Name, Salary
    FROM Employees
    WHERE Salary > 50000
)
SELECT * FROM HighSalaryEmployees;

-- Expected Output:
-- | EmployeeID | Name    | Salary  |
-- |------------|--------|-------- |
-- | 101        | Alice  | 60000   |
-- | 102        | Bob    | 70000   |

-- Recursive CTE Example: Employee Hierarchy

-- Definition:
-- A Recursive CTE allows querying hierarchical data by referencing itself in a recursive query.

-- Syntax:
--WITH cte_name (column1, column2, ...) AS (
--    -- Anchor Query: Base case of recursion
--    SELECT column1, column2, ... FROM table WHERE condition

--    UNION ALL

--    -- Recursive Query: References itself to find additional rows
--    SELECT column1, column2, ... FROM table
--    JOIN cte_name ON condition
--)

SELECT * FROM cte_name;

-- Example: Employee Hierarchy using Recursive CTE
WITH EmployeeHierarchy AS (
    -- Anchor Query: Get the top-level manager (Alice)
    SELECT EmployeeID, Name, ManagerID, 1 AS HierarchyLevel
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive Query: Get employees reporting to the previous level
    SELECT e.EmployeeID, e.Name, e.ManagerID, eh.HierarchyLevel + 1
    FROM Employees e
    JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)

SELECT * FROM EmployeeHierarchy;

-- Expected Output:
-- | EmployeeID | Name    | ManagerID | HierarchyLevel |
-- |------------|--------|-----------|----------------|
-- | 1          | Alice  | NULL      | 1              |
-- | 2          | Bob    | 1         | 2              |
-- | 3          | Charlie | 2        | 3              |
-- | 4          | David  | 2         | 3              |
-- | 5          | Eve    | 3         | 4              |
