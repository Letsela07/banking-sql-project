-- Banking Database Project
-- Author: Lebohang Letsela

-- Create Tables

CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(50),
    city VARCHAR(50),
    province VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50)
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10,2),
    branch_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Insert Sample Data

INSERT INTO branches VALUES
(1, 'Cape Town Central', 'Cape Town', 'Western Cape'),
(2, 'Sandton City', 'Johannesburg', 'Gauteng'),
(3, 'Durban Point', 'Durban', 'KwaZulu-Natal');

INSERT INTO customers VALUES
(1, 'Lebohang', 'Letsela', 'lebo@email.com', '0821234567', 'Cape Town'),
(2, 'Thabo', 'Nkosi', 'thabo@email.com', '0839876543', 'Johannesburg'),
(3, 'Ayesha', 'Davids', 'ayesha@email.com', '0764567890', 'Cape Town'),
(4, 'Sipho', 'Dlamini', 'sipho@email.com', '0712345678', 'Durban'),
(5, 'Zanele', 'Mokoena', 'zanele@email.com', '0845678901', 'Johannesburg');

INSERT INTO accounts VALUES
(1, 1, 'Savings', 15000.00, 1),
(2, 2, 'Cheque', 32000.00, 2),
(3, 3, 'Savings', 8500.00, 1),
(4, 4, 'Cheque', 21000.00, 3),
(5, 5, 'Savings', 5000.00, 2);

INSERT INTO transactions VALUES
(1, 1, 'Deposit', 5000.00, '2025-01-10'),
(2, 1, 'Withdrawal', 1500.00, '2025-01-15'),
(3, 2, 'Deposit', 10000.00, '2025-01-12'),
(4, 3, 'Withdrawal', 2000.00, '2025-01-18'),
(5, 4, 'Deposit', 7500.00, '2025-01-20'),
(6, 5, 'Withdrawal', 500.00, '2025-01-22'),
(7, 2, 'Deposit', 3000.00, '2025-01-25'),
(8, 1, 'Deposit', 2000.00, '2025-01-28');

-- Queries

-- 1. List all customers
SELECT * FROM customers;

-- 2. List all accounts with customer names
SELECT c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;

-- 3. Total balance across all accounts
SELECT SUM(balance) AS total_balance FROM accounts;

-- 4. All transactions for a specific account
SELECT * FROM transactions
WHERE account_id = 1;

-- 5. Customers with savings accounts
SELECT c.first_name, c.last_name, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_type = 'Savings';

-- 6. Total deposits and withdrawals
SELECT transaction_type, SUM(amount) AS total
FROM transactions
GROUP BY transaction_type;

-- 7. Highest account balance
SELECT c.first_name, c.last_name, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
ORDER BY a.balance DESC
LIMIT 1;

-- 8. All transactions in January 2025
SELECT * FROM transactions
WHERE transaction_date BETWEEN '2025-01-01' AND '2025-01-31';

-- 9. Number of accounts per branch
SELECT b.branch_name, COUNT(a.account_id) AS total_accounts
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name;

-- 10. Customers based in Cape Town
SELECT * FROM customers
WHERE city = 'Cape Town';
