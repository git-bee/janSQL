# 4 Component

### 4.1 Component introduction

TjanSQL is a Delphi freeware component with source code released under the MOZILLA PUBLIC LICENSE Version 1.1. In fact `TjanSQL` is not a component but derived from `TObject`.

### 4.2 Installation

Please the supplied source files in any folder (e.g. `components\jansoft\janSQL`) and include the folder in the Delphi library path.

* janSQL.pas
* janSQLExpression2.pas
* janSQLTokenizer.pas
* janSQLStrings.pas
* mwStringHashList.pas

Then you create the component as described in TjanSQL creation. *[Todo: make here link to TjanSQL creation]*

### 4.3 janSQLStrings

A small unit with usefull string routines.

### 4.4 TjanSQL

#### 4.4.1 TjanSQL overview

`TjanSQL` was designed for ease of use. With just a few methods you can manage a database and display selected data:

```pascal
function SQLDirect(value:string):integer;
function ReleaseRecordset(arecordset:integer):boolean;
function Error:string;

property RecordSets[index:integer]:TjanRecordSet read getrecordset;
property RecordSetCount:integer read getRecordSetCount;
```

##### SQLDirect

Will process a `value` that consists of one or more semi-colon `;` seperated SQL statements and returns `0` in case of failure, `-1` in case of valid execution with no resultset, and the number of the result recordset in case of a `SELECT` statement.

##### Recordsets

Read-only property to retrieve a reference to a recordset. In janSQL, all collection (records, fields) are 0-based, except for the `recordsets` collection which is 1-based. In case of a select statement, `SQLDirect` will return the `index` of the generated result set.

See Retrieving Data *[todo: make here link to retrieving data]* for example code.

##### ReleaseRecordset

Allows you to release a recordset given the 1-based index of the recordset. You will normally use this after a `SELECT` resultset has been processed. Returns `false` in case of failure and `true` when the recordset was deleted.

##### RecordSetCount

Returns the number of recordsets. Can be used together with the `RecordSets` property and the `ReleaseRecordset` method to clear all recordsets.

##### Notes

TjanSQL and all helper components clean-up any resources they use automatically when freed.

#### 4.4.2 TjanSQL creation

You do not place TjanSQL on the component palette but create it in e.g. the `FormCreate` event of your form, and free it in the `FormDestroy` event of the form. Include `janSQL` in the `uses` clause of the `interface` part of the form.

```pascal
var
  janSQLDemoF: TjanSQLDemoF;
  appldir:string;
  thefile:string;
  db:TjanSQL;

procedure TjanSQLDemoF.FormCreate(Sender: TObject);
begin
  db:=TjanSQL.create;
end;

procedure TjanSQLDemoF.FormDestroy(Sender: TObject);
begin
  db.free;
end;
````

### 4.5 TjanRecordSet

#### 4.5.1 TjanRecordSet Overview

(Empty Page)

### 4.6 TjanRecord

#### 4.6.1 TjanRecord Overview

(Empty Page)

### 4.7 TjanRecordSetList

#### 4.7.1 TjanRecordSetList Overview

(Empty Page)

### 4.8 TjanRecordList

#### 4.8.1 TjanRecordList Overview

(Empty Page)

### 4.9 TjanSQLExpression2

#### 4.9.1 TjanSQLExpression2 Overview

This expression evaluator semi-compiles the expression that you assign, allowing for very fast evaluation.

This component was derived from several other evaluators I wrote in the past. It includes `InFix` to `PostFix` conversion. It is tailered for use with `TjanSQL`, but can be modified for general purpose use.

The evaluator uses only a single data type: `variant`, and uses a stack for calculations.

When you assign an expression it is tokenized using the `TjanSQLTokenizer` tokenizer.

-----
< [back to index](index.md) | [previous](3_demo.md) | [next](5_sql_syntax.md) >
