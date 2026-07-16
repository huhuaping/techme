# Export chunk plot to editable xlsx file

Export chunk plot to editable xlsx file

## Usage

``` r
gg2xlsx(p, dir = "pic/ggsave-xlsx", num_section = 2, num_fig, names_chunk)
```

## Arguments

- p:

  ggplot object.

- dir:

  character. relative dir path string

- num_section:

  integer. default 2

- num_fig:

  character.

- names_chunk:

  character. name of chunk, from which the plot generateed.

## Value

output xlsx file

## Examples

``` r
if (FALSE) { # \dontrun{
  p0 <- plot(1:10, 1:10)
  gg2xlsx(p = p0, dir="pic/ggsave-xlsx/",
        num_section = 5,num_fig = 2,
        names_chunk = "ggplot-chunk")
} # }
```
