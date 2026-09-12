# MYSQL--Module-End-assignment
Analyzing E-Learning Platform Purchases using MySQL 
# 📚 Analyzing E-Learning Platform Purchases using MySQL

> **A MySQL-based data analysis project to understand learner purchases, course performance, category revenue, and spending patterns.**

---

## 📌 Table of Contents

* [📖 Project Overview](#-project-overview)
* [🎯 Business Objective](#-business-objective)
* [🗂️ Database Structure](#️-database-structure)
* [📊 Dataset Information](#-dataset-information)
* [🧹 Data Preparation](#-data-preparation)
* [🔍 SQL Analysis Performed](#-sql-analysis-performed)
* [📈 Key Insights](#-key-insights)
* [💡 Recommendations](#-recommendations)
* [🛠️ Skills & SQL Concepts Used](#️-skills--sql-concepts-used)
* [🏁 Conclusion](#-conclusion)

---

## 📖 Project Overview

* This project analyzes an **E-Learning Platform Purchase dataset** using **MySQL**.
* The objective is to understand:

  * 👤 Learner purchasing behavior
  * 📚 Course popularity
  * 📊 Category performance
  * 💰 Revenue generation
  * 🛒 Purchase quantities
  * 🌍 Learner spending by country
* The project uses SQL queries to transform raw purchase data into meaningful business insights.

---

## 🎯 Business Objective

The main objectives of this project are:

* Identify the **top-performing course categories**.
* Find the **most purchased courses**.
* Calculate **total spending by learner**.
* Identify learners purchasing from **multiple categories**.
* Find courses that have **never been purchased**.
* Compare learner spending with **average spending**.
* Analyze spending by **country**.
* Classify learners based on their spending value.
* Create a **view** to monitor category performance.

---

## 🗂️ Database Structure

The project contains **3 main tables**:

### 👤 1. Learners

Stores information about learners.

* `learner_id` – Unique learner ID
* `Full_name` – Learner name
* `Country` – Learner's country

### 📚 2. Courses

Stores information about available courses.

* `Course_id` – Unique course ID
* `Course_name` – Course name
* `Category` – Course category
* `Unit_Price` – Price of the course

### 🛒 3. Purchases

Stores learner purchase transactions.

* `Purchase_id` – Unique purchase ID
* `learner_id` – Learner reference
* `Course_id` – Course reference
* `quantity` – Number of units purchased
* `Purchase_date` – Date of purchase

### 🔗 Table Relationships

* `Purchases.learner_id` → `learners.learner_id`
* `Purchases.Course_id` → `Courses.Course_id`

---

## 📊 Dataset Information

The sample dataset contains:

| Item                     |  Count |
| ------------------------ | -----: |
| 👤 Learners              |      5 |
| 📚 Courses               |      5 |
| 🛒 Purchase Transactions |      8 |
| 💰 Total Revenue         | ₹5,641 |

### 📚 Course Categories

* Programming
* Data Analytics
* Database
* Artificial Intelligence

---

## 🧹 Data Preparation

The following steps were performed while preparing the database:

* Created the `Elearning_Platform` database.
* Created the **Learners, Courses, and Purchases** tables.
* Added **Primary Keys** to uniquely identify records.
* Added **Foreign Keys** to establish relationships between tables.
* Inserted sample learner, course, and purchase data.
* Used appropriate **data types** for IDs, names, prices, quantities, and dates.
* Checked relationships between learners, courses, and purchases.

---

## 🔍 SQL Analysis Performed

### 🔹 1. Joining Multiple Tables

Used:

* `INNER JOIN`
* LEFT JOIN`
* `RIGHT JOIN`
* 

**Purpose:**

* Combine learner, course, and purchase information.
* Analyze related records across multiple tables.

---

### 🔹 2. Revenue Analysis

Calculated:

* Total revenue
* Revenue by category
* Revenue per purchase
* Total spending by learner
---

### 🔹 3. Course Performance Analysis

Identified:

* Most purchased courses
* Purchase quantities
* Courses with no purchases
* Top-performing categories

---

### 🔹 4. Learner Spending Analysis

Analyzed:

* Total spending by learner
* Average learner spending
* Learners spending above average
* Learners spending above their country's average

---

### 🔹 5. Category Analysis

Calculated:

* Total category revenue
* Number of unique learners
* Number of purchases
* Average revenue per purchase

---

### 🔹 6. Multiple-Category Purchases

Identified learners who purchased courses from **more than one category**.

This helps understand learners with broader learning interests.

---

### 🔹 7. Subqueries

Used subqueries to:

* Compare learner spending with average spending.
* Compare course prices with courses from a specific category.
* Compare spending within countries.

---

### 🔹 8. CTE – Common Table Expression

Purpose :Used a **CTE** to calculate learner spending and identify learners whose spending exceeded a specified threshold.



### 🔹 9. CASE Statement

Used `CASE` to classify learners based on spending:

* 💎 **High Value** – Above ₹15,000
* ⭐ **Medium Value** – ₹8,000–₹15,000
* 🔹 **Low Value** – Below ₹8,000

---

### 🔹 10. NULL Handling

Used functions such as:

* `IFNULL()`
* `COALESCE()`

to handle missing values and display meaningful results.

---

### 🔹 11. SQL View

Created a view named:

**`category_performance_view`**

The view provides:

* Category
* Total Revenue
* Number of Purchases
* Average Revenue per Purchase

Example:

```sql
SELECT *
FROM category_performance_view;
```

---
SQL Query:

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

## 📈 Key Insights

Based on the analysis:

* 🥇 **Data Analytics** was the highest-revenue category with **₹2,595**.
* 🥈 **Artificial Intelligence** generated **₹1,598**.
* 📊 **Programming** generated **₹998**.
* 💻 **Database** generated **₹450**.
* 🏆 **Power BI Essentials** had the highest purchase quantity with **3 units**.
* 👤 **Arun Kumar** was the highest-spending learner with **₹1,697**.
* 👤 **John Smith** was the second-highest spender with **₹1,597**.
* 🔄 Several learners purchased courses from multiple categories.
* 📚 All available courses received at least one purchase in the current dataset.

> ⚠️ **Note:** The dataset is relatively small, so these insights are mainly intended for learning and demonstration purposes.

---

## 💡 Recommendations

* 📢 **Focus marketing on Data Analytics and Artificial Intelligence**, the highest-revenue categories.
* 🎯 Promote **Power BI Essentials** because it has the highest purchase quantity.
* 🔗 Create **course bundles** combining popular Data Analytics courses.
* 🛒 Use **cross-selling strategies** for learners purchasing from multiple categories.
* 🎁 Offer discounts or beginner bundles to encourage additional purchases.
* 📊 Continue collecting more transaction data to identify stronger long-term trends.

---

## 🛠️ Skills & SQL Concepts Used

### 💻 Technical Skills

* MySQL
* SQL
* Relational Database Management
* Data Analysis
* Data Aggregation
* Business Insight Generation

### 🔧 SQL Concepts

* `CREATE DATABASE`
* `CREATE TABLE`
* `INSERT`
* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`
* `HAVING`
* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* Aggregate Functions
* `SUM()`
* `COUNT()`
* `AVG()`
* `ROUND()`
* `IFNULL()`
* `CASE`
* Subqueries
* CTE
* Views
* Primary Keys
* Foreign Keys

---

## 🏁 Conclusion

This project demonstrates how **MySQL can be used to analyze e-learning purchase data and generate useful business insights**.

The analysis identifies high-performing categories, popular courses, learner spending behavior, and cross-category purchasing patterns. The results can help an e-learning platform improve **marketing strategies, course promotions, customer targeting, and revenue growth**.

---

### ⭐ Project Highlights

* 📚 **5 Courses**
* 👤 **5 Learners**
* 🛒 **8 Purchase Transactions**
* 💰 **₹5,641 Total Revenue**
* 🥇 **Top Category: Data Analytics**
* 🏆 **Top Course by Quantity: Power BI Essentials**
* 💻 **Database: MySQL**
