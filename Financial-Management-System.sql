# Financial-Management-System

# 1. Criação das Tabelas

CREATE TABLE Accounts_Payable (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('pending', 'paid') NOT NULL DEFAULT 'pending'
);

CREATE TABLE Accounts_Receivable (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('pending', 'received') NOT NULL DEFAULT 'pending'
);

CREATE TABLE Transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_type ENUM('payable', 'receivable') NOT NULL,
    account_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES Accounts_Payable(id) ON DELETE CASCADE,
    FOREIGN KEY (account_id) REFERENCES Accounts_Receivable(id) ON DELETE CASCADE
);


# 2. Inserção de Dados

-- Inserir uma conta a pagar
INSERT INTO Accounts_Payable (vendor_name, amount, due_date)
VALUES ('Fornecedor A', 500.00, '2024-08-01');

-- Inserir uma conta a receber
INSERT INTO Accounts_Receivable (customer_name, amount, due_date)
VALUES ('Cliente B', 1500.00, '2024-08-15');

-- Registrar uma transação
INSERT INTO Transactions (transaction_type, account_id, transaction_date)
VALUES ('payable', 1, '2024-07-18');

# 3. Consultar Transações

-- Consultar todas as transações
SELECT * FROM Transactions;

-- Consultar contas a pagar pendentes
SELECT * FROM Accounts_Payable WHERE status = 'pending';

-- Consultar contas a receber pendentes
SELECT * FROM Accounts_Receivable WHERE status = 'pending';

#   4. Gerar Relatórios

-- Relatório mensal de transações
SELECT transaction_type, COUNT(*) AS transaction_count, SUM(amount) AS total_amount
FROM Transactions
JOIN Accounts_Payable ON Transactions.account_id = Accounts_Payable.id AND Transactions.transaction_type = 'payable'
JOIN Accounts_Receivable ON Transactions.account_id = Accounts_Receivable.id AND Transactions.transaction_type = 'receivable'
WHERE MONTH(transaction_date) = 7 AND YEAR(transaction_date) = 2024
GROUP BY transaction_type;

