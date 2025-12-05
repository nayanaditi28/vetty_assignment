# 📘 SQL Test Submission

This repository contains my solutions to the SQL assessment.  
All queries are written in **SQL Server** syntax. Screenshots are also attached.

---

## 🔎 Brief explanation for each question

### Q1 – Count of purchases per month (excluding refunded purchases)  
**What I did:** Filtered out transactions that have a refund (`refund_item IS NOT NULL`) and grouped remaining rows by year-month (built using YEAR() and MONTH()).  
**Why:** Gives monthly purchase counts but excludes purchases that were later refunded.

### Q2 – Stores with ≥5 orders in October 2020  
**What I did:** Filtered transactions for date range `2020-10-01` to `2020-10-31`, grouped by `store_id`, and kept groups having `COUNT(*) >= 5`.  
**Why:** Identifies high-activity stores during Oct 2020.

### Q3 – Shortest interval (minutes) from purchase to refund per store  
**What I did:** Considered only rows where `refund_item IS NOT NULL`, computed `DATEDIFF(MINUTE, purchase_time, refund_item)`, and picked the `MIN()` per `store_id`.  
**Why:** Finds the quickest time taken for a refund at each store.

### Q4 – Gross transaction value of every store’s first order  
**What I did:** Found the earliest `purchase_time` per `store_id` (using `MIN(purchase_time)`), then joined back to transactions to get the `gross_transaction_value` for that first order.  
**Why:** Shows the value of the initial sale for each store.

### Q5 – Most popular item name on the buyer’s first purchase  
**What I did:** For each `buyer_id` selected their earliest `purchase_time`, joined to `transactions` and `items`, counted item names and returned the top result (most frequent).  
**Why:** Identifies the item most commonly bought on customers’ first purchase.

### Q6 – Refund processability flag (refund within 72 hours)  
**What I did:** Used `DATEDIFF(HOUR, purchase_time, refund_item)` and flagged rows as `processed` if ≤ 72 hours, `not processed` otherwise, and `no refund` if `refund_item` is NULL.  
**Why:** Implements the rule that refunds are allowed only within a 72-hour window.

### Q7 – Rank purchases per buyer and filter second purchase only  
**What I did:** Used `ROW_NUMBER()` partitioned by `buyer_id` ordered by `purchase_time` to assign ranks, then selected rows where `rn = 2`.  
**Why:** Extracts each buyer’s second purchase (ignoring refunds as requested).

### Q8 – Find second transaction time per buyer (without MIN/MAX)  
**What I did:** Similar to Q7 — used window functions to order transactions per buyer and selected the `purchase_time` where rank = 2.  
**Why:** Returns the timestamp of the second purchase per buyer without using aggregate min/max.

---

## 📸 Screenshots
All query outputs are saved as:
- `Q1_output.png` … through `/Q8_output.png`  
Each screenshot shows the executed query and the result grid.

---

