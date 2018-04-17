program janSQLcli;

{ /* **************************************************************************
  # janSQLcli is a console app to access .txt files data using janSQL library.
    janSQL library is required to compile this program.
  ************************************************************************** */ }

{$MODE OBJFPC}{$H+}{$J-}

uses
  SysUtils, janSQL;

var
  sampleDB: TjanSQL;
  quit: boolean = false;
  sqlResult: integer = 0;
  sqlCommand: string = '';

procedure printResult(resultIndex: integer);
var
  s: string;
  i,j: integer;
  row,col: integer;
  l: array of integer;
begin
  col := sampleDB.RecordSets[resultIndex].FieldCount;
  row := sampleDB.RecordSets[resultIndex].RecordCount;
  SetLength(l, col);

  // calculate column width
  for i := 0 to col-1 do
  begin
    // get the longest text
    l[i] := 0;
    for j := 0 to row-1 do
    begin
      s := sampleDB.RecordSets[resultIndex].Records[j].Fields[i].Value;
      if Length(s) > l[i] then l[i] := Length(s);
      if Length(s) > 99 then l[i] := 100;
    end;
    // print column title
    s := sampleDB.RecordSets[resultIndex].FieldNames[i];
    if Length(s) > l[i] then l[i] := Length(s);
    if Length(s) < l[i] then s := Format('%0:-'+IntToStr(l[i])+'s', [s]);
    if i < col-1 then write(s,' | ') else writeln(s);
  end;

  // print cell value
  for i := 0 to row-1 do
    for j := 0 to col-1 do
    begin
      s := sampleDB.RecordSets[resultIndex].Records[i].Fields[j].Value;
      if Length(s) > 99 then s := Copy(s, 1, 99) + '...'; // cut long text
      if Length(s) < l[j] then s := Format('%0:-'+IntToStr(l[j])+'s', [s]);
      if j < col-1 then write(s,' | ') else writeln(s);
    end;

  // print summary
  if row > 0 then
    writeln('Found: ',row,' record(s) with ',col,' field(s).')
  else
    writeln('No records found.')
end;

begin
  sampleDB := TjanSQL.Create;

  repeat
    // input query
    write('> ');
    readln(sqlCommand);
    quit := (LowerCase(Trim(sqlCommand)) = 'quit') or
            (LowerCase(Trim(sqlCommand)) = 'quit;');
    if quit then break;

    // execute query
    sqlResult := sampleDB.SQLDirect(sqlCommand);

    // check query result
    if sqlResult <> 0 then
    begin
      if sqlResult > 0 then
      begin
        writeln('SQL result:');
        printResult(sqlResult);

        // release recordset
        if not sampleDB.RecordSets[sqlResult].Intermediate then
          sampleDB.ReleaseRecordset(sqlResult);
      end
      else
        writeln('SQL executed.');
    end
    else
      writeln('ERROR: ',sampleDB.Error);
  until quit;

  writeln('OK');
  sampleDB.Free;
end.
