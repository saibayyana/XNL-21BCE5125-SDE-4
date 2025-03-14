-- Top-performing vendors based on transaction volume and revenue
SELECT v.VendorID, v.Name, COUNT(t.TransactionID) AS TotalTransactions, SUM(t.Amount) AS TotalRevenue
FROM Vendors v
JOIN FinancialTransactions t ON v.VendorID = t.VendorID
WHERE t.Status = 'Completed'
GROUP BY v.VendorID, v.Name
ORDER BY TotalRevenue DESC
LIMIT 10;

-- Real-time sales trend (hourly revenue for the last 24 hours)
SELECT DATE_FORMAT(Timestamp, '%Y-%m-%d %H:00:00') AS HourlyTime, SUM(Amount) AS TotalRevenue
FROM FinancialTransactions
WHERE Timestamp >= NOW() - INTERVAL 1 DAY AND Status = 'Completed'
GROUP BY HourlyTime
ORDER BY HourlyTime DESC;

-- Anomaly detection: Identify transactions that are significantly larger than the average transaction amount
SELECT TransactionID, UserID, VendorID, Amount, Timestamp
FROM FinancialTransactions
WHERE Amount > (SELECT AVG(Amount) * 3 FROM FinancialTransactions)
AND Status = 'Completed'
ORDER BY Amount DESC;
