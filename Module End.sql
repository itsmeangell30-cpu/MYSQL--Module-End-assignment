Drop database elearning_Platform;

-- Database creation
Create Database Elearning_Platform;

-- Table creation
Use Elearning_Platform;
Create table learners(
             learner_id int Primary key,
             Full_name varchar(50)Unique Not null,
             Country  Varchar(100)
             );
 Drop table Courses; 
 Drop table Purcahses;
Create table Courses(
			Course_id int Primary key,
			Course_name Varchar(100)Not null,
            Category  Varchar(100),
            Unit_Price Decimal(10,2)
            );
            
     ALTER TABLE Courses
	 DROP INDEX Category;
     
	SHOW CREATE TABLE Courses;

Create table Purchases(
	        Purchase_id int Primary key,
            learner_id int,
            Course_id int,
            quantity int,
            Purchase_date Date Default(Current_date),
            Foreign key(learner_id)References learners(learner_id),
            Foreign key(course_id)References courses(course_id)
            );
            
 -- Insertion of Data
  Insert INTO learners (learner_id, Full_name, Country)
VALUES
(1, 'Arun Kumar', 'India'),
(2, 'Priya Sharma', 'India'),
(3, 'John Smith', 'USA'),
(4, 'Emma Wilson', 'UK'),
(5, 'Rahul Verma', 'India');

Select * FROM learners;

     INSERT INTO Courses (Course_id, Course_name, Category, Unit_Price)
VALUES
(101, 'Python for Beginners', 'Programming', 499.00),
(102, 'Advanced Excel', 'Data Analytics', 399.00),
(103, 'Power BI Essentials', 'Data Analytics', 599.00),
(104, 'MySQL Database Fundamentals', 'Database', 450.00),
(105, 'Machine Learning Basics', 'Artificial Intelligence', 799.00);

Select * FROM Courses;

    
 INSERT INTO Purchases
(Purchase_id, learner_id, Course_id, quantity, Purchase_date)
VALUES
(1001, 1, 101, 1, '2026-01-10'),
(1002, 2, 103, 1, '2026-01-12'),
(1003, 3, 102, 2, '2026-01-15'),
(1004, 4, 105, 1, '2026-01-18'),
(1005, 5, 104, 1, '2026-01-20'),
(1006, 1, 103, 2, '2026-01-22'),
(1007, 2, 101, 1, '2026-01-25'),
(1008, 3, 105, 1, '2026-02-01');

Select * FROM learners;
Select * FROM Courses;
Select * FROM Purchases;
-- Inner Join
 SELECT
    L.Full_name AS Learner_Name,
    C.Course_name AS Course_Name,
    C.Category AS Category,
    P.quantity AS Quantity,
    FORMAT(C.Unit_Price * P.quantity, 2) AS Total_Amount,
    P.Purchase_date AS Purchase_Date
FROM Purchases P
INNER JOIN learners L
    ON P.learner_id = L.learner_id
INNER JOIN Courses C
    ON P.Course_id = C.Course_id
ORDER BY (C.Unit_Price * P.quantity) DESC;

-- Left Join
SELECT
    L.Full_name AS Learner_Name,
    C.Course_name AS Course_Name,
    C.Category AS Category,
    P.quantity AS Quantity,
    FORMAT(C.Unit_Price * P.quantity, 2) AS Total_Amount,
    P.Purchase_date AS Purchase_Date
FROM learners L
LEFT JOIN Purchases P
    ON L.learner_id = P.learner_id
LEFT JOIN Courses C
    ON P.Course_id = C.Course_id
ORDER BY (C.Unit_Price * P.quantity) DESC;

-- Right Join
SELECT
    L.Full_name AS Learner_Name,
    C.Course_name AS Course_Name,
    C.Category AS Category,
    P.quantity AS Quantity,
    FORMAT(C.Unit_Price * P.quantity, 2) AS Total_Amount,
    P.Purchase_date AS Purchase_Date
