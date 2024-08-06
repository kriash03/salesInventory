--INSERTING DATAS

-- Insert sample data into Customers table
INSERT INTO Customers (CustomerName, Email, Phone) VALUES
('John Doe', 'john@example.com', '123-456-7890'),
('Jane Smith', 'jane@example.com', '234-567-8901'),
('Michael Johnson', 'michael@example.com', '345-678-9012');

-- Insert sample data into Products table
INSERT INTO Products (ProductName, Category, Price, StockLevel) VALUES
('Product A', 'Category 1', 19.99, 100),
('Product B', 'Category 2', 29.99, 200),
('Product C', 'Category 1', 39.99, 150),
('Product D', 'Category 3', 199.89, 9);

-- Insert sample data into Suppliers table
INSERT INTO Suppliers (SupplierName, ContactName, ContactEmail, ContactPhone) VALUES
('Supplier X', 'Alice', 'alice@supplierx.com', '123-456-7890'),
('Supplier Y', 'Bob', 'bob@suppliery.com', '234-567-8901');

-- Insert sample data into Sales table
INSERT INTO Sales (SaleDate, CustomerID, TotalAmount) VALUES
('2023-04-01', 1, 59.97),
('2023-04-02', 2, 29.99),
('2023-04-03', 1, 19.99),
('2023-04-04', 3, 39.99),
('2023-04-05', 2, 109.99),
('2023-04-06', 2, 229.99),
('2023-04-07', 2, 39.99),
('2023-04-09', 2, 869.98);


-- Insert sample data into SaleDetails table
INSERT INTO SaleDetails (SaleID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 19.99),
(1, 2, 1, 29.99),
(2, 2, 1, 29.99),
(3, 1, 1, 19.99);

-- Insert sample data into Inventory table
INSERT INTO Inventory (ProductID, SupplierID, QuantityReceived, ReceiveDate) VALUES
(1, 1, 50, '2023-03-01'),
(2, 2, 100, '2023-03-05'),
(3, 1, 75, '2023-03-10');