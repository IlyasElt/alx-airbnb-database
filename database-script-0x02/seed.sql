-- Users
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('11111111-1111-1111-1111-111111111111', 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw_1', '555-0101', 'guest'),
('22222222-2222-2222-2222-222222222222', 'Bob', 'Smith', 'bob@example.com', 'hashed_pw_2', '555-0202', 'host'),
('33333333-3333-3333-3333-333333333333', 'Carol', 'Williams', 'carol@example.com', 'hashed_pw_3', '555-0303', 'admin'),
('44444444-4444-4444-4444-444444444444', 'David', 'Lee', 'david@example.com', 'hashed_pw_4', '555-0404', 'guest'),
('55555555-5555-5555-5555-555555555555', 'Emma', 'Brown', 'emma@example.com', 'hashed_pw_5', '555-0505', 'host');

-- Properties
INSERT INTO Properties (property_id, host_id, name, description, location, pricepernight)
VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '22222222-2222-2222-2222-222222222222', 'Cozy Apartment', 'A small but cozy apartment', 'New York', 120.00),
('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '22222222-2222-2222-2222-222222222222', 'Beach House', 'Spacious beach house', 'Miami', 350.00),
('aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '55555555-5555-5555-5555-555555555555', 'Mountain Cabin', 'Quiet cabin in the mountains', 'Colorado', 200.00);

-- Bookings
INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', '2025-11-10', '2025-11-15', 600.00, 'confirmed'),
('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '44444444-4444-4444-4444-444444444444', '2025-12-01', '2025-12-07', 2450.00, 'pending'),
('bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3', 'aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '11111111-1111-1111-1111-111111111111', '2025-11-20', '2025-11-25', 1000.00, 'confirmed');

-- Payments
INSERT INTO Payments (payment_id, booking_id, amount, payment_method)
VALUES
('ccccccc1-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 600.00, 'credit_card'),
('ccccccc2-cccc-cccc-cccc-ccccccccccc2', 'bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 2450.00, 'paypal'),
('ccccccc3-cccc-cccc-cccc-ccccccccccc3', 'bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3', 1000.00, 'stripe');

-- Reviews
INSERT INTO Reviews (review_id, property_id, user_id, rating, comment)
VALUES
('ddddddd1-dddd-dddd-dddd-ddddddddddd1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', 5, 'Loved the stay!'),
('ddddddd2-dddd-dddd-dddd-ddddddddddd2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '44444444-4444-4444-4444-444444444444', 4, 'Great location, a bit pricey.'),
('ddddddd3-dddd-dddd-dddd-ddddddddddd3', 'aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '11111111-1111-1111-1111-111111111111', 5, 'Perfect for a weekend getaway!');

-- Messages
INSERT INTO Messages (message_id, sender_id, recipient_id, message_body)
VALUES
('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi Bob, is the apartment available next week?'),
('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2', '44444444-4444-4444-4444-444444444444', '55555555-5555-5555-5555-555555555555', 'Can I book the mountain cabin for next month?'),
('eeeeeee3-eeee-eeee-eeee-eeeeeeeeeee3', '11111111-1111-1111-1111-111111111111', '55555555-5555-5555-5555-555555555555', 'Thanks for confirming the booking!');
