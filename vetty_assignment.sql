 --Firstly I created transactions table and inserted the data
CREATE TABLE transactions (
    buyer_id INT,
    purchase_time DATETIME,
    refund_item DATETIME NULL,
    store_id VARCHAR(5),
    item_id VARCHAR(5),
    gross_transaction_value INT
);

--inserting the value
INSERT INTO transactions 
(buyer_id, purchase_time, refund_item, store_id, item_id, gross_transaction_value)
VALUES
(3, '2019-09-19 21:19:06.544', NULL, 'a', 'a1', 58),
(12, '2019-12-10 20:10:14.324', '2019-12-15 23:19:06.544', 'b', 'b2', 475),
(3, '2020-09-01 23:59:46.561', '2020-09-02 21:22:06.331', 'f', 'f9', 33),
(2, '2020-04-30 21:19:06.544', NULL, 'd', 'd3', 250),
(1, '2020-10-22 22:20:06.531', NULL, 'f', 'f2', 91),
(8, '2020-04-16 21:10:22.214', NULL, 'e', 'e7', 24),
(5, '2019-09-23 12:09:35.542', '2019-09-27 02:55:02.114', 'g', 'g6', 61);


--1) count of purchases per month, excluding refunded purchases
SELECT 
    FORMAT(purchase_time, 'yyyy-MM') AS month,
    COUNT(*) AS purchase_count
FROM transactions
WHERE refund_item IS NULL
GROUP BY FORMAT(purchase_time, 'yyyy-MM');

--2) Count how many stores had at least 5 orders in Oct 2020
SELECT store_id, COUNT(*) AS order_count
FROM transactions
WHERE purchase_time >= '2020-10-01'
  AND purchase_time < '2020-11-01'
GROUP BY store_id
HAVING COUNT(*) >= 5;

--3) For each store, what is the shortest interval (in min) from purchase to refund time?
SELECT 
    store_id,
    MIN(DATEDIFF(MINUTE, purchase_time, refund_item)) AS min_refund_interval
FROM transactions
WHERE refund_item IS NOT NULL
GROUP BY store_id;

--4) What is the gross_transaction_value of every store’s first order?-
SELECT t.store_id, t.gross_transaction_value
FROM transactions t
JOIN (
    SELECT store_id, MIN(purchase_time) AS first_order
    FROM transactions
    GROUP BY store_id
) x
ON t.store_id = x.store_id AND t.purchase_time = x.first_order;


--5) What is the most popular item name that buyers order on their first purchase?
WITH first_purchase AS (
    SELECT 
        buyer_id,
        MIN(purchase_time) AS first_purchase_time
    FROM transactions
    GROUP BY buyer_id
)
SELECT TOP 1
    i.item_name,
    COUNT(*) AS order_count
FROM first_purchase fp
JOIN transactions t
    ON t.buyer_id = fp.buyer_id
   AND t.purchase_time = fp.first_purchase_time
JOIN items i
    ON t.item_id = i.item_id
GROUP BY i.item_name
ORDER BY order_count DESC;

--6 )create refund_flag (refund processed if within 72 hours
SELECT 
    *,
    CASE 
        WHEN refund_item IS NULL THEN 'no refund'
        WHEN DATEDIFF(HOUR, purchase_time, refund_item) <= 72 
             THEN 'processed'
        ELSE 'not processed'
    END AS refund_flag
FROM transactions;

--7)Rank purchases per buyer & return second purchase only
WITH ranked AS (
    SELECT 
        t.*,
        ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS rn
    FROM transactions t
)
SELECT *
FROM ranked
WHERE rn = 2;

--8)Find second transaction time per buyer (without min/max)
WITH ordered AS (
    SELECT
        buyer_id,
        purchase_time,
        ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS rn
    FROM transactions
)
SELECT buyer_id, purchase_time
FROM ordered
WHERE rn = 2;






