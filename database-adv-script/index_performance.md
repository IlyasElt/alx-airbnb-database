# Database Indexing and Performance Analysis

## Objective
Identify high-usage columns and create indexes to improve query performance in the Airbnb Clone database.

---

## High-Usage Columns Identified

### Users Table
| Column | Usage | Index Created |
|--------|-------|---------------|
| `email` | Login queries (WHERE email = ?) | `idx_users_email` |
| `role` | Filter by user type | `idx_users_role` |

### Properties Table
| Column | Usage | Index Created |
|--------|-------|---------------|
| `host_id` | JOIN with users, filter by host | `idx_properties_host_id` |
| `location` | Property search filters | `idx_properties_location` |
| `pricepernight` | Price range searches | `idx_properties_price` |
| `location, pricepernight` | Combined searches | `idx_properties_location_price` |

### Bookings Table
| Column | Usage | Index Created |
|--------|-------|---------------|
| `property_id` | JOIN with properties | `idx_bookings_property_id` |
| `user_id` | JOIN with users | `idx_bookings_user_id` |
| `status` | Filter by booking status | `idx_bookings_status` |
| `start_date, end_date` | Date range searches | `idx_bookings_dates` |
| `property_id, start_date, end_date` | Availability checks | `idx_bookings_property_dates` |

### Reviews Table
| Column | Usage | Index Created |
|--------|-------|---------------|
| `property_id` | JOIN with properties | `idx_reviews_property_id` |
| `user_id` | JOIN with users | `idx_reviews_user_id` |
| `rating` | Filter high-rated properties | `idx_reviews_rating` |

### Payments Table
| Column | Usage | Index Created |
|--------|-------|---------------|
| `booking_id` | JOIN with bookings | `idx_payments_booking_id` |
| `payment_method` | Payment analytics | `idx_payments_method` |

### Messages Table
| Column | Usage | Index Created |
|--------|-------|---------------|
| `sender_id` | Find sent messages | `idx_messages_sender_id` |
| `recipient_id` | Find received messages | `idx_messages_recipient_id` |

---

## Key Insights

### Most Important Indexes for Airbnb Clone:

1. **`idx_bookings_property_dates`** - Critical for availability checks and preventing double bookings
2. **`idx_users_email`** - Essential for fast login
3. **`idx_properties_location_price`** - Optimizes the most common search query
4. **Foreign key indexes** - Speed up all JOINs

---

## How to Measure Performance

### Using EXPLAIN:
```sql
EXPLAIN SELECT * FROM Properties WHERE location = 'California';
```

**Key columns to check:**
- `type`: Should be `ref`, `range`, or `eq_ref` (not `ALL`)
- `possible_keys`: Shows available indexes
- `key`: Shows which index was used
- `rows`: Fewer is better

### Using ANALYZE (for actual execution):
```sql
EXPLAIN ANALYZE 
SELECT * FROM Properties WHERE location = 'California';
```

Shows actual execution time and rows processed.

---

## Files
- `database_index.sql` - All CREATE INDEX commands
- `index_performance.md` - This performance analysis
