# Workflow Functions: add variables to the data.frame

Internal functions for handling various workflow tasks in the techme
package.

This function provides an interactive way to select a collection of
Chinese text patterns and their replacements for standardizing variable
names in the tidy table. It supports various categories including
agricultural machinery, fertilizer, plastic, budget, R&D, and livestock
data.

## Usage

``` r
get.chnPattern()

wfl.addVars(dt_left, dt_right)
```

## Arguments

- dt_left:

  data.frame. The tidy unpivot table.

- dt_right:

  data.frame. The matched variables table and should be checked.

## Value

list or NULL. A list containing:

- ptn: The pattern(s) to match

- rpl: The replacement(s) for the pattern(s)

- tbl_pattern: The full pattern-replacement table

Returns NULL if option 0 is selected.

data.frame. A data frame containing the joined and processed data.

## Details

This file contains a collection of internal functions for:

- function `get.chnPattern()`: get the pattern for Chinese variables

- function `wfl.addVars()`: add the variables to the data.frame

The function maintains a predefined table of patterns and replacements
for different categories of data. Each category may have multiple
patterns and corresponding replacements. The table is soft-coded in the
package and can be modified as needed.

## Examples

``` r
if (FALSE) { # \dontrun{
# Interactive selection of pattern-replacement pairs
patterns <- get.chnPattern()
} # }

if (FALSE) { # \dontrun{
df_matched <- wfl.addVars(dt_left = df_tidy, dt_right = vars_matched)
} # }
```
