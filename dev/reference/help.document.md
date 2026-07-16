# Help Document the Variables List of Data Set for Package Development

This function generates documentation template for data frame variables
in Roxygen2 format. It creates a list of variable entries that can be
used in the `@format` section of data documentation.

## Usage

``` r
help.document(df)
```

## Arguments

- df:

  data.frame. The data frame to document.

## Value

NULL. The function prints the documentation template to the console.

## Details

The function takes a data frame as input and generates documentation
entries for each variable in the format required by Roxygen2. This is
particularly useful when documenting datasets in R packages.

## Examples

``` r
if (FALSE) { # \dontrun{
data(ProvinceCity)
help.document(ProvinceCity)
} # }
```
