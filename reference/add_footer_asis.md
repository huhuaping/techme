# Add success footer information as whole part for the figure or table

This function should be in the dependent code chunk (outside the code
chunk of plot or kable) and must set the chunk options "result= 'asis'".

## Usage

``` r
add_footer_asis(note, source, pre_note = "注")
```

## Arguments

- note:

  character, note text for figure or table.

- source:

  character, source text for figure or table.

- pre_note:

  character, prefix for note with default value.

## Value

invisible

## Examples

``` r

cap_note <- "This is a note, ba la ba la"
cap_source <- "source from yearbook 2021"
if (FALSE) { # \dontrun{
 add_footer_asis(cap_note, cap_source)
} # }
```
