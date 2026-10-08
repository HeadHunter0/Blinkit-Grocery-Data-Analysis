SELECT * FROM test.blinkit_grocery_data_full;

SELECT COUNT(*) FROM test.`blinkit grocery data`;

SELECT * FROM test.`blinkit grocery data`;

SELECT DISTINCT `Item Fat Content`
FROM test.`blinkit grocery data`;
--------------------------------------------
SET SQL_SAFE_UPDATES = 0;

--------------------------------------------

UPDATE test.`blinkit grocery data`
SET `Item Fat Content` =
    CASE
        WHEN `Item Fat Content` IN ('LF', 'Low Fat')
            THEN 'Low Fat'
        WHEN `Item Fat Content` = 'reg'
            THEN 'Regular'
        ELSE `Item Fat Content`
    END;
    
------------------------------------------------- 
    
SELECT
    SUM(Sales) AS Total_Sales
FROM test.`blinkit grocery data`;


SELECT CAST(SUM(Sales)/1000000 as DECIMAL(10,2)) AS Total_Sales_Millions
FROM test.`blinkit grocery data`;

---------------------------------------------------------------------------

SELECT
    AVG(Sales) AS Average_Sales
FROM test.`blinkit grocery data`;

SELECT
    CAST(AVG(Sales) as decimal(10,1)) AS Average_Sales
FROM test.`blinkit grocery data`;

--------------------------------------------------

select count(*) from test.`blinkit grocery data`;

---------------------------------------------------

SELECT CAST(SUM(Sales)/1000000 as DECIMAL(10,2)) AS Total_Sales_Millions
FROM test.`blinkit grocery data` 
where `Item Fat Content` = 'Low Fat';

---------------------------------------------------------------------------

SELECT CAST(SUM(Sales)/1000000 as DECIMAL(10,2)) AS Total_Sales_Millions
FROM test.`blinkit grocery data` 
where `Outlet Establishment Year` = 2022;

------------------------------------------------------------------

SELECT cast(avg(Rating) as decimal(10,2)) AS Average_rating
FROM test.`blinkit grocery data`;

-----------------------------------------------------------------------

SELECT `Item Fat Content`, 
cast(SUM(Sales) as decimal(10,2)) AS Total_Sales,
cast(avg(Rating) as decimal(10,2)) AS Average_rating,
count(*) as No_of_Items
FROM test.`blinkit grocery data` 
where `Outlet Establishment Year` = 2020
group by `Item Fat Content`
order by Total_Sales DESC ;

-------------------------------------------------------------------------

SELECT `Item Type`, 
cast(SUM(Sales) as decimal(10,2)) AS Total_Sales,
CAST(avg(Sales) as DECIMAL(10,1)) AS Avg_Sales,
cast(avg(Rating) as decimal(10,2)) AS Average_rating,
count(*) as No_of_Items
FROM test.`blinkit grocery data` 
group by `Item Type`
order by Total_Sales DESC 
limit 5;

-----------------------------------------------------------------------------

SELECT `Outlet Location Type`, `Item Fat Content`,
cast(SUM(Sales) as decimal(10,2)) AS Total_Sales
FROM test.`blinkit grocery data` 
group by `Outlet Location Type`, `Item Fat Content`
order by Total_Sales asc;
------------------------------------------------------------------------------

SELECT
    `Outlet Location Type`,
    cast(SUM(CASE
        WHEN `Item Fat Content` = 'Low Fat' THEN Sales
        ELSE 0
    END) as decimal(10,2)) AS Low_Fat,
    cast(SUM(CASE
        WHEN `Item Fat Content` = 'Regular' THEN Sales
        ELSE 0
    END) as decimal(10,2)) AS Regular
FROM test.`blinkit grocery data`
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;

-------------------------------------------------------------------------
SELECT `Outlet Establishment Year`,
cast(SUM(Sales) as decimal(10,2)) AS Total_Sales
FROM test.`blinkit grocery data` 
group by `Outlet Establishment Year`
order by `Outlet Establishment Year` asc;

-----------------------------------------------------------------------------

SELECT 
    `Outlet Size`,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER() AS DECIMAL(10,2)) AS Sales_Percentage
FROM test.`blinkit grocery data`
GROUP BY `Outlet Size`
ORDER BY Total_Sales DESC;

-------------------------------------------------------------------------------------------

SELECT `Outlet Location Type`,
cast(SUM(Sales) as decimal(10,2)) AS Total_Sales
FROM test.`blinkit grocery data` 
group by `Outlet Location Type`
order by Total_Sales desc;

-------------------------------------------------------------------------------

SELECT 
    `Outlet Type`,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
    CAST(AVG(`Item Visibility`) AS DECIMAL(10,2)) AS Item_Visibility
FROM test.`blinkit grocery data`
GROUP BY `Outlet Type`
ORDER BY Total_Sales DESC;
