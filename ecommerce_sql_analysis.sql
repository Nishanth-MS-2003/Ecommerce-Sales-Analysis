#STEP 1: Create Database
CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

#STEP 2: Create Table
CREATE TABLE ecommerce_sales (
    Invoice VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    Price DECIMAL(10,2),
    Revenue DECIMAL(12,2),
    InvoiceDate DATETIME,
    CustomerID INT,
    Country VARCHAR(50)
);

#Total Revenue
SELECT 
    SUM(Revenue) AS Total_Revenue
FROM ecommerce_sales;

#Total Number of Orders
SELECT 
    COUNT(DISTINCT Invoice) AS Total_Orders
FROM ecommerce_sales;

#Total Customers
SELECT 
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM ecommerce_sales;

#Monthly Sales Trend
SELECT 
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    SUM(Revenue) AS Monthly_Revenue
FROM ecommerce_sales
GROUP BY Year, Month
ORDER BY Year, Month;

#Top 10 Products by Revenue
SELECT 
    Description,
    SUM(Revenue) AS Product_Revenue
FROM ecommerce_sales
GROUP BY Description
ORDER BY Product_Revenue DESC
LIMIT 10;

#Country-wise Revenue
SELECT 
    Country,
    SUM(Revenue) AS Country_Revenue
FROM ecommerce_sales
GROUP BY Country
ORDER BY Country_Revenue DESC;

#Top 10 Customers by Spending
SELECT 
    CustomerID,
    SUM(Revenue) AS Total_Spent
FROM ecommerce_sales
GROUP BY CustomerID
ORDER BY Total_Spent DESC
LIMIT 10;

#Repeat Customers
SELECT 
    CustomerID,
    COUNT(DISTINCT Invoice) AS Number_of_Orders
FROM ecommerce_sales
GROUP BY CustomerID
HAVING Number_of_Orders > 1;

#Average Order Value (AOV)
SELECT 
    SUM(Revenue) / COUNT(DISTINCT Invoice) AS Avg_Order_Value
FROM ecommerce_sales;

#Best Selling Products (Quantity)
SELECT 
    Description,
    SUM(Quantity) AS Total_Quantity_Sold
FROM ecommerce_sales
GROUP BY Description
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;

#Revenue Contribution by Top Countries
SELECT 
    Country,
    ROUND(SUM(Revenue) * 100 / 
    (SELECT SUM(Revenue) FROM ecommerce_sales), 2) AS Revenue_Percentage
FROM ecommerce_sales
GROUP BY Country
ORDER BY Revenue_Percentage DESC;

#Data Validation Queries

#Check Negative Values
SELECT * FROM ecommerce_sales
WHERE Quantity <= 0 OR Price <= 0;

#Check Missing Customers
SELECT COUNT(*) 
FROM ecommerce_sales
WHERE CustomerID IS NULL;











