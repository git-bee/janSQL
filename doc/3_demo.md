# 3 Demo Guide

### 3.1 Demo Introduction

janSQLDemo was written to demonstrate the use of janSQL. It is a very simple program that allows you to enter and execute SQL statements, provides any error feedback, and will show the result of `SELECT` queries in a stringgrid.

##### Connect to the database

The very first statement you must execute is the `CONNECT TO` statement. Just press the F9 key when you have started janSQLDemo.

##### Experiment

Unless you issue the `COMMIT` statement, all processing is done in-memory. This makes janSQL and the demo in particular, ideal for experimenting with SQL. An exception are the `CREATE TABLE` and the `DROP TABLE` statement, which are executed immediately.

##### Examples

janSQLDemo comes with a series of testing examples stored in the `samples.txt` file. You can add your own samples following the same format as the current samples. The sample title should be placed on a seperate line between square brackets.

```sql
[order by]
SELECT *
FROM users
ORDER BY #userid ASC, productid DESC
```

Sample titles will be automatically added to the `Samples` menu.

##### Hints

The result of a `SELECT` statement is displayed in the stringgrid. You will notice that when you move over a cell, the complete text of the cell is displayed as a hint. You can use the technique that I used in your own programs.

##### Loading and Saving

janSQL allows you to execute a batch of SQL statements seperated by a semicolon. Using the `Load and Save` menu options you can load and save `.sql` files that contain multiple SQL statements.

-----
< [back to index](index.md) | [previous](2_programming.md) | [next](4_component.md) >
