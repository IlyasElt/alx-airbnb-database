-- =============================================
-- Task: Table Partitioning on Bookings Table
-- Objective: Optimize queries by partitioning Bookings by start_date
-- =============================================

-- Recreate the Bookings table with partitioning on start_date
CREATE TABLE Bookings (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending','confirmed','canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- =============================================
-- Test query performance on partitioned table
-- =============================================

-- Query bookings for 2024 to see which partitions are accessed
EXPLAIN
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    p.name AS property_name
FROM Bookings AS b
JOIN Users AS u ON b.user_id = u.user_id
JOIN Properties AS p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND b.status = 'confirmed';

-- =============================================
-- Expected Result:
-- MySQL scans only the partition p2024 instead of the full table
-- =============================================
