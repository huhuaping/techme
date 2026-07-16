# Convert xls to xlsx

Convert xls to xlsx

## Usage

``` r
convert_xls_as_xlsx(
  input_dir,
  export_dir = tempdir(),
  office_folder = safe_office_folder(),
  dbg = TRUE
)
```

## Arguments

- input_dir:

  input directory containing .xls files

- export_dir:

  export directory (default: tempdir())

- office_folder:

  office folder path (default: `safe_office_folder`)

- dbg:

  debug (default: TRUE)

## Examples

``` r
if (FALSE) convert_xls_as_xlsx(input_dir = "d:/temp/", export_dir = "d:/temp/") # \dontrun{}
```
