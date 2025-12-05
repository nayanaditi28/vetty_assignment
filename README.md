# 📘 SQL Test Submission

This repository contains my solutions to the SQL assessment provided.  
All queries are written in **SQL Server** syntax, and screenshots of the executed results are included in the `results/` folder.


---

## 📝 Assumptions
- Timestamps were treated as standard SQL Server `DATETIME` values.  
- Refund eligibility is defined as **refund happening within 72 hours** of purchase.  
- If multiple items tie for popularity, query returns the first based on ordering.  
- No external datasets were used; only the provided snapshot.  

---

## 🧩 Approach Summary

### **Q1 – Count of purchases per month (excluding refunds)**
Grouped transactions by year-month using SQL Server string functions and excluded refunded rows.

### **Q2 – Stores with ≥5 orders in October 2020**
Filtered transactions using a date range (`2020-10-01` to `2020-11-01`) and applied `HAVING COUNT(*) >= 5`.

### **Q3 – Shortest interval (minutes) from purchase to refund**
Used `DATEDIFF(MINUTE, purchase_time, refund_item)` and selected the minimum interval per store.

### **Q4 – Gross transaction value of every store’s first order**
Found each store’s earliest transaction and joined back to retrieve the corresponding value.

### **Q5 – Most popular item name in the buyer’s first purchase**
Determined each buyer’s first purchase, joined with `items` table, counted frequency, and selected the top result.

### **Q6 – Refund processability flag**
Created a flag:
- `processed` → refund within 72 hours  
- `not processed` → refund after 72 hours  
- `no refund` → no refund date available  

### **Q7 – Rank purchases per buyer (second purchase only)**
Used `ROW_NUMBER()` partitioned by buyer to identify and filter the second purchase.

### **Q8 – Find second transaction time per buyer (without MIN/MAX)**
Used window function ranking instead of aggregate functions.

---

## 📸 Screenshot Naming Convention
All outputs are included in the `results/` folder:

- `Q1_output.png`  
- `Q2_output.png`  
- `Q3_output.png`  
- `Q4_output.png`  
- `Q5_output.png`  
- `Q6_output.png`  
- `Q7_output.png`  
- `Q8_output.png`  

Each screenshot shows both the executed SQL query and the resulting output.

---

## ▶️ How to Run
1. Load the provided dataset into SQL Server.  
2. Open `vetty_assignment.sql` in SQL Server Management Studio (SSMS).  
3. Execute queries in order and compare with screenshots for validation.

---

## ✅ Conclusion
This submission demonstrates:
- Strong SQL Server querying skills  
- Ability to work with dates, window functions, and filters  
- Clean documentation and presentation of results  

Thank you for reviewing my submission!
