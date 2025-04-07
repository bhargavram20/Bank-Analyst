Create database Credit_Debit_DB;

Use Credit_Debit_DB;

CREATE TABLE Transactions 
(
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255),
    AccountNumber BIGINT,
    TransactionDate DATE,
    TransactionType ENUM('Credit', 'Debit'),
    Amount DECIMAL(15,2),
    Balance DECIMAL(15,2),
    Description TEXT,
    Branch VARCHAR(255),
    TransactionMethod VARCHAR(255),
    BankName VARCHAR(255)
);

SELECT * FROM credit_debit_db.`debit and credit banking_data`;


-- Null Values
select * from `debit and credit banking_data` where `BankName` is null;


-- 1: Total Credit Amount
SELECT SUM(Amount) AS TotalCreditAmount 
FROM `debit and credit banking_data`
WHERE TransactionType = 'Credit';


-- Query 2: Total Debit Amount
SELECT SUM(Amount) AS TotalDebitAmount 
FROM `debit and credit banking_data`
WHERE TransactionType = 'Debit';


-- Query 3: Credit to Debit Ratio
SELECT 
    SUM(CASE WHEN  `TransactionType` = 'Credit' THEN amount ELSE 0 END) /
    NULLIF(SUM(CASE WHEN  `TransactionType` = 'Debit' THEN amount ELSE 0 END), 0) AS credit_debit_ratio
FROM  `debit and credit banking_data`;


-- Query 4: Net Transaction Amount
SELECT 
    (SUM(CASE WHEN TransactionType = 'Credit' THEN Amount ELSE 0 END) -
    SUM(CASE WHEN TransactionType = 'Debit' THEN Amount ELSE 0 END)) 
    AS Balance
FROM `debit and credit banking_data`;


-- Query 5: Account Activity Ratio
SELECT AccountNumber, (COUNT(*) / MAX(Balance)) AS AccountActivityRatio
FROM `debit and credit banking_data`
GROUP BY AccountNumber;


-- Query 6: Transactions per Day
SELECT
DATE(`TransactionDate`) AS transaction_day,
SUM(amount) AS total_amount
FROM `debit and credit banking_data`
GROUP BY DATE(`TransactionDate`)
ORDER BY  Transaction_day DESC;

-- Transactions per Week
SELECT
YEAR(`TransactionDate`) AS transaction_year,
WEEK(`TransactionDate`) AS transaction_Week,
SUM(amount) AS total_amount
FROM `debit and credit banking_data`
GROUP BY YEAR(`TransactionDate`), WEEK(`TransactionDate`)
ORDER BY transaction_year, Transaction_week DESC;

-- Transactions per Year
SELECT
	YEAR(`TransactionDate`) AS transaction_Year,
    MONTH(`TransactionDate`) AS transaction_month,
    SUM(amount) AS total_amount
    FROM `debit and credit banking_data`
GROUP BY    
YEAR(`TransactionDate`),MONTH(`TransactionDate`)
ORDER BY
    transaction_Year, transaction_month DESC;


-- Query 7: Total Transaction Amount by Branch
SELECT Branch, SUM(ROUND(Amount)) AS TotalTransactionAmount
 FROM `debit and credit banking_data`
 GROUP BY Branch;


-- Query 8: Transaction Volume by Bank
SELECT BankName, SUM(ROUND(Amount)) AS TotalTransactionAmount 
FROM `debit and credit banking_data`
GROUP BY BankName;


-- Query 9: Transaction Method Distribution
SELECT
`TransactionMethod` , count(Amount) AS Count_Of_transaction
FROM `debit and credit banking_data`
GROUP BY `TransactionMethod`;

-- Query 10: Branch Transaction Growth
SELECT Branch, MONTH(TransactionDate) AS Month, 
       SUM(Amount) AS MonthlyTotal,
       (SUM(Amount) - LAG(SUM(Amount)) OVER (PARTITION BY Branch ORDER BY MONTH(TransactionDate))) 
       / NULLIF(LAG(SUM(Amount)) OVER (PARTITION BY Branch ORDER BY MONTH(TransactionDate)), 0) * 100 AS GrowthPercentage
FROM `debit and credit banking_data`
GROUP BY Branch, Month;

-- Query 11: High-Risk Transaction Flag
SELECT 
    COUNT(Amount) AS high_risk_transaction_count
FROM 
    `debit and credit banking_data`
WHERE 
    (Amount > 2000)  
    AND `TransactionDate` >= '2024-01-01'  
    AND `TransactionDate`<= '2024-12-01';

-- Query 12: Suspicious Transaction Frequency
SELECT
    DATE(`TransactionDate`) AS TransactionDay,
    SUM(
        CASE
            WHEN Amount > 2000 THEN 1  
            WHEN `TransactionType` = 'Withdrawal' AND Amount > (Balance * 0.5) THEN 1 
            ELSE 0
        END
    ) AS Suspicious_Count_Per_Day
FROM
    `debit and credit banking_data`
GROUP BY
    `TransactionDate`;


















