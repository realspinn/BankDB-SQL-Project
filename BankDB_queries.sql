-- Which type of customers hold the highest balances?
SELECT 
	 c.address,
	 c.date_of_birth,
	 COALESCE(SUM(a.balance), 0) AS total_balance,
	 EXTRACT(YEAR FROM age(current_date, c.date_of_birth)) AS age,
CASE
    WHEN EXTRACT(YEAR FROM age(current_date, c.date_of_birth)) < 20 THEN 'Teenagers'
    WHEN EXTRACT(YEAR FROM age(current_date, c.date_of_birth)) BETWEEN 20 AND 29 THEN 'Young Adults'
    WHEN EXTRACT(YEAR FROM age(current_date, c.date_of_birth)) BETWEEN 30 AND 44 THEN 'Adults'
    WHEN EXTRACT(YEAR FROM age(current_date, c.date_of_birth)) BETWEEN 45 AND 59 THEN 'Middle Age'
    ELSE 'Seniors'
END AS age_group
FROM customers c
LEFT JOIN Accounts a
	USING(customer_id)
GROUP BY age, c.address, c.date_of_birth;

-- Are older customers more reliable with loan repayments?
SELECT 
 	age(current_date, c.date_of_birth) AS age,
	 l.status,
 CASE 
        WHEN EXTRACT(YEAR FROM age(current_date, c.date_of_birth)) < 30 THEN 'Under 30'
        WHEN EXTRACT(YEAR FROM age(current_date, c.date_of_birth)) BETWEEN 30 AND 49 THEN '30-49'
        ELSE '50+'
END AS customers_reliable_with_loan_payments
FROM customers c
LEFT JOIN loans l
	USING(customer_id)
WHERE l.status IN ('Repaid', 'Defaulted');

-- Do people with multiple accounts behave differently (e.g. save more, take loans)?
SELECT
    a.customer_id,
    COUNT(a.account_id) AS num_accounts,
    SUM(a.balance) AS total_balance,
    ROUND(AVG(a.balance), 2) AS avg_balance_per_account,
    COALESCE(SUM(l.loan_amount), 0) AS total_loans,
    CASE 
        WHEN COALESCE(SUM(l.loan_amount), 0) > 0 THEN 'Yes'
        ELSE 'No'
    END AS has_loan
FROM accounts a
LEFT JOIN loans l ON a.customer_id = l.customer_id
WHERE a.account_type IN ('Current', 'Savings', 'Fixed Deposit')
GROUP BY a.customer_id
HAVING COUNT(a.account_id) >= 2
ORDER BY num_accounts DESC;


-- Which account type — ‘Savings’, ‘Current’, or ‘Fixed Deposit’ — holds the most money overall?
SELECT 
	account_type,
	SUM(balance) AS overall_balance
FROM accounts
GROUP BY account_type
ORDER BY overall_balance DESC;

--  How many accounts are Active vs Frozen vs Closed — and why?
SELECT 	
	status,
	COUNT(*)
FROM accounts
GROUP BY status;

-- What’s the average time between when an account is created and when its first transaction happens?
SELECT 
    AVG(EXTRACT(EPOCH FROM (created_at - first_transaction_date)) / 86400) AS avg_time_days
FROM (
    SELECT 
        a.account_id,
        a.created_at,
        MIN(t.transaction_date) AS first_transaction_date
    FROM accounts a
    LEFT JOIN transactions t
        ON a.account_id = t.account_id
    GROUP BY a.account_id, a.created_at
) AS first_transactions;

-- What’s the most common transaction type (e.g., Deposit, Withdrawal)?
SELECT 
	transaction_type,
	COUNT(*) common_transactions
FROM transactions
GROUP BY transaction_type
ORDER BY  common_transactions DESC;

-- Are some accounts inactive (no transactions for a long time)?
SELECT 
    a.account_id,
    a.status,
    MAX(t.transaction_date) AS last_transaction_date,
    CASE 
        WHEN MAX(t.transaction_date) IS NULL THEN 'No Transactions'
        WHEN MAX(t.transaction_date) < CURRENT_DATE - INTERVAL '180 days' THEN 'Inactive'
        ELSE 'Active'
    END AS activity_status
FROM accounts a
LEFT JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY a.account_id, a.status;

-- Do some accounts show high daily volume (might be fraud)?
SELECT 
	a.account_id,
	t.transaction_date,
	COUNT(t.transaction_id) AS daily_transactions
FROM accounts a
LEFT JOIN transactions t
	USING(account_id)
GROUP BY a.account_id, t.transaction_date
-- HAVING COUNT(t.transaction_id) > 10  -- Suspicious if more than 10 transactions per day
ORDER BY a.account_id, t.transaction_date;

/* Which loan type (Personal, Auto, etc.) has the highest default rate?
(Look at Loans.loan_type + Loans.status)*/

SELECT 
    loan_type,
    COUNT(CASE WHEN status = 'defaulted' THEN 1 END) * 1.0 / COUNT(*) AS default_rate
FROM Loans
GROUP BY loan_type
ORDER BY default_rate DESC;

/*  Does a higher interest rate lead to more defaults or better repayments?
(Compare interest_rate vs status) */

SELECT 
    CASE 
        WHEN interest_rate < 5 THEN 'Low Interest Rate'
        WHEN interest_rate BETWEEN 5 AND 10 THEN 'Medium Interest Rate'
        ELSE 'High Interest Rate'
    END AS interest_rate_group,
    COUNT(CASE WHEN status = 'defaulted' THEN 1 END) * 1.0 / COUNT(*) AS default_rate
FROM Loans
GROUP BY interest_rate_group
ORDER BY interest_rate_group;

/* Are people with loans also holding big savings?
(Join Loans + Accounts by customer_id and compare) */
SELECT 
	l.customer_id,
	c.full_name,
	l.loan_type,
	l.loan_amount,
	a.account_type,
	a.balance,
CASE
	WHEN a.account_type = 'Savings' AND a.balance > 10000 THEN 'Big savings'
	WHEN a.account_type = 'Savings' AND a.balance <= 10000 THEN 'Small savings'
	ELSE 'No Savings'
END AS Customers_Savings
FROM loans l
LEFT JOIN customers c
	USING(customer_id)
LEFT JOIN accounts a
	USING(customer_id)
ORDER BY Customers_Savings;
