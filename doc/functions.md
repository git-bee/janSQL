# 6 Functions

### 6.1 Functions

In janSQL you can use functions wherever you can use an expression to be calculated (calculated output fields, `WHERE` clause, `HAVING` clause).

Use extra brackets around function parameters when you have a function with more than one parameter:
```sql
SELECT trunc((userid/7),2) as foo FROM users
```
and not:
```sql
SELECT trunc(userid/7,2) as foo FROM users
```

##### Conversion

* `fix(expression,precision)`    

  Returns the string presentation of (numeric) `expression` with `precision` number of decimals.

  ```sql
  select fix((userid/7), 2) as bobo from users order by bobo
  ```
  You can also use `TRUNC` i.s.o. `FIX`.

* `asnumber(expression)`    

  Returns (number or string) `expression` as number. If expression is not a valid floating point number then the function returns 0.

### 6.2 FORMAT function

Formats a integer or floating point value to a string in a way specified by a format string.

Syntax:
```sql
format(value,formatstring)
```

Example:
```sql
update users set userid=format(userid,'%.8d')
```

Format strings have the following form:

`[literalstring]"%" [width] ["." prec] type`

* An optional `literalstring` that is copied to the output.
* An optional width specifier, `[width]`.
* An optional precision specifier, `["." prec]`.
* The conversion type character, `type`.

The following table summarizes the possible values for `type`:

##### d

Decimal. The argument must be an integer value. The value is converted to a string of decimal digits. If the format string contains a precision specifier, it indicates that the resulting string must contain at least the specified number of digits; if the value has less digits, the resulting string is left-padded with zeros.

##### u

Unsigned decimal. Similar to 'd' but no sign is output.

##### e

Scientific. The argument must be a floating-point value. The value is converted to a string of the form "-d.ddd...E+ddd". The resulting string starts with a minus sign if the number is negative. One digit always precedes the decimal point.The total number of digits in the resulting string (including the one before the decimal point) is given by the precision specifier in the format string—a default precision of 15 is assumed if no precision specifier is present. The "E" exponent character in the resulting string is always followed by a plus or minus sign and at least three digits.

##### f

Fixed. The argument must be a floating-point value. The value is converted to a string of the form "-ddd.ddd...". The resulting string starts with a minus sign if the number is negative.The number of digits after the decimal point is given by the precision specifier in the format string—a default of 2 decimal digits is assumed if no precision specifier is present.

##### g

General. The argument must be a floating-point value. The value is converted to the shortest possible decimal string using fixed or scientific format. The number of significant digits in the resulting string is given by the precision specifier in the format string—a default precision of 15 is assumed if no precision specifier is present.Trailing zeros are removed from the resulting string, and a decimal point appears only if necessary. The resulting string uses fixed point format if the number of digits to the left of the decimal point in the value is less than or equal to the specified precision, and if the value is greater than or equal to 0.00001. Otherwise the resulting string uses scientific format.

##### n

Number. The argument must be a floating-point value. The value is converted to a string of the form "-d,ddd,ddd.ddd...". The "n" format corresponds to the "f" format, except that the resulting string contains thousand separators.

##### m

Money. The argument must be a floating-point value. The value is converted to a string that represents a currency amount. The conversion is controlled by the `CurrencyString`, `CurrencyFormat`, `NegCurrFormat`, `ThousandSeparator`, `DecimalSeparator`, and `CurrencyDecimals` global variables, all of which are initialized from the Currency Format in the International section of the Windows Control Panel. If the format string contains a precision specifier, it overrides the value given by the `CurrencyDecimals global` variable.

###### s

String. The argument must be a string value. The string is inserted in place of the format specifier. The precision specifier, if present in the format string, specifies the maximum length of the resulting string. If the argument is a string that is longer than this maximum, the string is truncated.

##### x

Hexadecimal. The argument must be an integer value. The value is converted to a string of hexadecimal digits. If the format string contains a precision specifier, it indicates that the resulting string must contain at least the specified number of digits; if the value has fewer digits, the resulting string is left-padded with zeros.

### 6.3 Date functions

Several date functions make working with date strings easier.

##### YEAR

Extracts the integer year part of a `yyyy-mm-dd` date string.

##### MONTH

Extracts the integer month part of `yyyy-mm-dd` date string.

##### DAY

Extracts the integer day part of a `yyyy-mm-dd` date string.

##### WEEKNUMBER

Returns the integer weeknumber of a `yyyy-mm-dd` date string.

##### EASTER

Returns the easter `yyyy-mm-dd` date string of a given integer year.

##### DATEADD

Adds a given number of time intervals to a given data and returns the resulting data as a `yyyy-mm-dd` data string.

Syntax: `DATEADD(interval, number, datestring)`

`interval` can be: 'd' (day), 'm' (month), 'y' (year), 'w' (week), 'q' (quarter).    
`number` must be an integer number.    
`datestring` must be in the `yyyy-mm-dd` format.

### 6.4 String Functions

janSQL comes with a range of functions that work on strings.

##### soundex(expression)

Calculates the soundex value of (string) `expression`. Only usefull with english terms.

##### lower(expression)

Converts (string) `expression` to lower case.

##### upper(expression)

Converts (string) `expression` to upper case.

##### trim(expression)

Trims (string) `expression` from leading and trailing spaces.

##### left(expression,count)

Returns the first `count` characters of `expression`.

##### right(expression,count)

Returns the last `count` characters of `expression`

##### mid(expression,from,count)

Returns `count` characters of `expression` starting at `from`.

##### length(expression)

Returns the length of (string) `expression`. Can be used to e.g. select fields that exceed a given length.

##### replace(source, oldpattern, newpattern)

Replaces `oldpattern` with `newpattern` in the `source` string. It's case-insensitive.

Example: `UPDATE users SET username=replace(username,'user-','foo-')`

##### substr_after(source,substring)

Returns the part of `source` that comes after `substring`. If `substring` is not found, an empty string is returned.

##### substr_before(source,substring)

Returns the part of `source` that comes before `substring`. If `substring` is not found, an empty string is returned.

### 6.5 Numeric Functions

Numeric functions work on strings as if they were numbers. Although janSQL is based on strings you can still enter values like `1234`, which can be treated like numbers.

##### sqr(expression)

Calculates the square of (numeric) `expression`.

##### sqrt(expression)

Calculates the square root of (numeric) `expression`.

##### sin(expression)

Calculates the sin of (numeric) `expression`.

##### cos(expression)

Calculates the cos of (numeric) `expression`.

##### ceil(expression)

Returns the lowest integer greater than or equal to (numeric) `expression`.

##### floor(expression)

Returns the the highest integer less than or equal to (numeric) `expression`.
