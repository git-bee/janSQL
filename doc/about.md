# 1 About

### 1.1 janSQL

TjanSQL is a single user relational Database engine implemented as a Delphi object using plain text files with semi-colon seperated data for data storage. Released under MOZILLA PUBLIC LICENSE Version 1.1. 

Supported SQL: 
- SELECT (with table joins, field aliases and calculated), 
- UPDATE, 
- INSERT (values and sub-select), 
- DELETE, 
- CREATE TABLE, 
- DROP TABLE, 
- ALTER TABLE, 
- CONNECT TO, 
- COMMIT, 
- WHERE (rich bracketed expression), 
- IN (list or sub query), 
- GROUP BY, 
- HAVING, 
- ORDER BY (ASC, DESC), 
- nested sub queries, 
- statistics (COUNT, SUM, AVG, MAX, MIN), 
- operators (+,-,*,/, and, or,>,>=,<,<=,=,<>,Like), 
- functions (UPPER, LOWER, TRIM, LEFT, MID, RIGHT, LEN, FIX, SOUNDEX, SQR, SQRT). 
- High performance: 
  - complete in-memory handling of tables and recordsets; 
  - semi-compiled expressions. 
- NEW FEATURES: 
  - fixed memory leak, 
  - calculated fields (in select and update statements), 
  - field aliases, 
  - table aliases, 
  - join "unlimited" tables, 
  - stdDev aggregate function, 
  - ASSIGN TO for named temporary tables, 
  - SAVE TABLE for persisting recordsets, 
  - INSERT INTO, 
  - ISO 8601 dates, 
  - numerous extra functions.

##### Intended use

janSQL is intended for single-user desktop application where you want to access and update data using SQL without having to deploy the Borland Database engine or the Microsoft Data Access Components. janSQL is not intended to be used with the Delphi data access components. The included demo shows that it is very easy to create a user interface for janSQL, displaying data in a TStringGrid.

##### Motivation

When developing my PascalServer (a virtual web server that can serve Pascal Script pages to Dave Baldwin's THTMLViewer) I needed a fast and simple to use database engine that could be compiled into PascalServer. Although there are some good freeware Delphi database components (both for in-memory tables and for handling dbf files), I could not find a freeware component that would allow me to work with SQL (including joining of tables). So I started writing my own SQL DBMS.

##### License

janSQL is released under the MOZILLA PUBLIC LICENSE Version 1.1.

janSQL makes use of the mwStringHashList component created by Martin Martin Waldenburg (Martin.Waldenburg@T-Online.de). The source code of mwStringHashList is included. mwStringHashList was also released under MPL version 1.1.

This means that you are allowed to include janSQL in your freeware and commercial projects as long as you distribute the janSQL source code with your product and as long as you leave the MPL statements in the body of the source code intact and clearly indicate any modifications that you made.

### 1.2 New

janSQL was originally released on 24-Mar-2002 as version 1.0.

##### version 1.1 of 25-Mar-2002

- closed memory leaks
- allow "unlimited" number of tables in a join
- allow calculated updates: set field=expression
- table aliases
- StdDev aggregate function
- RecordFields are true objects

### 1.3 Updates

janSQL is written by Jan Verhoeven with Delphi 5.

Email: jan1.verhoeven@wxs.nl    
WebSite: http://jansfreeware.com

-----
< back to Index
