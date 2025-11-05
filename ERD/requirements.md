Airbnb Database ERD Requirements

Entities and Attributes

1. Users
Represents all users of the platform (guests, hosts, admins).

Attributes:

user_id (PK, UUID, Indexed)

first_name, last_name

email (Unique, NOT NULL)

password_hash (NOT NULL)

phone_number (nullable)

role (ENUM: guest, host, admin, NOT NULL)

created_at (TIMESTAMP, default CURRENT_TIMESTAMP)

Constraints: Unique email, non-null required fields

2. Properties
Represents rental properties listed by hosts.

Attributes:

property_id (PK, UUID, Indexed)

host_id (FK → Users.user_id)

name, description, location (NOT NULL)

pricepernight (DECIMAL, NOT NULL)

created_at, updated_at

Constraints: Foreign key on host_id; non-null essential attributes

Indexes: property_id

3. Bookings
Represents bookings made by users for properties.

Attributes:

booking_id (PK, UUID, Indexed)

property_id (FK → Properties.property_id)

user_id (FK → Users.user_id)

start_date, end_date (NOT NULL)

total_price (DECIMAL, NOT NULL)

status (ENUM: pending, confirmed, canceled, NOT NULL)

created_at

Constraints: Foreign keys; valid status values

Indexes: booking_id

4. Payments
Represents payments for bookings.

Attributes:

payment_id (PK, UUID, Indexed)

booking_id (FK → Bookings.booking_id)

amount (DECIMAL, NOT NULL)

payment_date

payment_method (ENUM: credit_card, paypal, stripe, NOT NULL)

Constraints: Foreign key on booking_id

Indexes: payment_id

5. Reviews
Represents reviews left by users on properties.

Attributes:

review_id (PK, UUID, Indexed)

property_id (FK → Properties.property_id)

user_id (FK → Users.user_id)

rating (INTEGER, 1–5, NOT NULL)

comment (TEXT, NOT NULL)

created_at

Constraints: Rating between 1–5; foreign keys

Indexes: review_id

6. Messages
Represents messages exchanged between users.

Attributes:

message_id (PK, UUID, Indexed)

sender_id (FK → Users.user_id)

recipient_id (FK → Users.user_id)

message_body (TEXT, NOT NULL)

sent_at

Constraints: Foreign keys on sender and recipient

Indexes: message_id

- Relationships

User → Property = 1:N (A host can have multiple properties)

Property → Booking = 1:N (A property can have multiple bookings)

User → Booking = 1:N (A user can make multiple bookings)

Booking → Payment = 1:1 (Each booking has one payment)

Property → Review = 1:N (A property can have multiple reviews)

User → Review = 1:N (A user can leave multiple reviews)

User → Message (sender) = 1:N

User → Message (recipient) = 1:N