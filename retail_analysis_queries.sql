
-- 1. Clean Missing/Null Records
DELETE FROM retail_sales_data
WHERE Order_ID IS NULL 
   OR Sales IS NULL 
   OR Profit IS NULL 
   OR Category IS NULL 
   OR Sub_Category IS NULL;

-- 2. Profit Margin by Category and Sub-Category
SELECT 
    Category,
    Sub_Category,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0), 2) AS Profit_Margin,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales_data
GROUP BY Category, Sub_Category
ORDER BY Profit_Margin ASC;

-- 3. Top 10 Products with Highest Inventory Days and Low Profitability
SELECT 
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    AVG(Inventory_Turnover_Days) AS Avg_Inventory_Days,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0), 2) AS Profit_Margin
FROM retail_sales_data
GROUP BY Product_ID, Product_Name, Category, Sub_Category
HAVING Profit_Margin < 0.1
ORDER BY Avg_Inventory_Days DESC
LIMIT 10;

-- 4. Monthly Sales and Profit Trend
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales_data
GROUP BY Month
ORDER BY Month;

-- 5. Seasonal Product Performance
SELECT 
    Season,
    Category,
    Sub_Category,
    SUM(Sales) AS Seasonal_Sales,
    SUM(Profit) AS Seasonal_Profit
FROM retail_sales_data
GROUP BY Season, Category, Sub_Category
ORDER BY Season, Seasonal_Sales DESC;

