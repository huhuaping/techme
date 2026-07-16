# Query Institution Information and Match Province

This internal function matches institution names with their
corresponding provinces using two matching strategies:

- Direct matching with the `queryTianyan` dataset

- Pattern matching using province and city information from
  `ProvinceCity` dataset

This internal function writes unmatched institutions to a specific
directory for further manual processing. The output file is named with
the pattern "ship-tot`number`-`date`.xlsx", where number is
automatically calculated from the input data frame.

## Usage

``` r
wfl.queryInstituton(dt)

wfl.write2ship(dt, date)
```

## Arguments

- dt:

  A data frame containing unmatched institutions with two columns:

  - index: A numeric column for row identification

  - institution: A character column containing institution names

- date:

  A character string representing the current date in YYYY-MM-DD format

## Value

A list containing:

- tbl_out: A data frame with the original data plus a new 'province'
  column

- tbl_unmatched: A data frame of unmatched institutions (if any)

- num_unmatched: Number of unmatched institutions

NULL (invisible)

## Details

The function performs the following operations:

- First attempts to match institution names with the `queryTianyan`
  dataset

- For unmatched records, extracts province information using regex
  patterns

- For remaining unmatched records, attempts to match city names and
  derive province

- Returns a list containing the matched data and information about
  unmatched records

The function performs the following operations:

- Validates input parameters for data frame and date

- Calculates the number of unmatched institutions from the input data

- Creates the ship directory if it doesn't exist

- Writes the unmatched institutions to an Excel file

- Provides feedback about the file location

## Examples

``` r
if (FALSE) { # \dontrun{
# Example usage
dt <- data.frame(institution = c("Example Corp", "Test Company"))
result <- wfl.queryInstituton(dt)
} # }
if (FALSE) { # \dontrun{
# Example usage
dt <- data.frame(
    index = 1:2,
    institution = c("Example Corp", "Test Company")
)
wfl.write2ship(dt, date = "2025-06-06")
} # }
```
