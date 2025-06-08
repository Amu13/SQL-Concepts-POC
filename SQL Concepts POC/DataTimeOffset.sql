-- ==========================================================
-- SQL Script: Understanding DATETIMEOFFSET and UTC in SQL Server
-- Author: Amulya Adapa
-- Date: June 8, 2025
-- Description: This script explains how DATETIMEOFFSET works, how to store UTC time, 
-- and how to convert between time zones using SWITCHOFFSET and DATEPART.
-- ==========================================================

-- ==========================================================
-- 1. What is DATETIMEOFFSET?
-- ==========================================================

-- ? DATETIMEOFFSET stores date, time, and time zone offset.
-- ? +00:00 means UTC (Universal Coordinated Time).
-- ? Other offsets indicate time zones relative to UTC (e.g., +05:30 for India Standard Time).

-- ==========================================================
-- 2. Creating a Table with DATETIMEOFFSET
-- ==========================================================

CREATE TABLE EventLog (
    EventID INT PRIMARY KEY,
    EventTime DATETIMEOFFSET(7)  -- Stores date, time, and time zone offset
);

-- ==========================================================
-- 3. Inserting Data with UTC Time (+00:00)
-- ==========================================================

INSERT INTO EventLog (EventID, EventTime)
VALUES (1, '2025-06-08 14:30:00.1234567 +00:00');  -- UTC Time

INSERT INTO EventLog (EventID, EventTime)
VALUES (2, '2025-06-08 14:30:00.1234567 +05:30');  -- India Standard Time (IST)

-- ==========================================================
-- 4. Converting Local Time to UTC
-- ==========================================================

-- Use SWITCHOFFSET() to convert a local time to UTC (+00:00)
SELECT EventTime, SWITCHOFFSET(EventTime, '+00:00') AS UTC_Time
FROM EventLog;

-- Expected Output:
-- | EventTime                      | UTC_Time                      |
-- |--------------------------------|------------------------------|
-- | 2025-06-08 14:30:00.1234567 +00:00 | 2025-06-08 14:30:00.1234567 +00:00 |
-- | 2025-06-08 14:30:00.1234567 +05:30 | 2025-06-08 09:00:00.1234567 +00:00 |

-- ==========================================================
-- 5. Extracting Time Zone Offset
-- ==========================================================

-- Use DATEPART(TZOFFSET, EventTime) to get the time zone offset
SELECT EventTime, DATEPART(TZOFFSET, EventTime) AS TimeZoneOffset
FROM EventLog;

-- Expected Output:
-- | EventTime                      | TimeZoneOffset |
-- |--------------------------------|---------------|
-- | 2025-06-08 14:30:00.1234567 +00:00 | 0             |
-- | 2025-06-08 14:30:00.1234567 +05:30 | 330           |

-- ==========================================================
-- Summary:
-- ? DATETIMEOFFSET stores date, time, and time zone offset.
-- ? +00:00 means UTC (Universal Coordinated Time).
-- ? Use SWITCHOFFSET() to convert local time to UTC.
-- ? Use DATEPART(TZOFFSET, EventTime) to extract the time zone offset.
-- ==========================================================

-- End of Script
