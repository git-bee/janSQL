# 2 Programming Guide

### 2.1 Get Started

##### Get Started

If you are new to SQL (Structured Query Language) then you should first learn about SQL (either by reading a good book about it or by visiting an on-line tutorial e.g. http://www.w3schools.com).

##### janSQLDemo

Run this simple demo program that allows you to execute SQL statements and see the result of `SELECT` statements.

##### Connect

Before you can access data you must connect to a database. In janSQL a database is a folder. Using the [`CONNECT TO`](5_sql_syntax.md#51-connect-to) statement you can connect to a database. Just click the `Execute` button to execute the statement(s) in the SQL editor. When everything goes right you will see `OK` in the `message` box next to the `Execute` button.

##### Commit

Nothing is saved to disk until you issue the [`COMMIT`](5_sql_syntax.md#52-commit) statement. Not only does this make janSQL very fast but it also allows you to play with it without altering any disk based data.

##### Select

Enter the following simple select statement in the editor and click `Execute`:

```sql
select * from users
```

In the table grid you will see all records from the `users` table, with the field names displayed in the header of the grid.

##### More SQL

For other SQL instruction see the [SQL Syntax](5_sql_syntax.md) chapter where all supported SQL statements are explained.

##### Multiple SQL statements

You can enter multiple, semi-colon `;` seperated, SQL statements in the SQL editor. Upon clicking `Execute` each statement will be processed on turn.

### 2.2 Retrieving data

When you use janSQL in your own programs you obviously want to retrieve the data from a resulting recordset. Below you see the complete source code of janSQLDemo.

```pascal
unit janSQLDemoU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl,Grids, ExtCtrls, ComCtrls, ToolWin, Menus, janSQL, StdCtrls, Buttons;

type
  TjanSQLDemoF = class(TForm)
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Splitter1: TSplitter;
    viewgrid: TStringGrid;
    sqlmemo: TMemo;
    cmdExecute: TSpeedButton;
    edmessage: TEdit;
    Insert1: TMenuItem;
    ApplicationFolder1: TMenuItem;
    SelectedFolder1: TMenuItem;
    Help1: TMenuItem;
    Contents1: TMenuItem;
  
    procedure FormCreate(Sender: TObject);
    procedure cmdExecuteClick(Sender: TObject);
    procedure ApplicationFolder1Click(Sender: TObject);
    procedure SelectedFolder1Click(Sender: TObject);
    procedure Contents1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure showresults(resultset:integer);
  public
    { Public declarations }
  end;

var
  janSQLDemoF: TjanSQLDemoF;
  appldir:string;
  db:TjanSQL;

implementation

{$R *.DFM}

procedure TjanSQLDemoF.FormCreate(Sender: TObject);
begin
  appldir:=extractfiledir(application.exename);
  db:=TjanSQL.create;
  sqlmemo.Text:='connect to '''+appldir+'''';
end;

procedure TjanSQLDemoF.cmdExecuteClick(Sender: TObject);
var
  sqlresult:integer;
  sqltext:string;
begin
  sqltext:=sqlmemo.text;
  sqlresult:=db.SQLDirect(sqltext);

  if sqlresult<>0 then begin
    edmessage.Text:='OK';
    sqlmemo.text:='';
    if sqlresult>0 then begin
      showresults(sqlresult);
      db.ReleaseRecordset(sqlresult);
    end;
  end
  else
    edmessage.Text:=db.Error;

  sqlmemo.SetFocus;
end;

procedure TjanSQLDemoF.showresults(resultset:integer);
var
  r1:integer;
  i,arow,acol,c,rc,fc:integer;
begin
  r1:=resultset;
  rc:=db.RecordSets[r1].recordcount;
  if rc=0 then exit;
  fc:=db.RecordSets[r1].fieldcount;
  if fc=0 then exit;

  viewgrid.RowCount:=rc+1;
  viewgrid.ColCount:=fc;
  for i:=0 to fc-1 do
    viewgrid.Cells[i,0]:=db.recordsets[r1].FieldNames[i];
  for arow:=0 to rc-1 do
    for acol:=0 to fc-1 do
      viewgrid.cells[acol,arow+1]:=db.RecordSets[r1].records[arow].fields[acol];
end;

procedure TjanSQLDemoF.ApplicationFolder1Click(Sender: TObject);
begin
  sqlmemo.SelText:=appldir;
end;

procedure TjanSQLDemoF.SelectedFolder1Click(Sender: TObject);
var
  adir:string;
begin
  if not selectdirectory('Select Catalog Folder to insert','',adir) then exit;
  sqlmemo.SelText:=adir;
end;

procedure TjanSQLDemoF.Contents1Click(Sender: TObject);
begin
  application.HelpFile:=appldir+'.hlp';
  application.HelpJump('janSQL');
end;

procedure TjanSQLDemoF.FormDestroy(Sender: TObject);
begin
  db.free;
end;

end.
```

We use the `SQLDirect` method of a TjanSQL instance (in this case `db`) and retrieve an `sqlresult`. When `SQLDirect` returns `0` this means an error has occured. We retrieve the error string with `db.Error` and display it in the message box. When the returned value is >0 then a resulting recordset is returned. The return value is the (1-based) index of the recordset. Next we use `showresults(sqlresult)` to display the results in a TStringGrid.

This is really all the code you need. Instead of putting the values in a TStringGrid you could also put them in an array for further manipulation, or insert them in a html template for display in a web browser.

### 2.3 Performance

You will notice that TjanSQL is fast because all processing is done in-memory. Although not intented for use with huge tables, 1000 records are no problem.

As memory is becoming cheaper and computers becoming faster, you will be able to process your data even better and faster in the future.

### 2.4 Data Formats

janSQL uses the point as decimal separator:

`123.45` is a valid number. `123,45` is not.

### 2.5 Extending janSQL

Within the conditions of the MOZILLA PUBLIC LICENSE Version 1.1 you are allowed to modify and extend janSQL.

##### Adding new functions

Proceed as follows to add a new function to janSQL.

Suppose we want to add the `Ceil` function:
* Ceil rounds variables up toward positive infinity.    
  E.g.:    
  Ceil(-2.8) = -2    
  Ceil(2.8) = 3    
  Ceil(-1.0) = -1
* in janSQLTokenizer: add `toCeil` to `TTokenOperator`.
* in janSQLTokenizer: add `ceil` to the `IsFunction` function.    
  ```pascal
  else if value='ceil' then begin
    FtokenKind:=tkOperator;
    FTokenOperator:=toCeil;
    FtokenLevel:=7;
    result:=true;
  end
  ```
* in janSQLExpression2: add private procedure `procCeil` to `TjanSQLExpression2`.    
  ```pascal
  procedure TjanSQLExpression2.procCeil;
  var
    v1:variant;
  begin
    v1:=runpop;
    runpush(ceil(v1));
  end;
  ```
* in janSQLExpresion2: add case `toCeil` to the `runoperator` procedure.    
  ```pascal
  toCeil:procCeil;
  ```

That is all.

### 2.6 Data Exchange

When you have tables in other database formats, e.g. Access 2000 you can export them in delimited text format.

##### Export from Access 2000

The included `programs.csv` file was exported from an (out of date) Access 2000 database:
* Open the Access database
* Select the table to export
* Select File Export - Save as Type=text
* Select Save as delimited - Next
* Select Semi-colon delimiter; include field names on first row; text qualifier: {none}.
* Enter filename when prompted and save with .txt extension

### 2.7 File Format

janSQL works with plain text files that have the `.txt` extension¹ (to allow for quick opening in e.g. Notepad) and where data is separated by semi-colons. The first row of the file contains the field names.

The file format was choosen for easy export from Microsoft Access.

No quotes are used around text fields. You can not use the semi-colon character in data fields as it is used as the field seperator.²

### 2.8 Handling dates

Unlike most other database engines that have strong data typing, there are no data types in janSQL. Everything is stored as a string and in calculations converted ad-hoc to a number when applicable in the context.

To handle dates you must store them as a string in the ISO 8601 format:
```
YYYY-MM-DD
YYYY-MM-DDThh:mm:ss
```

A 4-digit year, followed by the 2-digit month number followed by the 2-digit day number. In your `WHERE` clauses you can then compare these string dates with each other. E.g. 1953-11-16 will be less than 2002-03-26.

```sql
SELECT * FROM users WHERE birthday>'1980-01-01'
```

Also the `ORDER BY` clause will produce correct results.

##### Handling times

In janSQL you store dates and times in seperate fields. This is a good idea for any DMBS that you use. It makes many queries so much easier and clearer.

In janSQL you store times as a string in the `hh:mm:ss` format:    
A 2-digit hour followed by a 2-digit minute value, followed by a 2-digit second value. Times are from '00:00:00' to '23:59:59'.

-----
**¹** This is changed to `.csv` in this new version in order to make it editable using any spreadsheet applications e.g. Microsoft Excel or Google Spreadsheet or iWork Numbers.

**²** This limitation had been removed in this new version of janSQL.

< [back to index](index.md) | [previous](1_about.md) | [next](3_demo.md) >
