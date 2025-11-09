-- =============================================
-- Database Indexing for Performance Optimization
-- Project: Airbnb Clone
-- =============================================

-- Note: Primary keys (user_id, property_id, booking_id, etc.) 
-- are automatically indexed, so we don't create indexes for them.

-- =============================================
-- USERS TABLE INDEXES
-- =============================================

-- Index on email for fast login queries
-- Used in: WHERE email = ? (login authentication)
CREATE INDEX idx_users_email ON Users(email);

-- Index on role for filtering users by type
-- Used in: WHERE role = 'host' or WHERE role = 'guest'
CREATE INDEX idx_users_role ON Users(role);


-- =============================================
-- PROPERTIES TABLE INDEXES
-- =============================================

-- Index on host_id for finding properties by host
-- Used in: JOIN and WHERE host_id = ?
CREATE INDEX idx_properties_host_id ON Properties(host_id);

-- Index on location for property searches
-- Used in: WHERE location = 'California'
CREATE INDEX idx_properties_location ON Properties(location);

-- Index on pricepernight for price range searches
-- Used in: WHERE pricepernight BETWEEN 50 AND 150
CREATE INDEX idx_properties_price ON Properties(pricepernight);

-- Composite index for location + price searches (most common query)
-- Used in: WHERE location = ? AND pricepernight < ?
CREATE INDEX idx_properties_location_price ON Properties(location, pricepernight);


-- =============================================
-- BOOKINGS TABLE INDEXES
-- =============================================

-- Index on property_id for finding bookings by property
-- Used in: JOIN and WHERE property_id = ?
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);

-- Index on user_id for finding user's bookings
-- Used in: JOIN and WHERE user_id = ?
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);

-- Index on status for filtering by booking status
-- Used in: WHERE status = 'confirmed'
CREATE INDEX idx_bookings_status ON Bookings(status);

-- Composite index on start_date and end_date for availability checks
-- Used in: WHERE start_date <= ? AND end_date >= ?
CREATE INDEX idx_bookings_dates ON Bookings(start_date, end_date);

-- Composite index for checking property availability
-- Most important for preventing double bookings!
CREATE INDEX idx_bookings_property_dates ON Bookings(property_id, start_date, end_date);


-- =============================================
-- REVIEWS TABLE INDEXES
-- =============================================

-- Index on property_id for getting property reviews
-- Used in: JOIN and WHERE property_id = ?
CREATE INDEX idx_reviews_property_id ON Reviews(property_id);

-- Index on user_id for getting user's reviews
-- Used in: JOIN and WHERE user_id = ?
CREATE INDEX idx_reviews_user_id ON Reviews(user_id);

-- Index on rating for finding high-rated properties
-- Used in: WHERE rating >= 4
CREATE INDEX idx_reviews_rating ON Reviews(rating);


-- =============================================
-- PAYMENTS TABLE INDEXES
-- =============================================

-- Index on booking_id for payment lookups
-- Used in: JOIN and WHERE booking_id = ?
CREATE INDEX idx_payments_booking_id ON Payments(booking_id);

-- Index on payment_method for reporting
-- Used in: WHERE payment_method = 'credit_card'
CREATE INDEX idx_payments_method ON Payments(payment_method);


-- =============================================
-- MESSAGES TABLE INDEXES
-- =============================================

-- Index on sender_id for finding sent messages
-- Used in: WHERE sender_id = ?
CREATE INDEX idx_messages_sender_id ON Messages(sender_id);

-- Index on recipient_id for finding received messages
-- Used in: WHERE recipient_id = ?
CREATE INDEX idx_messages_recipient_id ON Messages(recipient_id);


