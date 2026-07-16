# Workflow Functions: unpivot all tables in the xlsx file

Internal functions for handling various workflow tasks in the techme
package.

## Usage

``` r
getRange(dt, ith, what, reg_start, reg_end)

unpivot(dt, rows, cols, cols.drop = NULL, header.mode, vars.add = NULL)

getInfo(dt, unit_pattern)

wfl.unpivotXlsx(
  file,
  header.mode = "vars-year",
  vars.add = NULL,
  cols.drop = NULL,
  pattern.table,
  reg_start,
  reg_end,
  unit_pattern
)
```

## Arguments

- dt:

  data.frame. Should be characterer the type of pivot table.

- ith:

  number. when exist multiple table region in one sheet.

- what:

  character. What is the object function will return, whether "row" or
  "col".

- reg_start:

  character. regex pattern for start identifier.

- reg_end:

  character. regex pattern for end identifier.

- rows:

  vector. Target rows of the region contains pivot table.

- cols:

  vector. Target cols of the region contains pivot table.

- cols.drop:

  vector. Columns numbers which will be dropped, default `NULL`.

- header.mode:

  character. One of the four options: 'vars-year', 'vars',
  'vars-vars','year'

- vars.add:

  character. if header.mode = 'year', then the vars.add must be
  specified, And you can use the function
  [`get_vars()`](https://huhuaping.github.io/techme/dev/reference/get_vars.md)
  to get the variable name.

- file:

  character. Path to the xlsx file.

- pattern.table:

  character. Regex pattern for table identifier.

## Value

vector

data.frame

vector. A character vector containing the unit information.

data.frame. A data frame containing the unpivoted data with units
information.

## Details

This file contains a collection of internal functions for:

- function `getRange()`: get the range of the pivot table in the xlsx
  file

- function `unpivot()`: unpivot the xlsx file

- function `getInfo()`: get the information of the xlsx file

- function `wfl.unpivotXlsx()`: unpivot the xlsx file

This function is used to get the range of the pivot table in the xlsx
file. The pivot table is identified by the regex pattern for start and
end identifier. The function will return the row and column range of the
target pivot table. Note 1: there may be only one table or multiple
tables in the sheet Note 2: when there are multiple tables, these
table's alignment may be horizontal or vertical Note 3: We only assume
the only multiple table's alignment is horizontal or vertical, not
hybrid alignment.

This function is used to loop unpivot all the sheets in the xlsx file.
It will call three internal functions respectively:

1.  getRange(): to get the range of the pivot table in the xlsx file.

2.  unpivot(): to unpivot the pivot table in the xlsx file.

3.  getInfo(): to get the unit information of the pivot table in the
    xlsx file. Keep in mind that a sheet may contains multiple pivot
    tables. Note 1: there may be only one table or multiple tables in
    the sheet Note 2: when there are multiple tables, these table's
    alignment may be horizontal or vertical Note 3: We only assume the
    only multiple table's alignment is horizontal or vertical, not
    hybrid alignment.

## Examples

``` r
if (FALSE) { # \dontrun{
wb <- loadWorkbook(path_xls, create = TRUE)
dt <- readWorksheet(wb, sheet = 1, header = F) %>%
    select_if(~ !all(is.na(.)))
i <- 2
myrows <- getRange(dt, ith = i, what = "row")
mycols <- getRange(dt, ith = i, what = "col")
} # }

if (FALSE) { # \dontrun{
wb <- loadWorkbook(path_xls, create = TRUE)
dt <- readWorksheet(wb, sheet = 1, header = F) %>%
    select_if(~ !all(is.na(.)))
i <- 1
myrows <- getRange(dt, ith = i, what = "row")
mycols <- getRange(dt, ith = i, what = "col")
cols_drop <- c(2)
header_mode <- c("vars", "vars-vars")
vars_spc <- get_vars(
    df = varsList, lang = "eng",
    block = list(
        block1 = "v4",
        block2 = "zh",
        block3 = "qd",
        block4 = "RD"
    ),
    what = "chn_block4"
)

tbl_raw <- unpivot(dt,
    cols = mycols, rows = myrows,
    cols.drop = cols_drop,
    header.mode = header_mode[i],
    vars.add = vars_spc
)
} # }

if (FALSE) { # \dontrun{
same_units <- getInfo(dt)
} # }

if (FALSE) { # \dontrun{
wfl.unpivot_xlsx(
    file = "data-raw/example.xlsx",
    header.mode = "vars-year",
    cols.drop = NULL,
    pattern.table = "^\\u5730.*\\u533a"
)
} # }
```
