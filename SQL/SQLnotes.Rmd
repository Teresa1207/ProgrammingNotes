---
title: "SQL"
author: ""
date: ""
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## SQL Notes {.tabset}

 - SQL is a language for accessing/manipulating databases: Structured Query Language, ANSI standard.
 - major commands
 - SELECT, UPDATE, DELETE, INSERT, WHERE
 - RDBMS stands for Relational Database Management System, this is the basis for SQL, data is stored in objects called tables. 
 - A table is a collection of related data entries and it consists of columns and rows. 
tables are identified by names, records are the rows.



### Statements

 - SQL Statements (not case sensitive)
 - most important SQL statements: 
    - SELECT: extracts data from a db
    - UPDATE: updates data in a db
    - DELETE: deletes data from a db
    - INSERT INTO: inserts new data into a db
    - CREATE DATABASE: creates new database
    - ALTER DATABASE: modifies a database
    - CREATE TABLE: creates a table
    - DROP TABLE: deletes a table
    - CREATE INDEX: creates an index (search key)
    - DROP INDEX: deletes an index
    
#### SELECT

   - SELECT column1, column2 FROM table1
   - SELECT * FROM table (selects all the columns)
   - create a table

#### SELECT DISTINCT: 
 
  - used to return only distinct values, if duplicate values are there, this is how we get rid of them. 
   - SELECT DISTINCT column2 FROM table1

#### WHERE: used to filter records

   - SELECT column1, column2 FROM table1 WHERE column3 operator function (e.g. >2)
       operator functions allowed: 
   - =,<>,>,<, >=,<=, BETWEEN, LIKE, IN (v1,v2)

#### AND/OR 

 - are used to further filter records on one or more conditions, 
 - use parenthesis to specify order of operation

#### ORDER BY 

 - is used to sort result by keyword (one or more columns) 
  - separate by commas, use ASC, DESC

#### INSERT INTO: 

 - used to insert new records in a table
 - INSERT INTO table1 VALUES (v1,v2,v3)
 - INSERT INTO table1 (col1,col2,col3) VALUES (v1,v2,v3), inserts into rows

#### UPDATE, SET, WHERE 
 
 - Change the value of a record, update existing table
 - UPDATE table1 SET col1 = value1, col2 = value2,… WHERE col3>5 
 - if you don’t specify WHERE the whole column will be updated!

#### DELETE 

 - similar to UPDATE, must identify WHERE, or entire selection will be deleted!
  - DELETE FROM table1 WHERE column > 5
  - to delete all without deleting the table
   - DELETE FROM table1, or,   DELETE * FROM table1
   
 
#### SELECT TOP

 - used to specify number of records to return
 - can be useful on large tables with thousands of records. (not all databases support SELECT TOP)
 - different syntax depending
 - SQL server: 
   - SELECT TOP ###|percent column_names FROM table1
   - SELECT TOP 50 PERCENT * FROM Customers
 - MySQL server: 
   - SELECT col1 FROM table1 LIMIT ##
   
 
#### SELECT LIKE

 - used to search for a specified pattern in a column
 - SELECT col1 FROM table1 WHERE col1 LIKE pattern
 - Example:
     - SELECT * FROM Customers WHERE City LIKE 's%' (this selects all customers with a City name ending with letter s)
     - SELECT * FROM Customers WHERE Country LIKE '%land%' (this selects all customers with Country that has 'land' in name)
 - % sign is used to define wildcards (missing letters) both before and after a pattern
 - you can use NOT to select records that do NOT contain the pattern
     - SELECT * FROM Customers WHERE Country NOT LIKE '%land%' (this selects all customers with Country that do NOT have   'land' in name)


#### IN

 - IN allows you to specify multiple values in a WHERE clause
 - SELECT col1 FROM table1 WHERE col1 IN (v1,v2,v3...)

#### BETWEEN

 - BETWEEN allows you to specify multiple values in a range in a WHERE clause
 - SELECT col1 FROM table1 WHERE col1 BETWEEN v1 AND v2
 - you can add NOT to specify not in the range
     - SELECT * FROM Products WHERE (Price BETWEEN 10 AND 20) AND NOT CategoryID IN (1,2,3);
     
     


### Statements JOINS

