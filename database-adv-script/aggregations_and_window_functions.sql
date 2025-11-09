-- =============================================
-- Task 2: Aggregations and Window Functions
-- Database: Airbnb Clone
-- =============================================

-- =============================================
-- Query 1: AGGREGATION with COUNT and GROUP BY
-- Find the total number of bookings made by each user
-- =============================================

SELECT 
    Users.user_id,
    Users.first_name,
    Users.last_name,
    Users.email,
    Users.role,
    COUNT(Bookings.booking_id) AS total_bookings
FROM 
    Users
LEFT JOIN 
    Bookings ON Users.user_id = Bookings.user_id
GROUP BY 
    Users.user_id,
    Users.first_name,
    Users.last_name,
    Users.email,
    Users.role
ORDER BY 
    total_bookings DESC;


-- =============================================
-- Query 2a: WINDOW FUNCTION with ROW_NUMBER
-- Rank properties by total bookings (unique ranks)
-- =============================================

SELECT 
    property_id,
    name AS property_name,
    location,
    pricepernight,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_number_rank
FROM (
    SELECT 
        Properties.property_id,
        Properties.name,
        Properties.location,
        Properties.pricepernight,
        COUNT(Bookings.booking_id) AS total_bookings
    FROM 
        Properties
    LEFT JOIN 
        Bookings ON Properties.property_id = Bookings.property_id
    GROUP BY 
        Properties.property_id,
        Properties.name,
        Properties.location,
        Properties.pricepernight
) AS property_booking_counts
ORDER BY 
    row_number_rank;

-- =============================================
-- Query 2b: WINDOW FUNCTION with RANK
-- Rank properties by total bookings (allows ties)
-- =============================================

SELECT 
    property_id,
    name AS property_name,
    location,
    pricepernight,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank_position
FROM (
    SELECT 
        Properties.property_id,
        Properties.name,
        Properties.location,
        Properties.pricepernight,
        COUNT(Bookings.booking_id) AS total_bookings
    FROM 
        Properties
    LEFT JOIN 
        Bookings ON Properties.property_id = Bookings.property_id
    GROUP BY 
        Properties.property_id,
        Properties.name,
        Properties.location,
        Properties.pricepernight
) AS property_booking_counts
ORDER BY 
    rank_position;
