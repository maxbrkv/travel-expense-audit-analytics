-- Total Spend
SELECT
    SUM(Amount) AS Total_Spend
FROM Expenses;

-- Spending by Category
SELECT Category, COUNT(*) AS Transactions, ROUND(SUM(Amount), 2) AS Total_Spend,
ROUND(SUM(Amount) * 100.0 / (SELECT SUM(Amount) FROM Expenses), 2) AS Spend_Share
FROM Expenses
GROUP BY Category
ORDER BY Total_Spend DESC;

-- Average Transaction Amount by Category
SELECT Category, COUNT(*) AS Transactions, ROUND(SUM(Amount), 2) AS Total_Spend,
ROUND(AVG(Amount), 2) AS Average_Transaction
FROM Expenses
GROUP BY Category
ORDER BY Average_Transaction DESC;

-- Department Compliance
SELECT Employees.department AS Department, COUNT(*) AS Transactions, ROUND(SUM(Expenses.amount),2) AS Total_Spend, COUNT(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN 1
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN 1
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN 1
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN 1
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN 1
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN 1
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN 1
END) AS Violations,
ROUND(COUNT(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN 1
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN 1
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN 1
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN 1
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN 1
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN 1
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN 1
END) * 100.0 / COUNT(*),2) AS Violation_Rate,
ROUND(SUM(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN Expenses.amount - 30
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN Expenses.amount - 50
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN Expenses.amount - 75
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN Expenses.amount - 300
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN Expenses.amount - 800
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN Expenses.amount - 150
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN Expenses.amount - 75
ELSE 0
END),2) AS Excess_Spend
FROM Expenses
JOIN Employees
ON Expenses.employee_id = Employees.employee_id
GROUP BY Employees.department
ORDER BY Violation_Rate DESC;

-- Receipt Compliance
SELECT COUNT(*) AS Total_Transactions, COUNT( CASE WHEN has_receipt='Yes' THEN 1 END) AS Transactions_With_Receipt, COUNT( CASE WHEN has_receipt='No' THEN 1 END) AS Transactions_Missing_Receipt,
ROUND(COUNT(
CASE
WHEN has_receipt = 'No' THEN 1
END) * 100.0 / COUNT(*),2) AS Missing_Receipt_Rate,
ROUND(SUM(
CASE
WHEN has_receipt = 'No' THEN Expenses.amount
END),2) AS Missing_Receipt_Spend,
SUM(amount) AS Total_Spend,
ROUND(SUM(
CASE
WHEN has_receipt = 'No' THEN Expenses.amount
END) * 100.0 / SUM(amount),2) AS Missing_Receipt_Spend_Rate_to_Total_Spend
FROM Expenses;

-- Personal Card Usage
SELECT COUNT(*) AS Total_Transactions, COUNT( CASE WHEN payment_method='Corporate Card' THEN 1 END) AS Corporate_Card_Transactions,
COUNT( CASE WHEN payment_method='Personal Card' THEN 1 END) AS Personal_Card_Transactions,
ROUND(COUNT(
CASE
WHEN payment_method='Personal Card' THEN 1
END) * 100.0 / COUNT(*),2) AS Personal_Card_Rate,
ROUND(SUM(
CASE
WHEN payment_method='Personal Card' THEN Expenses.amount
END),2) AS Personal_Card_Spend,
SUM(amount) AS Total_Spend,
ROUND(SUM(
CASE
WHEN payment_method='Personal Card' THEN Expenses.amount
END) * 100.0 / SUM(amount),2) AS Personal_Card_Spend_Rate_to_Total_Spend
FROM Expenses;

-- Employee Exceptions
SELECT Employees.name AS Name, Employees.department AS Department, COUNT(*) AS Transactions, COUNT(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN 1
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN 1
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN 1
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN 1
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN 1
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN 1
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN 1
END) AS Violations,
ROUND(COUNT(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN 1
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN 1
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN 1
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN 1
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN 1
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN 1
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN 1
END) * 100.0 / COUNT(*),2) AS Violation_Rate,
ROUND(SUM(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN Expenses.amount - 30
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN Expenses.amount - 50
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN Expenses.amount - 75
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN Expenses.amount - 300
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN Expenses.amount - 800
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN Expenses.amount - 150
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN Expenses.amount - 75
ELSE 0
END),2) AS Excess_Spend
FROM Employees
JOIN Expenses
ON Employees.employee_id = Expenses.employee_id
GROUP BY Employees.name, Employees.department
ORDER BY Excess_Spend DESC
LIMIT 10;

-- Category Compliance
SELECT Expenses.category AS Category, COUNT(*) AS Transactions, ROUND(SUM(Expenses.amount),2) AS Total_Spend, COUNT(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN 1
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN 1
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN 1
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN 1
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN 1
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN 1
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN 1
END) AS Violations,
ROUND(COUNT(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN 1
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN 1
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN 1
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN 1
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN 1
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN 1
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN 1
END) * 100.0 / COUNT(*),2) AS Violation_Rate,
ROUND(SUM(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN Expenses.amount - 30
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN Expenses.amount - 50
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN Expenses.amount - 75
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN Expenses.amount - 300
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN Expenses.amount - 800
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN Expenses.amount - 150
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN Expenses.amount - 75
ELSE 0
END),2) AS Excess_Spend
FROM Expenses
GROUP BY Expenses.category
ORDER BY Violation_Rate DESC;

-- Monthly Compliance
SELECT strftime('%m', Expenses.date) AS Month, COUNT(*) AS Transactions, ROUND(SUM(Expenses.amount), 2) AS Total_Spend, COUNT(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN 1
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN 1
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN 1
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN 1
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN 1
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN 1
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN 1
END ) AS Violations,
ROUND(COUNT(
CASE
WHEN Expenses.category = 'Breakfast' AND Expenses.amount > 30 THEN 1
WHEN Expenses.category = 'Lunch' AND Expenses.amount > 50 THEN 1
WHEN Expenses.category = 'Dinner' AND Expenses.amount > 75 THEN 1
WHEN Expenses.category = 'Hotel' AND Expenses.amount > 300 THEN 1
WHEN Expenses.category = 'Airfare' AND Expenses.amount > 800 THEN 1
WHEN Expenses.category = 'Train' AND Expenses.amount > 150 THEN 1
WHEN Expenses.category = 'Taxi/Rideshare' AND Expenses.amount > 75 THEN 1
END) * 100.0 / COUNT(*),2) AS Violation_Rate
FROM Expenses
GROUP BY Month
ORDER BY Month;
