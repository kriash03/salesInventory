-- Monthly Sales Trends
SELECT
    TO_CHAR(SaleDate, 'YYYY-MM') AS Month,
    SUM(TotalAmount) AS TotalSales
FROM
    Sales
GROUP BY
    TO_CHAR(SaleDate, 'YYYY-MM')
ORDER BY
    Month;
