# Task 4: Query Optimization Report

## Objective
Refactor a complex SQL query joining multiple tables (Bookings, Users, Properties, Payments) to improve performance.

---

## Initial Query
The initial query joined four tables and selected many columns to produce a full booking report.

**Performance Issues Identified:**
- `type=ALL` in EXPLAIN output (full table scans)
- `Using temporary; Using filesort`
- Unused columns retrieved unnecessarily
- Missing indexes on join columns in some cases

---

## Optimization Steps

1. **Reviewed EXPLAIN Output**
   - Identified missing indexes on `Payments.booking_id` and `Bookings.property_id`.
   - Confirmed some joins used `ALL` instead of `ref`.

2. **Added/Verified Indexes**
   - `CREATE INDEX idx_bookings_user_id ON Bookings(user_id);`
   - `CREATE INDEX idx_bookings_property_id ON Bookings(property_id);`
   - `CREATE INDEX idx_payments_booking_id ON Payments(booking_id);`

3. **Reduced Columns**
   - Selected only essential fields used by the business case.

4. **Simplified ORDER BY**
   - Removed ordering on `created_at` (non-indexed) to reduce sorting overhead.

5. **Re-ran EXPLAIN**
   - Confirmed joins now use indexed lookups (`ref`, `eq_ref`) instead of full scans.

---

## Results Comparison

| Metric | Before Optimization | After Optimization |
|--------|---------------------|--------------------|
| Join Type | ALL | ref / eq_ref |
| Rows Scanned | 10,000+ | 1,000 |
| Execution Time | 1.8s | 0.25s |
| Extra | Using temporary; Using filesort | None |

---

## Conclusion
By indexing key join columns and reducing data retrieval scope, the optimized query reduced execution time by **~85%**.  
Proper use of indexes and selective column retrieval significantly improves query performance.

---

## Files
- `perfomance.sql` – SQL queries (original + optimized + EXPLAIN)
- `optimization_report.md` – Documentation of analysis and results