#### JOIN 
 
  - SQL JOIN is used to combine rows from two or more tables, based on a common field between them
   - SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate  
    FROM Orders  
    INNER JOIN Customers  
    ON Orders.CustomerID=Customers.CustomerID;  
    
  - There are different types of JOINS
     - INNER JOIN: Returns all rows when there is at least one match in BOTH tables
     - LEFT JOIN: Return all rows from the left table, and the matched rows from the right table
     - RIGHT JOIN: Return all rows from the right table, and the matched rows from the left table
     - FULL JOIN: Return all rows when there is a match in ONE of the tables

#### INNER JOIN (JOIN) are the same
 - The INNER JOIN keyword selects all rows from both tables as long as there is a match between the columns. If there are rows in the "Customers" table that do not have matches in "Orders", these customers will NOT be listed.

  SELECT column_name(s)  
  FROM table1  
  INNER JOIN table2  
  ON table1.column_name=table2.column_name;   
  
OR  

  SELECT column_name(s)  
  FROM table1  
  JOIN table2  
  ON table1.column_name=table2.column_name;  


#### LEFT JOIN
 
  - The LEFT JOIN returns all rows from the left table (table1) with the matching rows in the right table (table2)
  - It will keep everything in table 1 and only select stuff from table 2 that matches on selection criterion
  
  SELECT column_name(s)  
  FROM table1  
  LEFT JOIN table2  
  ON table1.column_name=table2.column_name;  
 
#### RIGHT JOIN
 
  - The RIGHT JOIN returns all rows from the right table (table2) with the matching rows in the left table (table1)
  - It will keep everything in table 2 and only select stuff from table 1 that matches on selection criterion
 
   
  SELECT column_name(s)  
  FROM table1  
  RIGHT JOIN table2  
  ON table1.column_name=table2.column_name;  


#### FULL OUTER JOIN
 - returns all rows from left and right table
 - combines the result of both LEFT and RIGHT joins
 - The FULL OUTER JOIN keyword returns all the rows from the left table (Customers), and all the rows from the right   table (Orders). 
 - If there are rows in "Customers" that do not have matches in "Orders", or if there are rows in "Orders" that do not have matches in "Customers", those rows will be listed as well. 
 
  SELECT Customers.CustomerName, Orders.OrderID  
  FROM Customers  
  FULL OUTER JOIN Orders  
  ON Customers.CustomerID=Orders.CustomerID  
  ORDER BY Customers.CustomerName;  


### Statement tools

#### Wildcard characters

 - wildcard characters are used with the SQL LIKE operator
 - used to search for data within a table
     - % : substitute for zero or more characters
     - _ : single character
     - "[skjdf]": sets and ranges of characters to match
     - "[^charlist]", or '![charlist]' Matches only a character not specified in bracket
     - see above for some examples, here are more. 
       - SELECT * FROM Customers WHERE City LIKE '_erlin'; (this would mean we want any character followed by erlin.)
       - SELECT * FROM Customers WHERE City LIKE 'L_n_on'; (patterns with any characters where _ are. )
       - SELECT * FROM Customers WHERE City LIKE '[bsp%]'; (selects all customers with a City starting with b,s,or p)
       - SELECT * FROM Customers WHERE City LIKE '[a-c]'; (selects all customers with a City starting letters between a-c)
       - SELECT * FROM Customers WHERE City LIKE '[!a-c]'; (selects all customers with a City not starting letters between a-c)
       - SELECT * FROM Customers WHERE City NOT LIKE '[a-c]'; (selects all customers with a City not starting letters between a-c)

#### INJECTION

 - Injections can be used to destroy a database. 
 - hackers use these to trick the system, in a sense
 - See [SQL Injections](https://www.w3schools.com/sql/sql_injection.asp "SQL Injection W3 schools")
 - The only proven way to protect a web site from SQL injection attacks, is to use SQL parameters.
 - SQL parameters are values that are added to an SQL query at execution time, in a controlled manner.

#### Aliases

 - used to temporary rename a table or column heading
 - SELECT col1 AS alias_name FROM table1
 - SELECT col1 FROM table 1 AS alisa_name
 - SELECT CustomerName, Address+', '+City+', '+PostalCode+', '+Country AS Address FROM Customers; (this creates a new column named Address that combines all this information)

 - SELECT o.OrderID, o.OrderDate, c.CustomerName  
    FROM Customers AS c, Orders AS 0  
    WHERE c.CustomerName="Around the Horn" AND c.CustomerID=o.CustomerID;
 - Aliases can be useful when:
    - There are more than one table involved in a query
    - Functions are used in the query
    - Column names are big or not very readable
    - Two or more columns are combined together

