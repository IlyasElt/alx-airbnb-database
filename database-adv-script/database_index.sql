-- Performance measurement: BEFORE creating indexes

-- Test Query 1: Properties by location
EXPLAIN ANALYZE SELECT * FROM Properties WHERE location = 'California';

-- Test Query 2: User login
EXPLAIN ANALYZE SELECT * FROM Users WHERE email = 'user@example.com';

-- Test Query 3: Bookings for a property
EXPLAIN ANALYZE SELECT * FROM Bookings WHERE property_id = 'abc123';


-- =============================================
-- CREATE INDEXES
-- =============================================

-- Users table
CREATE INDEX idx_users_email ON Users(email);

-- Properties table
CREATE INDEX idx_properties_host_id ON Properties(host_id);
CREATE INDEX idx_properties_location ON Properties(location);
CREATE INDEX idx_properties_price ON Properties(pricepernight);

-- Bookings table
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);
CREATE INDEX idx_bookings_dates ON Bookings(start_date, end_date);

-- Reviews table
CREATE INDEX idx_reviews_property_id ON Reviews(property_id);

-- Payments table
CREATE INDEX idx_payments_booking_id ON Payments(booking_id);


-- =============================================
-- Performance measurement: AFTER creating indexes
-- =============================================

-- Test Query 1: Properties by location (with index)
EXPLAIN ANALYZE SELECT * FROM Properties WHERE location = 'California';

-- Test Query 2: User login (with index)
EXPLAIN ANALYZE SELECT * FROM Users WHERE email = 'user@example.com';

-- Test Query 3: Bookings for a property (with index)
EXPLAIN ANALYZE SELECT * FROM Bookings WHERE property_id = 'abc123';