FROM Courses C
RIGHT JOIN Purchases P
    ON C.Course_id = P.Course_id
RIGHT JOIN learners L
    ON P.learner_id = L.learner_id
ORDER BY (C.Unit_Price * P.quantity) DESC;

-- Core analytical Query
-- Display each learner’s total spending with their country. 
SELECT
    L.Full_name AS Learner_Name,
    L.Country AS Country,
    ROUND(SUM(C.Unit_Price * P.quantity), 2) AS Total_Spending
FROM learners L
INNER JOIN Purchases P
    ON L.learner_id = P.learner_id
INNER JOIN Courses C
    ON P.Course_id = C.Course_id
GROUP BY
    L.learner_id,
    L.Full_name,
    L.Country
ORDER BY Total_Spending DESC;

-- To Find the top 3 most purchased courses by quantity
SELECT
    C.Course_name AS Course_Name,
    SUM(P.quantity) AS Total_Quantity
FROM Courses C
INNER JOIN Purchases P
    ON C.Course_id = P.Course_id
GROUP BY
    C.Course_id,
    C.Course_name
ORDER BY Total_Quantity DESC
LIMIT 3;

-- Show each category’s: Total revenue  ,  Number of unique learners 
SELECT
    C.Category AS Category,
    ROUND(SUM(C.Unit_Price * P.quantity), 2) AS Total_Revenue,
    COUNT(DISTINCT P.learner_id) AS Unique_Learners
FROM Courses C
INNER JOIN Purchases P
    ON C.Course_id = P.Course_id
GROUP BY C.Category
ORDER BY Total_Revenue DESC;
-- To List learners who purchased from more than one category. 
SELECT
    L.Full_name AS Learner_Name,
    COUNT(DISTINCT C.Category) AS Category_Count
FROM learners L
INNER JOIN Purchases P
    ON L.learner_id = P.learner_id
INNER JOIN Courses C
    ON P.Course_id = C.Course_id
GROUP BY
    L.learner_id,
    L.Full_name
HAVING COUNT(DISTINCT C.Category) > 1;

-- To Identify courses never purchased. 
SELECT
    C.Course_id AS Course_ID,
    C.Course_name AS Course_Name,
    C.Category AS Category
FROM Courses C
LEFT JOIN Purchases P
    ON C.Course_id = P.Course_id
WHERE P.Purchase_id IS NULL;

-- Subqueries & Correlated Subqueries 
-- TO Find learners whose total spending is above the average learner spending. 
SELECT
    L.Full_name AS Learner_Name,
    ROUND(SUM(C.Unit_Price * P.quantity), 2) AS Total_Spending
FROM learners L
INNER JOIN Purchases P
    ON L.learner_id = P.learner_id
INNER JOIN Courses C
    ON P.Course_id = C.Course_id
GROUP BY
    L.learner_id,
    L.Full_name
HAVING SUM(C.Unit_Price * P.quantity) >
(
    SELECT AVG(Learner_Total)
    FROM
    (
        SELECT
            P.learner_id,
            SUM(C.Unit_Price * P.quantity) AS Learner_Total
        FROM Purchases P
        INNER JOIN Courses C
            ON P.Course_id = C.Course_id
        GROUP BY P.learner_id
    ) AS Spending
)
ORDER BY Total_Spending DESC;

-- To Display courses whose price is higher than any course in the ‘Beginner’ category. 
SELECT
    Course_id AS Course_ID,
    Course_name AS Course_Name,
    Category,
    Unit_Price
FROM Courses
WHERE Unit_Price > ANY
(
    SELECT Unit_Price
    FROM Courses
    WHERE Category = 'Beginner'
)
ORDER BY Unit_Price DESC;

-- To Find learners who spent more than the average spending in their country. 
SELECT
    L.Full_name AS Learner_Name,
    L.Country AS Country,
    ROUND(SUM(C.Unit_Price * P.quantity), 2) AS Total_Spending
