# Workflow Functions: find files

Internal functions for handling various workflow tasks in the techme
package.

This function creates a directory table that maps case names to their
corresponding directory paths and subdirectories. The table is used to
organize and locate data files in the package's data structure.#'

This function generates regex patterns for matching specific file names
based on year, file format, and additional information. It supports
various naming patterns for raw data files and edited files.

## Usage

``` r
create.dirTable()

choose.filePattern(year, mode, add_info)

wfl.findFiles(dt, dir.case, i.final, pattern)
```

## Arguments

- year:

  numeric or numeric vector. The year(s) to include in the pattern. If a
  vector of length 2 is provided, it represents a year range.

- mode:

  character. The pattern mode to use. Must be one of:

  - `year_one`: Single year, xls format, eg. "^raw-2023.xls\$"

  - `year_two`: Two years, xls format, eg. "^raw-2022-2023.xls\$"

  - `year_onex`: Single year, xlsx format, eg. "^raw-2023.xlsx\$"

  - `year_twox`: Two years, xlsx format, eg. "^raw-2022-2023.xlsx\$"

  - `add_onex`: Single year with additional info, xlsx format, eg.
    "^raw-.+?amount-2023.xlsx\$"

  - `add_one`: Single year with additional info, xls format, eg.
    "^raw-.+?amount-2023.xls\$"

  - `edited_one`: Single year with additional info, edited xlsx format,
    eg. "^raw-.+?amount-2023-edited.xlsx\$"

  - `edited_two`: Two years, edited xlsx format, eg.
    "^raw-2022-2023-edited.xlsx\$"

  - `custom`: Custom pattern, eg. "^raw-.+?amount-2023.xlsx\$". Note:
    when mode is "custom", add_info must be a character string and year
    argument is not used.

- add_info:

  character. Additional information to include in the pattern.

- dt:

  data.frame. Which must be contain "case", "media", "final" column.

- dir.case:

  character. The case name to search for files. Must one of the value of
  the "case" column in the data.frame.

- i.final:

  number. The index of the final directory in the "final" column.

- pattern:

  character. Pattern to match files

## Value

tibble. A tibble containing the directory structure with columns:

- `case` (character): Case identifier

- `media` (character): Main directory path

- `final` (list): Vector of subdirectory names

character. A regex pattern string for matching file names.

list of file paths and directory path

## Details

This file contains a collection of internal functions for:

- function `create.dirTable()`: create directory table with case, media,
  final column

- function `choose.filePattern()`: choose the file pattern based on
  year, mode, and add_info

- function `wfl.findFiles()`: find files based on directory table, case,
  final index, and pattern

The function returns a tibble with three columns:

- `case`: The case identifier (e.g., "agri_prod", "budget")

- `media`: The main directory path for the case

- `final`: A list of subdirectories for the case

## Examples

``` r
if (FALSE) { # \dontrun{
# Get the directory table
tbl_dir <- create.dirTable()

# View the structure
str(tbl_dir)

# Access specific case
tbl_dir[tbl_dir$case == "agri_prod", ]
} # }

if (FALSE) { # \dontrun{
# Single year pattern
choose.filePattern(year = 2022, mode = "year_onex")

# Year range pattern
choose.filePattern(year = c(2022, 2023), mode = "year_twox")

# Pattern with additional info
choose.filePattern(
    year = 2022,
    mode = "add_onex",
    add_info = "amount"
)
} # }

if (FALSE) { # \dontrun{
find_result <- wfl.findFiles(
    dt = tbl_dir, # the directory table
    dir.case = "agri_prod", # the case name of the target directory
    i.final = 1, # the index of the final subdirectory
    pattern = pattern_sel # the regex pattern for table identifier
)
} # }
```
