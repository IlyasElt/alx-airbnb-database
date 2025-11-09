-- =============================================
-- Task 4: Query Optimization
-- Database: Airbnb Clone
-- Author: ILYAS EL ATTAR
-- =============================================

-- =============================================
-- Step 1: Initial Complex Query
-- Retrieve all bookings along with user, property, and payment details
-- =============================================
-- Purpose: Provide a complete booking overview for admins or analytics
-- Potential Issue: Multiple JOINs can cause performance lag if not indexed properly

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pay.payment_id,
    pay.amount,
    pay.status AS payment_status,
    pay.payment_date
FROM 
    Bookings b
JOIN 
    Users u ON b.user_id = u.user_id
JOIN 
    Properties p ON b.property_id = p.property_id
LEFT JOIN 
    Payments pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.created_at DESC;

-- =============================================
-- Step 2: Analyze Performance
-- Use EXPLAIN to identify inefficiencies
-- =============================================

EXPLAIN SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pay.payment_id,
    pay.amount,
    pay.status AS payment_status,
    pay.payment_date
FROM 
    Bookings b
JOIN 
    Users u ON b.user_id = u.user_id
JOIN 
    Properties p ON b.property_id = p.property_id
LEFT JOIN 
    Payments pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.created_at DESC;

-- Expected EXPLAIN output (example):
-- type=ALL for some tables (full table scan)
-- possible_keys=NULL for Payments
-- Using temporary; Using filesort

-- =============================================
-- Step 3: Optimized Query
-- =============================================
-- Improvements:
-- - Ensured indexes exist on join columns
-- - Reduced selected columns to only essential fields
-- - Replaced ORDER BY on non-indexed column if necessary
-- - Confirmed index usage via EXPLAIN

-- Indexes used:
--   idx_bookings_user_id (Bookings.user_id)
--   idx_bookings_property_id (Bookings.property_id)
--   idx_payments_booking_id (Payments.booking_id)

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount,
    pay.status AS payment_status
FROM 
    Bookings b
JOIN 
    Users u ON b.user_id = u.user_id
JOIN 
    Properties p ON b.property_id = p.property_id
LEFT JOIN 
    Payments pay ON b.booking_id = pay.booking_id;

-- =============================================
-- Step 4: Analyze Optimized Query
-- =============================================

EXPLAIN SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount,
    pay.status AS payment_status
FROM 
    Bookings b
JOIN 
    Users u ON b.user_id = u.user_id
JOIN 
    Properties p ON b.property_id = p.property_id
LEFT JOIN 
    Payments pay ON b.booking_id = pay.booking_id;

-- Expected result:
-- type=ref or eq_ref for join operations
-- key=idx_* columns used
-- rows reduced significantly
