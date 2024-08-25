--CREATING TABLES

-- Create Products Table
CREATE TABLE IF NOT EXISTS Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    StockLevel INT NOT NULL
);

-- Create Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15)
);

-- Create Suppliers Table
CREATE TABLE IF NOT EXISTS Suppliers (
    SupplierID SERIAL PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(15)
);

-- Create Sales Table
CREATE TABLE IF NOT EXISTS Sales (
    SaleID SERIAL PRIMARY KEY,
    SaleDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create SaleDetails Table
CREATE TABLE IF NOT EXISTS SaleDetails (
    SaleDetailID SERIAL PRIMARY KEY,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Inventory Table
CREATE TABLE IF NOT EXISTS Inventory (
    InventoryID SERIAL PRIMARY KEY,
    ProductID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT NOT NULL,
    QuantityReceived INT NOT NULL,
    ReceiveDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);


