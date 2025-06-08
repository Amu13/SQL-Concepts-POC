-- ==========================================================
-- SQL Script: Understanding Data Types in SQL Server
-- Author: AMulya Adapa
-- Date: June 8, 2025
-- Description: This script explains different data types in SQL Server, 
-- demonstrates their syntax, and provides examples for numeric, string, date/time, binary, and special data types.
-- ==========================================================

-- ==========================================================
-- 1. Numeric Data Types
-- ==========================================================

-- Numeric data types store numbers, including integers, decimals, and floating-point values.

CREATE TABLE NumericData (
    ID INT PRIMARY KEY,  -- 4 bytes, range: -2,147,483,648 to 2,147,483,647
    SmallValue SMALLINT,  -- 2 bytes, range: -32,768 to 32,767
    LargeValue BIGINT,  -- 8 bytes, range: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
    DecimalValue DECIMAL(10,2),  -- Fixed precision and scale
    FloatingValue FLOAT  -- Approximate floating-point value
);

-- Insert sample data
INSERT INTO NumericData (ID, SmallValue, LargeValue, DecimalValue, FloatingValue)
VALUES (1, 100, 9999999999, 1234.56, 3.14159);

-- ==========================================================
-- 2. String Data Types
-- ==========================================================

-- String data types store text and character-based data.

CREATE TABLE StringData (
    ID INT PRIMARY KEY,
    FixedText CHAR(10),  -- Fixed-length string (10 characters)
    VariableText VARCHAR(100),  -- Variable-length string (max 100 characters)
    UnicodeText NVARCHAR(255)  -- Unicode string (supports multiple languages)
);

-- Insert sample data
INSERT INTO StringData (ID, FixedText, VariableText, UnicodeText)
VALUES (1, 'Hello', 'Welcome to SQL Server', N'?????');

-- ==========================================================
-- 3. Date and Time Data Types
-- ==========================================================

-- Date and time data types store date and time values.

CREATE TABLE DateTimeData (
    ID INT PRIMARY KEY,
    DateOnly DATE,  -- Stores only date
    TimeOnly TIME,  -- Stores only time
    FullDateTime DATETIME,  -- Stores both date and time
    PreciseDateTime DATETIME2  -- More precise datetime storage
);

-- Insert sample data
INSERT INTO DateTimeData (ID, DateOnly, TimeOnly, FullDateTime, PreciseDateTime)
VALUES (1, '2025-06-08', '14:30:00', '2025-06-08 14:30:00', '2025-06-08 14:30:00.123456');

-- ==========================================================
-- 4. Binary Data Types
-- ==========================================================

-- Binary data types store binary data such as images, files, and encrypted data.

CREATE TABLE BinaryData (
    ID INT PRIMARY KEY,
    FixedBinary BINARY(16),  -- Fixed-length binary data
    VariableBinary VARBINARY(MAX)  -- Variable-length binary data
);

-- Insert sample data
INSERT INTO BinaryData (ID, FixedBinary, VariableBinary)
VALUES (1, 0x1234567890ABCDEF, 0xABCDEF1234567890);

-- ==========================================================
-- 5. Special Data Types
-- ==========================================================

-- Special data types store unique identifiers, XML, and JSON data.

CREATE TABLE SpecialData (
    ID UNIQUEIDENTIFIER DEFAULT NEWID(),  -- Globally unique identifier (GUID)
    XMLData XML,  -- Stores XML data
    JSONData NVARCHAR(MAX)  -- Stores JSON as text
);

-- Insert sample data
INSERT INTO SpecialData (XMLData, JSONData)
VALUES ('<Customer><Name>Alice</Name></Customer>', '{"Customer": {"Name": "Alice"}}');

-- ==========================================================
-- Summary:
-- ? Numeric Data Types ? INT, DECIMAL, FLOAT, BIGINT
-- ? String Data Types ? VARCHAR, NVARCHAR, TEXT
-- ? Date/Time Data Types ? DATETIME, DATE, TIME
-- ? Binary Data Types ? VARBINARY, IMAGE
-- ? Special Data Types ? UNIQUEIDENTIFIER, XML, JSON
-- ==========================================================

-- End of Script
