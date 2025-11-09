# Task 0: SQL Joins

## Objective
Master SQL joins by writing complex queries using different types of joins to combine data from multiple tables in the Airbnb database.

## Database Schema
This project uses the following tables:
- **Users** - User accounts (guests, hosts, admins)
- **Bookings** - Reservation records
- **Properties** - Property listings
- **Reviews** - Property reviews and ratings

## Queries Implemented

### 1. INNER JOIN - Bookings with Users
**Purpose:** Retrieve all bookings along with the user information for each booking.

**SQL Query:**
```sql
SELECT Bookings.*, Users.first_name, Users.last_name, Users.email
FROM Bookings
INNER JOIN Users ON Bookings.user_id = Users.user_id;
```

**Use Case:** Display a complete booking history with customer details for administrative purposes.

**Expected Result:** Only bookings that have a valid user associated with them (should be all bookings due to foreign key constraints).

**Key Columns:**
- booking_id, property_id, start_date, end_date, total_price, status
- user_id, first_name, last_name, email, phone_number, role

---

### 2. LEFT JOIN - Properties with Reviews
**Purpose:** Retrieve all properties and their reviews, including properties that have no reviews yet.

**SQL Query:**
```sql
SELECT Properties.*, Reviews.rating, Reviews.comment
FROM Properties
LEFT JOIN Reviews ON Properties.property_id = Reviews.property_id;
```

**Use Case:** Show all property listings on the website, with ratings when available, so new properties without reviews still appear.

**Expected Result:** 
- All properties appear in the result
- Properties with reviews show the review data
- Properties without reviews show NULL for review columns

**Key Insight:** This is crucial for displaying new listings that haven't received reviews yet.

---

### 3. FULL OUTER JOIN - Users and Bookings
**Purpose:** Retrieve all users and all bookings, even if there's no match between them.

**SQL Query:**
```sql
-- Using UNION to simulate FULL OUTER JOIN in MySQL
SELECT Users.*, Bookings.* FROM Users LEFT JOIN Bookings ON Users.user_id = Bookings.user_id
UNION
SELECT Users.*, Bookings.* FROM Users RIGHT JOIN Bookings ON Users.user_id = Bookings.user_id;
```

**Use Case:** Data integrity check to find:
- Users who registered but never made a booking (potential engagement issue)
- Orphaned bookings with no user (data corruption issue)

**Expected Result:** 
- All users appear (including those with no bookings)
- All bookings appear (including orphaned ones, if any)
- NULL values where there's no match

**Key Insight:** Helps identify inactive users and potential database issues.

**Note:** MySQL doesn't support FULL OUTER JOIN natively, so we use a UNION of LEFT and RIGHT joins.

---

## How to Run

### Prerequisites
- MySQL database server
- Access to the airbnb_clone database
- Tables created from previous schema definition

### Execution
```bash
# Connect to MySQL
mysql -u your_username -p

# Select database
USE airbnb_clone;

# Run the queries file
source joins_queries.sql;

# Or run directly
mysql -u your_username -p airbnb_clone < joins_queries.sql
```

---

## Key Learnings

### When to Use Each Join

| Join Type | Use When | Example |
|-----------|----------|---------|
| **INNER JOIN** | You only need matching records | Bookings with valid users |
| **LEFT JOIN** | You need all records from the first table | All properties (with or without reviews) |
| **FULL OUTER JOIN** | You need all records from both tables | Finding gaps in data |

---

## Files
- `joins_queries.sql` - Contains all three join queries with detailed comments
- `README.md` - This documentation file