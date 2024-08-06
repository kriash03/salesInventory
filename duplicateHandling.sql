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