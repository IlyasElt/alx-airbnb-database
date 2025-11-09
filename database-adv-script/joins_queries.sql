-- =============================================
-- Task 0: SQL Joins Practice
-- Database: Airbnb Clone
-- Schema: Users, Bookings, Properties, Reviews
-- =============================================

-- Query 1: INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings
-- =============================================
-- Purpose: Show complete booking information with user details
-- Use Case: Admin dashboard showing all reservations with customer info

SELECT 
    Bookings.booking_id,
    Bookings.property_id,
    Bookings.start_date,
    Bookings.end_date,
    Bookings.total_price,
    Bookings.status,
    Users.user_id,
    Users.first_name,
    Users.last_name,
    Users.email,
    Users.phone_number,
    Users.role
FROM 
    Bookings
INNER JOIN 
    Users ON Bookings.user_id = Users.user_id
ORDER BY 
    Bookings.created_at DESC;


-- =============================================
-- Query 2: LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews
-- =============================================
-- Purpose: Display all property listings with review information when available
-- Use Case: Property listing page showing ratings (or "No reviews yet")

SELECT 
    Properties.property_id,
    Properties.name AS property_name,
    Properties.location,
    Properties.pricepernight,
    Properties.description,
    Reviews.review_id,
    Reviews.rating,
    Reviews.comment,
    Reviews.created_at AS review_date,
    CONCAT(Users.first_name, ' ', Users.last_name) AS reviewer_name
FROM 
    Properties
LEFT JOIN 
    Reviews ON Properties.property_id = Reviews.property_id
LEFT JOIN
    Users ON Reviews.user_id = Users.user_id
ORDER BY 
    Properties.property_id, Reviews.created_at DESC;


-- =============================================
-- Query 3: FULL OUTER JOIN
-- Retrieve all users and all bookings, even if the user has no booking 
-- or a booking is not linked to a user
-- =============================================
-- Purpose: Data integrity check to find users without bookings and orphaned bookings
-- Use Case: Database audit and user engagement analysis

-- MySQL Implementation (using UNION to simulate FULL OUTER JOIN)
SELECT 
    Users.user_id,
    Users.first_name,
    Users.last_name,
    Users.email,
    Users.role,
    Bookings.booking_id,
    Bookings.property_id,
    Bookings.start_date,
    Bookings.end_date,
    Bookings.total_price,
    Bookings.status
FROM 
    Users
LEFT JOIN 
    Bookings ON Users.user_id = Bookings.user_id

UNION

SELECT 
    Users.user_id,
    Users.first_name,
    Users.last_name,
    Users.email,
    Users.role,
    Bookings.booking_id,
    Bookings.property_id,
    Bookings.start_date,
    Bookings.end_date,
    Bookings.total_price,
    Bookings.status
FROM 
    Users
RIGHT JOIN 
    Bookings ON Users.user_id = Bookings.user_id
ORDER BY 
    user_id, booking_id;