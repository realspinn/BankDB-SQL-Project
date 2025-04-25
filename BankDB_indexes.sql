-- Index on foreign keys for join performance
CREATE INDEX idx_accounts_customer_id ON Accounts(customer_id);
CREATE INDEX idx_transactions_account_id ON Transactions(account_id);
CREATE INDEX idx_loans_customer_id ON Loans(customer_id);

-- Index on frequently queried/filterable fields
CREATE INDEX idx_accounts_status ON Accounts(status);
CREATE INDEX idx_accounts_account_type ON Accounts(account_type);
CREATE INDEX idx_loans_status ON Loans(status);
CREATE INDEX idx_loans_loan_type ON Loans(loan_type);
CREATE INDEX idx_transactions_type ON Transactions(transaction_type);
CREATE INDEX idx_employees_position ON Employees(position);
