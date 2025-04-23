SELECT * FROM retailsales.sales;

-- Basic Querying and Filtering
-- Task 1: Retrieve all transactions where the total amount is greater than a specified value (e.g., 100).

SELECT 
    *
FROM
    sales
WHERE
    Total_Amount > 100
ORDER BY Total_Amount DESC;


-- Task 2: Find all customers who bought a specific product category (e.g., "Electronics").

SELECT 
    *
FROM
    sales
WHERE
    Product_Category = 'Electronics';

-- Task 3: Retrieve details of transactions where the price per unit is less than 50.

SELECT 
    *
FROM
    sales
WHERE
    Price_per_Unit < 50;
    
-- 2. Aggregate Functions
-- Task 4: Calculate the total sales (Total_Amount) for each product category.

SELECT 
    Product_Category, SUM(Total_Amount) AS SumAmount
FROM
    sales
GROUP BY Product_Category;

-- Task 5: Find the average quantity purchased per transaction for each customer.

SELECT 
    Customer_ID, AVG(Quantity) AS AvgQuantity
FROM
    sales
GROUP BY Customer_ID;

-- Task 6: Find the maximum and minimum total amount spent by a customer.

SELECT 
    Customer_ID,
    MIN(Total_Amount) AS MinPurchase,
    MAX(Total_Amount) AS MaxPurchase
FROM
    sales
GROUP BY Customer_ID;

-- Task 7: Count the number of transactions for each gender.

SELECT 
    Gender, COUNT(Transaction_ID) TotalTran
FROM
    sales
GROUP BY Gender;

-- Group By and HAVING
-- Task 8: Group the transactions by product category and find the total number of products sold and total sales amount for each category.

SELECT 
    Product_Category,
    SUM(Quantity) AS Quantity,
    SUM(Total_Amount) AS Total_Amount
FROM
    sales
GROUP BY Product_Category;

-- Task 9: Find product categories where the total sales amount exceeds a given threshold (e.g., 500).

SELECT 
    Product_Category, SUM(Total_Amount) AS Total_Amount
FROM
    sales
GROUP BY Product_Category
HAVING SUM(Total_Amount) > 500;

-- Subqueries
-- Task 12: Find the customers who have purchased more than the average quantity of products.

SELECT *
FROM retailsales.sales
WHERE Quantity > (
    SELECT AVG(Quantity)
    FROM retailsales.sales
);

-- Task 13: Retrieve transactions where the total amount is greater than the average total amount of all transactions.

SELECT 
    *
FROM
    sales
WHERE
    Total_Amount > (SELECT 
            AVG(Total_Amount)
        FROM
            sales);
            
-- Window Functions (if applicable)
-- Task 15: Use the ROW_NUMBER() function to assign a unique rank to each transaction ordered by total amount in descending order.

select *, 
row_number() over(order by Total_Amount desc) as UniqueRank
from sales;

-- Task 16: Use RANK() to rank customers based on the total amount spent across all their transactions.

select Customer_ID, sum(Total_Amount) Total_Amount, 
rank() over(order by sum(Total_Amount) desc ) As Ranks
from sales GROUP BY Customer_ID order by Ranks;

 -- Complex Queries
-- Task 20: Find the total amount spent by each customer, but only include customers who have made more than 3 transactions.

select Customer_ID, sum(Total_Amount) from sales group by Customer_ID having count(Transaction_ID) > 3;

-- Task 21: List customers who have made purchases in more than one product category.

SELECT 
    Customer_ID, Product_Category
FROM
    sales
GROUP BY Customer_ID , Product_Category
HAVING COUNT(DISTINCT (Product_Category)) > 1;

-- Task 22: Find the top 5 customers who spent the most on any given day.

SELECT 
    Customer_ID, SUM(Total_Amount)
FROM
    sales
GROUP BY Customer_ID
ORDER BY SUM(Total_Amount) DESC
LIMIT 5;

