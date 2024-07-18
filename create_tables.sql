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
