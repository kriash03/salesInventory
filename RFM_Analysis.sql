-- RFM Analysis: Calculate Recency, Frequency, and Monetary value for each customer
SELECT
    CustomerID,
    MAX(SaleDate) AS LastPurchase,
    COUNT(*) AS Frequency,
    SUM(TotalAmount) AS Monetary
FROM
    Sales
GROUP BY
    CustomerID;
