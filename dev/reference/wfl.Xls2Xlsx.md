# Convert protected xls file to xlsx file, and remove unnecessary sheet. This function will remove the xls file permission protected by CNKI.

Convert protected xls file to xlsx file, and remove unnecessary sheet.
This function will remove the xls file permission protected by CNKI.

## Usage

``` r
wfl.Xls2Xlsx(file_path, sheet_drop = c("CNKI"))
```

## Arguments

- file_path:

  character. Path to the target xls file

- sheet_drop:

  character. Name of the sheet to drop

## Value

character. Path to the converted xlsx file

## Examples

``` r
if (FALSE) { # \dontrun{
wfl.Xls2Xlsx(
    file_path = "data-raw/example.xls",
    sheet_drop = c("CNKI")
)
} # }
```
