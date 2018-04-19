# janSQL

JanSQL is a fast single user SQL engine for text-based files database. It's completely written in object Pascal language. Originally, it's created by Jan Verhoeven using Delphi. But then support for [Free Pascal](http://freepascal.org) compiler has been added by some contributors from the Free Pascal community. This is the latest modification done by Zlatko Matić based on Rene Tegel's version. Dependency on [Lazarus](http://lazarus-ide.org)' LCL or Delphi's VCL units also had been removed, so this version can be compiled using only object Pascal's standard units.

### janSQL "database" System

- *database* is a folder containing collection of text data files.
- *table* is a semicolon-delimited text file with .csv extension.
- *text field* is an optionally double/single-quoted text.
- *number field* is a numeric text with dot as decimal separator.

### Documentations

- Look into the `doc` folder for the (original) janSQL [help](doc/index.md).
- Look into the `db` folder for a janSQL database example.
- Look into the `samples.txt` file for some queries example.

In this repo, I also have added a simple janSQL console client program. It's mainly to test the SQL engine. Here's a brief video demo:

![janSQLcli](https://github.com/git-bee/janSQL/blob/master/janSQLcli_demo.gif)

### Contributions

JanSQL is still far from perfect. It still has many bugs and flaws, for sure. It also doesn't yet support many standard SQL features. We hope this library would be enhanced by the community so it can be a powerful full-featured lightweight SQL engine, similar to sqLite. So, if you're interested to contribute, feel free to fork and pull-request to this open source project. Thank you. :)
