-- =============================================
-- Task 1: Subqueries Practice
-- Database: Airbnb Clone
-- Author: ILYAS EL ATTAR
-- =============================================

-- =============================================
-- Query 1: NON-CORRELATED SUBQUERY
-- Find all properties where the average rating is greater than 4.0
-- =============================================
-- Purpose: Identify high-quality properties for featured listings
-- Use Case: "Premium Properties" section on homepage

SELECT 
    property_id,
    name AS property_name,
    location,
    pricepernight,
    description
FROM 
    Properties
WHERE 
    property_id IN (
        SELECT property_id
        FROM Reviews
        GROUP BY property_id
        HAVING AVG(rating) > 4.0
    )
ORDER BY 
    name;


-- =============================================
-- Query 2: CORRELATED SUBQUERY
-- Find users who have made more than 3 bookings
-- =============================================
-- Purpose: Identify frequent travelers for loyalty program
-- Use Case: Send special offers to active users

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    role,
    phone_number,
    (SELECT COUNT(*) 
     FROM Bookings b 
     WHERE b.user_id = Users.user_id) AS total_bookings
FROM 
    Users
WHERE 
    (SELECT COUNT(*) 
     FROM Bookings b 
     WHERE b.user_id = Users.user_id) > 3
ORDER BY 
    total_bookings DESC;
