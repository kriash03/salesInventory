--CREATING TABLES

-- Create Products Table
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    StockLevel INT NOT NULL
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15)
);

-- Create Suppliers Table
CREATE TABLE Suppliers (
    SupplierID SERIAL PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(15)
);

-- Create Sales Table
CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    SaleDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create SaleDetails Table
CREATE TABLE SaleDetails (
    SaleDetailID SERIAL PRIMARY KEY,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Inventory Table
CREATE TABLE Inventory (
    InventoryID SERIAL PRIMARY KEY,
    ProductID INT NOT NULL,
    SupplierID INT NOT NULL,
    QuantityReceived INT NOT NULL,
    ReceiveDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

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
('Product C', 'Category 1', 39.99, 150);

-- Insert sample data into Suppliers table
INSERT INTO Suppliers (SupplierName, ContactName, ContactEmail, ContactPhone) VALUES
('Supplier X', 'Alice', 'alice@supplierx.com', '123-456-7890'),
('Supplier Y', 'Bob', 'bob@suppliery.com', '234-567-8901');

-- Insert sample data into Sales table
INSERT INTO Sales (SaleDate, CustomerID, TotalAmount) VALUES
('2023-04-01', 1, 59.97),
('2023-04-02', 2, 29.99),
('2023-04-03', 1, 19.99);

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


-- Find and delete duplicate sales, keeping only the first occurrence
WITH DuplicateSales AS (
    SELECT SaleID,
           ROW_NUMBER() OVER (PARTITION BY SaleDate, CustomerID, TotalAmount ORDER BY SaleID) AS row_num
    FROM Sales
)
DELETE FROM Sales
WHERE SaleID IN (
    SELECT SaleID
    FROM DuplicateSales
    WHERE row_num > 1
);

-- Delete duplicate customers, keeping only the first occurrence
WITH DuplicateCustomers AS (
    SELECT CustomerID,
           ROW_NUMBER() OVER (PARTITION BY CustomerName, Email ORDER BY CustomerID) AS row_num
    FROM Customers
)
DELETE FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM DuplicateCustomers
    WHERE row_num > 1
);

-- Find and delete duplicate products, keeping only the first occurrence
WITH DuplicateProducts AS (
    SELECT ProductID,
           ROW_NUMBER() OVER (PARTITION BY ProductName, Category ORDER BY ProductID) AS row_num
    FROM Products
)
DELETE FROM Products
WHERE ProductID IN (
    SELECT ProductID
    FROM DuplicateProducts
    WHERE row_num > 1
);


-- Find and delete duplicate suppliers, keeping only the first occurrence
WITH DuplicateSuppliers AS (
    SELECT SupplierID,
           ROW_NUMBER() OVER (PARTITION BY SupplierName, ContactEmail ORDER BY SupplierID) AS row_num
    FROM Suppliers
)
DELETE FROM Suppliers
WHERE SupplierID IN (
    SELECT SupplierID
    FROM DuplicateSuppliers
    WHERE row_num > 1
);

-- Find and delete duplicate sale details, keeping only the first occurrence
WITH DuplicateSaleDetails AS (
    SELECT SaleDetailID,
           ROW_NUMBER() OVER (PARTITION BY SaleID, ProductID, Quantity, Price ORDER BY SaleDetailID) AS row_num
    FROM SaleDetails
)
DELETE FROM SaleDetails
WHERE SaleDetailID IN (
    SELECT SaleDetailID
    FROM DuplicateSaleDetails
    WHERE row_num > 1
);

-- Find and delete duplicate inventory records, keeping only the first occurrence
WITH DuplicateInventory AS (
    SELECT InventoryID,
           ROW_NUMBER() OVER (PARTITION BY ProductID, SupplierID, QuantityReceived, ReceiveDate ORDER BY InventoryID) AS row_num
    FROM Inventory
)
DELETE FROM Inventory
WHERE InventoryID IN (
    SELECT InventoryID
    FROM DuplicateInventory
    WHERE row_num > 1
);



