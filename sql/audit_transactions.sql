-- Audit Transactions
SELECT Expenses.Transaction_ID,Expenses.Employee_ID,Employees.Name,Employees.Department,
Employees.Region,Expenses.Category,Expenses.Amount,Expenses.Date,Expenses.Payment_Method,
Expenses.Business_Purpose,Expenses.Location,
-- Policy LIMIT
CASE
WHEN Expenses.Category = 'Breakfast' THEN 30
WHEN Expenses.Category = 'Lunch' THEN 50
WHEN Expenses.Category = 'Dinner' THEN 75
WHEN Expenses.Category = 'Hotel' THEN 300
WHEN Expenses.Category = 'Airfare' THEN 800
WHEN Expenses.Category = 'Train' THEN 150
WHEN Expenses.Category = 'Taxi/Rideshare' THEN 75
END AS Policy_Limit,
-- Excess Amount
ROUND(CASE
WHEN Expenses.Category = 'Breakfast' AND Expenses.Amount > 30 THEN Expenses.Amount - 30
WHEN Expenses.Category = 'Lunch' AND Expenses.Amount > 50 THEN Expenses.Amount - 50
WHEN Expenses.Category = 'Dinner' AND Expenses.Amount > 75 THEN Expenses.Amount - 75
WHEN Expenses.Category = 'Hotel' AND Expenses.Amount > 300 THEN Expenses.Amount - 300
WHEN Expenses.Category = 'Airfare' AND Expenses.Amount > 800 THEN Expenses.Amount - 800
WHEN Expenses.Category = 'Train' AND Expenses.Amount > 150 THEN Expenses.Amount - 150
WHEN Expenses.Category = 'Taxi/Rideshare' AND Expenses.Amount > 75 THEN Expenses.Amount - 75
ELSE 0
END, 2) AS Excess_Amount,
-- Policy Violation
CASE
WHEN Expenses.Category = 'Breakfast' AND Expenses.Amount > 30 THEN 1
WHEN Expenses.Category = 'Lunch' AND Expenses.Amount > 50 THEN 1
WHEN Expenses.Category = 'Dinner' AND Expenses.Amount > 75 THEN 1
WHEN Expenses.Category = 'Hotel' AND Expenses.Amount > 300 THEN 1
WHEN Expenses.Category = 'Airfare' AND Expenses.Amount > 800 THEN 1
WHEN Expenses.Category = 'Train' AND Expenses.Amount > 150 THEN 1
WHEN Expenses.Category = 'Taxi/Rideshare' AND Expenses.Amount > 75 THEN 1
ELSE 0 END AS Policy_Violation,
-- Missing Receipt
CASE
WHEN Expenses.Has_Receipt = 'No' THEN 1
ELSE 0 END AS Missing_Receipt,
-- Personal Card
CASE
WHEN Expenses.Payment_Method = 'Personal Card' THEN 1
ELSE 0 END AS Personal_Card_Flag,
-- Status
CASE
WHEN (Expenses.Category = 'Breakfast' AND Expenses.Amount > 30)
OR (Expenses.Category = 'Lunch' AND Expenses.Amount > 50)
OR (Expenses.Category = 'Dinner' AND Expenses.Amount > 75)
OR (Expenses.Category = 'Hotel' AND Expenses.Amount > 300)
OR (Expenses.Category = 'Airfare' AND Expenses.Amount > 800)
OR (Expenses.Category = 'Train' AND Expenses.Amount > 150)
OR (Expenses.Category = 'Taxi/Rideshare' AND Expenses.Amount > 75)
OR Expenses.Has_Receipt = 'No'
OR Expenses.Payment_Method = 'Personal Card'
THEN 'Review'
ELSE 'OK'
END AS Compliance_Status
FROM Expenses
JOIN Employees
ON Expenses.Employee_ID = Employees.Employee_ID;
