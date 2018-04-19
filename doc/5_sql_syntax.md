# 5 SQL Syntax

### 5.1 SQL introduction

janSQL supports only a subset of standard SQL but the supported statements are sufficient for single-user desktop application.

##### Table updates

janSQL loads tables automatically into memory when needed by a query. Any changes to tables are performed in memory. Tables are saved to disk when you use the `COMMIT` statement. The only exceptions to this are the `CREATE TABLE` statement, where the new table is saved to disk immediately and the `DROP TABLE` statement, where the table is immediately deleted from both memory and disk.

##### Indexes

janSQL does not use indexes. You will find that for single-user desktop applications running in memory there is no urgent need for indexes.

##### Case sensitivity

janSQL is case-insensitive for its keywords: you can use both `SELECT` and `select`.

##### Non-standard

janSQL has several non-standard SQL statements for manipulation of recordsets.

* [`ASSIGN TO`](5_sql_syntax.md#515-assign-to)
* [`SAVE TABLE`](5_sql_syntax.md#517-save-table)
* [`RELEASE TABLE`](5_sql_syntax.md#516-release-table)

##### Compound Queries

By using the non-standard [`ASSIGN TO`](5_sql_syntax.md#515-assign-to) statement you can store the result of a select query as a named variable that can be used in subsequent queries.

### 5.2 CONNECT TO

Connects to a database. In janSQL a database is a folder. Tables are stored in this folder as semicolon `;` delimited text files with the `.csv` extension.

Syntax:
```sql
CONNECT TO 'absolute-folder-path'
```

Example:
```
connect to 'G:'
```

##### Notes

This is **always** the first statement that you use with janSQL. All other SQL statements require that the engine knows which folder to use.

### 5.3 COMMIT

Allows you to save modified in-memory tables to disk.

Syntax:
```sql
COMMIT
```

In janSQL all data handling is done in-memory and nothing is saved to disk until you issue the `COMMIT` command.

Whenever you make a change to a table with `ALTER TABLE`, `UPDATE` or `DELETE`, the change flag of the recordset is set. Only recordsets that have the change flag set will be saved. The change flag is reset after saving.

Only persistent recordsets are saved. A persistent recordset is a table loaded from disk.

### 5.4 CREATE TABLE

Creates a new table in the current catalog.

Syntax:
```sql
CREATE TABLE tablename (field1,[fieldN])
```

Example:
```sql
CREATE TABLE users (userid,username,accountname,accountpassword)
```

##### Notes

janSQL does not use field types. Everything is stored as text. Internally janSQL treats all data as variants. This means that in your SQL queries you can use fields pretty much the way you want to.

### 5.5 DROP TABLE

Drops a table from the database.

Syntax:
```sql
DROP TABLE tablename
```

Example:
```sql
DROP TABLE users
```

##### Notes

Use with care.

### 5.6 INSERT INTO

Allows you to insert data in a table, either row by row or from a recordset resulting from a `SELECT`.

Syntax:
```sql
INSERT INTO tablename [(column1[,column])] VALUES (field1[,fieldN]);
INSERT INTO tablename selectstatement;
```

Example:
```sql
INSERT INTO users VALUES (600,'user-600');
INSERT INTO users (userid,username) VALUES (601,'user-601');
INSERT INTO users SELECT * FROM users WHERE userid>400
```

##### Notes

When you insert records using a sub select you must make sure that the output fields of the sub select match the fieldnames of `tablename`. Only values of matching field will be inserted.

### 5.7 SELECT FROM

Allows you to select data from one or two tables.

Syntax:
```sql
SELECT fieldlist FROM tablename;
SELECT fieldlist FROM tablename WHERE condition;
SELECT fieldlist FROM tablename1 [alias1], tablenameN [aliasN];
SELECT fieldlist FROM tablename1 [alias1], tablenameN [aliasN] WHERE condition;
```

`fieldlist`: can be `*` for selecting all fields or `field1[,fieldN]`    
`field`: fieldname [`AS` fieldalias]    
`condition`: see the [`WHERE`](5_sql_syntax.md#58-where) topic.

##### Notes

When you join two or more tables you must use fully qualified field names: `tablename.fieldname` in the `WHERE` clause. Both `tablename`s and `fieldname`s can be aliased.

```sql
SELECT u.userid as mio, u.username as ma, p.productname as muu
FROM users u, products p
WHERE u.productid=p.productid
```

Using a table alias can save you typing.
```sql
select products.productname as product, count(users.userid) as quantity
from users,products
where users.productid=products.productid
group by product
having quantity>10
order by product desc
```

The example above shows you that in the `WHERE` clause you refer to source tables (e.g. `products.productid`) where as in the `GROUP BY`, `HAVING` and `ORDER BY` clause, you refer to the result table.

*Always* use an aliased field name when using an aggregate function:
```sql
count(users.userid) as quantity
```

### 5.8 WHERE

The `WHERE` clause can be used together with the `SELECT`, `UPDATE` and `DELETE` clauses.

Syntax:
```sql
WHERE condition
```

`condition`: The condition is an expression that must evaluate to a boolean `true` or `false`. The following operators are allowed:

* Arithmetic    
  `+ - * / ( )`
* Logic    
  `and` `or`
* Comparison    
  `< <= = > >=`
* String constants    
  e.g. `'Jan Verhoeven'`
* Numeric constans    
  e.g. `12.45`
* Field names    
  e.g. `userid`, `users.userid`
* `IN`    
  e.g.
  ```sql
  userid IN (300,401,402)
  username IN ('Verhoeven','Smith')
  ```
* `like`    
  e.g.
  ```sql
  username like '%Verhoeven'
  ```
  You can use the `%` character to match any series of characters:    
  `'%Verhoeven'` will match `Verhoeven` at the end of username.    
  `'Verhoeven%'` will match `Verhoeven` at the beginning of username.    
  `'%Verhoeven%'` will match `Verhoeven` anywhere in username.

##### Sub queries
You can use a subquery after the `IN` clause. Only non-correlated sub queries are allowed at the moment. A sub query must select a single field from a table. A sub query is executed at parsing time and returns a comma seperated list of values that replaces the query text in the `IN` clause. A sub query *must* be enclosed by brackets.

Example:
```sql
select * from users where productid in (select product id from products where productname like 'Ico%')
```

##### Notes

When using a `SELECT` with a join between 2 tables you *must* use fully qualified names (`tablename.fieldname` in every part of the query. In all other cases you must use the short form `fieldname` without the `tablename`.

### 5.9 UPDATE

Allows you to update existing data.

Syntax:
```sql
UPDATE tablename SET updatelist [WHERE condition]
```

`updatelist`: `field1=value1[,fieldN=valueN]`    
`condition`: see [`WHERE`](5_sql_syntax.md#58-where) for the optional condition.

### 5.10 DELETE FROM

Allows you to delete data.

Syntax:
```sql
DELETE FROM tablename WHERE condition
```

`condition`: see [`WHERE`](5_sql_syntax.md#58-where) clause for the condition.

### 5.11 ALTER TABLE

Allows you to alter the structure of a table.

Syntax:
```sql
ALTER TABLE ADD COLUMN columnname;
ALTER TABLE DROP COLUMN columnname;
```

You can only add or drop *one* column at the time.

### 5.12 GROUP BY

Allows you to group data according grouping fields.

Syntax:
```sql
group by fieldlist
```

`fieldlist`: a comma seperated list of one or more fields that you want to grouping to be applied.

Example:
```sql
select count(userid), username, productid
from users
group by productid
order by productid
```

##### Aggregate functions

You can apply the `count`, `sum`, `avg`, `max`, `min`, `stddev` function to an input field. When you use these functions without a `GROUP BY` clause, the resultset will contain only one row.

### 5.13 HAVING

Allows you to filter a recordset resulting from a `GROUP BY` clause.

Syntax:
```sql
HAVING expression
```

Example:
```sql
select count(userid), username, productid
from users
group by productid
having userid>10
order by productid
```

##### Notes

Experienced SQL users will notice that janSQL uses a non-standard syntax in the `HAVING` clause. Instead of the standard `having count(userid)>10`, in janSQL you just use the name of the base table field, in this case `userid`.

You should be aware of the difference between the `WHERE` clause and the `HAVING` clause. The `WHERE` clause is applied to table(s) in the `FROM` clause. The `HAVING` is applied after filtering with `WHERE` and grouping with `GROUP BY` have been applied. The same applies to the `ORDER BY` clause wich is also applied to the final result set.

### 5.14 ORDER BY

Allows you to sort the resulting recordsets.

Syntax:
```sql
ORDER BY orderlist
```

Example:
```sql
select * from users order by #userid asc, productid desc
```

`orderlist`: a comma seperated list of one or more order by components `component1[,componentN]`

##### Order component:

`[#]fieldname [ASC|DESC]`

By placing the optional `#` before a fieldname it will be treated as a numeric field in the sort. Remember that in janSQL all data is stored as text.

After the `fieldname` you can optionally put `ASC` for an ascending sort, or `DESC` for a descending sort. When you omit the sort direction the default ascending sort order is used.

### 5.15 ASSIGN TO

Allows you to assign the result of a `SELECT` statement to a named recordset that can be referred to in subsequent statements. This is a non-standard SQL statement. `ASSIGN TO` is like a variable assignment. You can create very complex compound queries with `ASSIGN TO`.

Syntax:
```sql
ASSIGN TO tablename selectstatement
```

Example:
```sql
ASSIGN TO mis SELECT userid, username FROM users
```

If `tablename` already exists in the catalog then an error occurs.

When `tablename` does not exist in the catalog but was already assigned to then the existing recordset is overwritten.

##### Notes

Make sure that you use output field alias names when you `ASSIGN TO` using a `SELECT` with joined tables.

janSQL always creates a new recordset when you execute a `SELECT` statement. The janSQLDemo program will release this recordset after the resultset is displayed. When you execute the `ASSIGN TO` the given name will be assigned to the new recordset and the recordset itself will not be released until you use [`RELEASE TABLE`](5_sql_syntax.md#516-release-table).

### 5.16 RELEASE TABLE

Allows you to release any open table from memory, including intermediate tables created with `ASSIGN TO`. This is a non-standard SQL statement.

Syntax:
```sql
RELEASE TABLE tablename
```

Example:
```sql
ASSIGN TO mis SELECT * FROM users;
RELEASE TABLE mis;
```

### 5.17 SAVE TABLE

Allows you to save any open table, including intermediate tables, to a file. This is a non-standard SQL statement.

Syntax:
```sql
SAVE TABLE tablename
```

When `tablename` is not open, an error occurs. When you save an intermediate table (created with `ASSIGN TO`), the intermediate table becomes a persistant table that is also saved with the `COMMIT` statement.

Example:
```sql
ASSIGN TO mis SELECT * FROM users;
SAVE TABLE mis;
```

##### Notes

Once you have saved an intermediate table with `SAVE TABLE` you can not `ASSIGN TO` anymore.

-----
< [back to index](index.md) | [previous](4_component.md) | [next](6_functions.md) >
