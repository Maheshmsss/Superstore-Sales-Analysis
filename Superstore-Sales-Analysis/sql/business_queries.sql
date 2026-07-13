CREATE DATABASE SuperstoreDB;


USE SuperstoreDB;


SELECT Customer_Name, Sales, Profit
FROM SampleSuperstore

SELECT SUM(Sales) AS TotalSales
FROM SampleSuperstore

SELECT SUM(Profit) AS TotalProfit
FROM SampleSuperstore

SELECT COUNT(DISTINCT order_ID )AS TotalOrders
FROM SampleSuperstore;


SELECT AVG(Sales) AS AverageSales
FROM SampleSuperstore;

SELECT COUNT(DISTINCT  Customer_ID ) AS TotalCustomers
FROM SampleSuperstore;

SELECT
    Category,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY Category
ORDER BY TotalSales DESC;

SELECT
    Region,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY Region
ORDER BY TotalSales DESC;

SELECT
    State,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY State
ORDER BY TotalSales DESC;

SELECT TOP 10
     Customer_Name ,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY  Customer_Name 
ORDER BY TotalSales DESC;



SELECT TOP 10
     Product_Name ,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY  Product_Name 
ORDER BY TotalSales DESC;


SELECT
     Order_Year ,
     Order_Month ,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY
     Order_Year ,
     Order_Month 
ORDER BY
     Order_Year ,
     Order_Month ;

SELECT
     Order_Year ,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY  Order_Year 
ORDER BY  Order_Year ;


SELECT
    Segment,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY Segment
ORDER BY TotalSales DESC;


SELECT
     Ship_Mode ,
    SUM(Sales) AS TotalSales
FROM SampleSuperstore
GROUP BY  Ship_Mode 
ORDER BY TotalSales DESC;


SELECT
    Category,
    SUM(Profit) AS TotalProfit
FROM SampleSuperstore
GROUP BY Category
ORDER BY TotalProfit DESC;

SELECT
     Order_Date ,
    Sales,
    AVG(Sales) OVER(
        ORDER BY  Order_Date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS MovingAverage
FROM SampleSuperstore;

SELECT
     Customer_Name ,
    SUM(Sales) AS TotalSales,
    RANK() OVER(
        ORDER BY SUM(Sales) DESC
    ) AS SalesRank
FROM SampleSuperstore
GROUP BY  Customer_Name ;

SELECT
     Customer_Name ,
    SUM(Sales) AS TotalSales,
    DENSE_RANK() OVER(
        ORDER BY SUM(Sales) DESC
    ) AS DenseRank
FROM SampleSuperstore
GROUP BY  Customer_Name ;

SELECT
     Customer_Name ,
    SUM(Sales) AS TotalSales,
    ROW_NUMBER() OVER(
        ORDER BY SUM(Sales) DESC
    ) AS RowNum
FROM SampleSuperstore
GROUP BY  Customer_Name ;


WITH CustomerSales AS
(
    SELECT
         Customer_Name ,
        SUM(Sales) AS TotalSales
    FROM SampleSuperstore
    GROUP BY  Customer_Name 
)

SELECT *
FROM CustomerSales
WHERE TotalSales > 10000;

SELECT
    Region,
     Customer_Name ,
    Sales,
    SUM(Sales) OVER(
        PARTITION BY Region
    ) AS RegionSales
FROM SampleSuperstore;

SELECT
     Order_Date ,
    Sales,
    LAG(Sales) OVER(
        ORDER BY  Order_Date 
    ) AS PreviousSale
FROM SampleSuperstore;

SELECT
     Order_Date ,
    Sales,
    LEAD(Sales) OVER(
        ORDER BY  Order_Date 
    ) AS NextSale
FROM SampleSuperstore;

SELECT
     Product_Name ,
    Profit,
    CASE
        WHEN Profit > 0 THEN 'Profit'
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'Break Even'
    END AS ProfitStatus
FROM SampleSuperstore;


SELECT *
FROM
(
    SELECT
        Category,
        Region,
        Sales
    FROM SampleSuperstore
) AS SourceTable

PIVOT
(
    SUM(Sales)
    FOR Region IN
    (
        East,
        West,
        South,
        Central
    )
) AS PivotTable;




SELECT
    Category,
    Region,
    Sales
FROM
(
    SELECT
        Category,
        East,
        West,
        South,
        Central
    FROM SalesPivot
) p

UNPIVOT
(
    Sales
    FOR Region IN
    (
        East,
        West,
        South,
        Central
    )
) u;






CREATE PROCEDURE GetSalesByCategory
AS
BEGIN
    SELECT
        Category,
        SUM(Sales) AS TotalSales
    FROM SampleSuperstore
    GROUP BY Category;
END;

EXEC GetSalesByCategory;







CREATE VIEW vw_CustomerSales
AS

SELECT
     Customer_Name ,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM SampleSuperstore
GROUP BY  Customer_Name ;
SELECT *
FROM vw_CustomerSales;

CREATE INDEX idx_orderdate
ON SampleSuperstore( Order_Date );
CREATE INDEX idx_customer
ON SampleSuperstore( Customer_ID );
CREATE INDEX idx_category
ON SampleSuperstore(Category);
CREATE INDEX idx_region
ON SampleSuperstore(Region);





SELECT * FROM SampleSuperstore

