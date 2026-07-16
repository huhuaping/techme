# Workflow Functions: use data

Internal functions for handling various workflow tasks in the techme
package.

This function provides an interactive way to select a data name from a
predefined list. It displays all available options and allows the user
to choose by entering a number.

## Usage

``` r
choose.nameData()

wfl.useData(
  directory.source,
  file.pattern,
  name.dt,
  which.dt = "df_use",
  character.cols = NULL
)
```

## Arguments

- directory.source:

  character. The path of the source xlsx files.

- file.pattern:

  character. The pattern of the file name.

- name.dt:

  character. The name of the data frame. And the name has uniform format
  style as "AgriMachine", "LivestockBreeding", etc.

- which.dt:

  character. The name of the data frame to use, default is "df_use".

- character.cols:

  character. The columns to be converted to character, default is NULL.

## Value

character or NULL. The selected data name from the list, or NULL if
option 0 is selected.

## Details

This file contains a collection of internal functions for:

- function `choose.nameData()`: choose the name of `use_data()`

- function `wfl.useData()`: use the data with `use_data()`

## Examples

``` r
if (FALSE) { # \dontrun{
# Interactive selection of data name
selected_name <- choose.nameData()
} # }

if (FALSE) { # \dontrun{
wfl.useData(
    directory.source = "data-raw/data-tidy/",
    file.pattern = "\\d{4}",
    name.dt = "AgriMachine",
    which.dt = "df_use"
)
} # }
```
