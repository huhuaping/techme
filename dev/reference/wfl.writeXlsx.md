# Write out xlsx with the output file which the file name is specified year and prefix label

Write out xlsx with the output file which the file name is specified
year and prefix label

## Usage

``` r
wfl.writeXlsx(dt, file_source = file_xlsx, year_target, prefix_label = NULL)
```

## Arguments

- dt:

  data.frame. The data frame to write out.

- file_source:

  character. The path of the source file.

- year_target:

  numeric. The year to write out.

- prefix_label:

  character. The prefix label of the file name, default is NULL. Other
  value may be "funds", "ammount", etc.

## Examples

``` r
if (FALSE) { # \dontrun{
wfl.writeXlsx(
    dt = df_matched,
    file_source = "data-raw/df-matched.xlsx",
    year_target = 2019,
    prefix_label = "funds"
)
} # }
```
