# Add success footer information item to item for the figure or table

This function should be in the code chunk (always follow the code of
plot or kable) and without setting "result= 'asis'".

## Usage

``` r
add_footer_pure(text, type = "note")
```

## Arguments

- text:

  character, information text.

- type:

  character, is one of c('note', 'source') and default 'note'

## Value

invisible

## Examples

``` r
cap_note <- "This is a note, ba la ba la"
cap_source <- "source from yearbook 2021"
if (FALSE) { # \dontrun{
 add_footer_pure(cap_note)
 cat("\n")
 add_footer_pure(cap_source, type = "source")
} # }
```
