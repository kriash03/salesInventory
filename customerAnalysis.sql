-- Customer Purchase Behavior Analysis
SELECT
    c.CustomerName,
    COUNT(s.SaleID) AS TotalPurchases,
    AVG(s.TotalAmount) AS AvgTransactionValue
FROM
    Customers c
JOIN
    Sales s ON c.CustomerID = s.CustomerID
GROUP BY
    c.CustomerName;
