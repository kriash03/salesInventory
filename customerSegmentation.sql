-- Customer Segmentation based on RFM values
CREATE VIEW CustomerSegments AS
SELECT
    CustomerID,
    CASE
        WHEN Frequency >= 10 OR Monetary >= 1000 THEN 'VIP'
        WHEN Frequency >= 5 THEN 'Regular'
        ELSE 'Occasional'
    END AS Segment
FROM (
    SELECT
        CustomerID,
        COUNT(*) AS Frequency,
        SUM(TotalAmount) AS Monetary
    FROM
        Sales
    GROUP BY
        CustomerID
) AS RFM;
