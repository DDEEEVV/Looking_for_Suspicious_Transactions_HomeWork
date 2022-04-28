-- Data Analysis
-- Part 1:
-- The CFO of your firm has requested a report to help analyze potential fraudulent transactions. 
-- Using your newly created database, generate queries that will discover the information needed 
-- to answer the following questions, then use your repository's ReadME file to create a markdown report you can share with the CFO:

--101 Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders.

	-- a) How can you isolate (or group) the transactions of each cardholder?
SELECT full_name, COUNT(transaction_id) AS number_of_transaction_per_cardholder
	FROM transaction t
INNER JOIN credit_card c
	ON c.card_number = t.card_number
INNER JOIN card_holder h
	ON h.card_holder_id = c.card_holder_id
GROUP BY full_name
	ORDER BY number_of_transaction_per_cardholder DESC
;
	-- b) Count the transactions that are less than $2.00 per cardholder.
SELECT h.full_name, COUNT(*) AS transactions_smaller_than_$2
	FROM transaction t 
INNER JOIN credit_card c
	ON c.card_number = t.card_number
INNER JOIN card_holder h 
	ON c.card_holder_id = h.card_holder_id
WHERE amount < 2
	GROUP BY h.card_holder_id, h.full_name
	ORDER BY transactions_smaller_than_$2 DESC
;
	-- c) Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.


-- 102 Take your investigation a step futher by considering the time period in which potentially fraudulent transactions are made.

	-- a) What are the top 100 highest transactions made between 7:00 am and 9:00 am?
SELECT *	
FROM transaction AS early_transactions
	WHERE date_part('hour', transaction_date ) BETWEEN 7 AND 9
ORDER BY amount DESC
LIMIT 100
;
	-- b) Do you see any anomalous transactions that could be fraudulent?
SELECT merchant_name, COUNT(t.transaction_id) AS suspicious_trans
FROM transaction t
INNER JOIN merchant m
	ON t.merchant_id = m.merchant_id
WHERE t.amount <2.00
GROUP BY merchant_name
ORDER BY suspicious_trans DESC
LIMIT 5;

	-- c) Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
SELECT COUNT(*)	
FROM transaction AS number_of_transactions_7to9
	WHERE date_part('hour', transaction_date ) BETWEEN 7 AND 9
;
-- 419 transactions from 7 to 9 am

SELECT COUNT(*)	
FROM transaction AS number_of_transactions_after9
	WHERE date_part('hour', transaction_date ) NOT BETWEEN 7 AND 9
;
-- 3081 transactions after 9 am

	-- d) If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.
	


-- Part 2
		-- 1. Loading data for card holder 2 and 18 from the database
SELECT * 
FROM transaction t
INNER JOIN credit_card c
	ON t.card_number = c.card_number
WHERE card_holder_id = 2 OR card_holder_id = 18
ORDER BY transaction_date;

		-- 2. Plot for card holder 18 from the database
SELECT card_holder_id, date_trunc('day', transaction_date) AS date, COUNT (*)
FROM transaction t
INNER JOIN credit_card c
	ON t.card_number = c.card_number
WHERE card_holder_id = 2 OR card_holder_id = 18
GROUP BY card_holder_id, date_trunc('day', transaction_date)
ORDER BY date_trunc('day', transaction_date)
;


-- loading data of daily transactions from jan to jun 2018 for card holder 25

SELECT transaction_date, SUM(amount)
FROM transaction t
INNER JOIN credit_card c
	ON t.card_number = c.card_number
WHERE card_holder_id = 25 and transaction_date BETWEEN '01/01/2018' AND '06/01/2018'
GROUP BY transaction_date
;

SELECT h.full_name, c.card_number, t.transaction_date, t.amount, mc.category
FROM card_holder h
INNER JOIN credit_card c
	ON h.card_holder_id = c.card_holder_id
INNER JOIN transaction t
	ON t.card_number = c.card_number
INNER JOIN merchant m
	ON m.merchant_id = t.merchant_id
INNER JOIN merchant_category mc
	ON mc.merchant_category_id = m.merchant_category_id
;
-- Full query to find the top 100 highest transactions made between 7:00 am and 9:00 am?

SELECT h.full_name, t.transaction_date, t.amount
FROM card_holder h
INNER JOIN credit_card c
	ON h.card_holder_id = c.card_holder_id
INNER JOIN transaction t
	ON t.card_number = c.card_number
INNER JOIN merchant m
	ON m.merchant_id = t.merchant_id
INNER JOIN merchant_category mc
	ON mc.merchant_category_id = m.merchant_category_id
WHERE transaction_date IN(
SELECT transaction_date
FROM transaction t
WHERE date_part('hour', transaction_date ) BETWEEN 7 AND 9)
ORDER BY amount DESC
LIMIT 100
;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
