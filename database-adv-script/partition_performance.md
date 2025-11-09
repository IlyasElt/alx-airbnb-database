# Partitioning Performance Report

## Objective
Improve query performance on the `Bookings` table by partitioning it by the `start_date` column.

## Implementation
The `Bookings` table was refactored to use **RANGE partitioning** based on the **year of the start_date** column.

```sql
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);
```

## Query Tested:

To test the improvement, the following query was analyzed using EXPLAIN:

```sql
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
```

## Observations:

Partitioning allowed MySQL to prune irrelevant partitions, scanning only the relevant data.

Queries filtered by start_date became much faster, especially for large datasets.

Indexing combined with partitioning further enhanced efficiency.

## Conclusion:

Partitioning by start_date improved query performance by reducing the number of rows scanned.
This optimization is ideal for time-based data like bookings, where most queries target specific date ranges.