FROM learners L
INNER JOIN Purchases P
    ON L.learner_id = P.learner_id
INNER JOIN Courses C
    ON P.Course_id = C.Course_id
GROUP BY
    L.learner_id,
    L.Full_name,
    L.Country
HAVING SUM(C.Unit_Price * P.quantity) >
(
    SELECT AVG(Country_Spending)
    FROM
    (
        SELECT
            L2.learner_id,
            L2.Country,
            SUM(C2.Unit_Price * P2.quantity) AS Country_Spending
        FROM learners L2
        INNER JOIN Purchases P2
            ON L2.learner_id = P2.learner_id
        INNER JOIN Courses C2
            ON P2.Course_id = C2.Course_id
        WHERE L2.Country = L.Country
        GROUP BY
            L2.learner_id,
            L2.Country
    ) AS CountryTotals
)
ORDER BY Total_Spending DESC;
 
 -- Use a CTE to calculate total spending per learner, then:  Display learners with spending above 10,000. 

 WITH LearnerSpending AS
(
    SELECT
        L.learner_id,
        L.Full_name AS Learner_Name,
        ROUND(SUM(C.Unit_Price * P.quantity), 2) AS Total_Spending
    FROM learners L
    INNER JOIN Purchases P
        ON L.learner_id = P.learner_id
    INNER JOIN Courses C
        ON P.Course_id = C.Course_id
    GROUP BY
        L.learner_id,
        L.Full_name
)
SELECT
    Learner_Name,
    Total_Spending
FROM LearnerSpending
WHERE Total_Spending > 10000
ORDER BY Total_Spending DESC;

-- CASE Expression 
-- Classify learners based on spending: 
-- ●	Above 15,000 → “High Value”, 
-- ●	8,000–15,000 → “Medium Value”
--  ● Below 8,000 → “Low Value”. 

SELECT
    L.Full_name AS Learner_Name,
    ROUND(SUM(C.Unit_Price * P.quantity), 2) AS Total_Spending,
    CASE
        WHEN SUM(C.Unit_Price * P.quantity) > 15000
            THEN 'High Value'
        WHEN SUM(C.Unit_Price * P.quantity) BETWEEN 8000 AND 15000
            THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Learner_Category
FROM learners L
INNER JOIN Purchases P
    ON L.learner_id = P.learner_id
INNER JOIN Courses C
    ON P.Course_id = C.Course_id
GROUP BY
    L.learner_id,
    L.Full_name
ORDER BY Total_Spending DESC;

-- NULL Handling 
-- ●	Display all courses and replace NULL purchase counts with 0 using: IFNULL() or COALESCE() 

SELECT
    C.Course_id AS Course_ID,
    C.Course_name AS Course_Name,
    C.Category AS Category,
    IFNULL(COUNT(P.Purchase_id), 0) AS Purchase_Count
FROM Courses C
LEFT JOIN Purchases P
    ON C.Course_id = P.Course_id
GROUP BY
    C.Course_id,
    C.Course_name,
    C.Category
ORDER BY Purchase_Count DESC;

-- View 
-- ●	Create a view: category_performance_view ● Showing: 
-- ●	Category 
-- ●	Total revenue 
-- ●	Number of purchases 
-- ●	Average revenue per purchase 

CREATE VIEW category_performance_view AS
SELECT
    C.Category AS Category,
    ROUND(SUM(C.Unit_Price * P.quantity), 2) AS Total_Revenue,
    COUNT(P.Purchase_id) AS Number_of_Purchases,
    ROUND(
        SUM(C.Unit_Price * P.quantity) / COUNT(P.Purchase_id),
        2
    ) AS Average_Revenue_Per_Purchase
FROM Courses C
INNER JOIN Purchases P
    ON C.Course_id = P.Course_id
GROUP BY C.Category;


SELECT *
FROM category_performance_view;


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 






















































































