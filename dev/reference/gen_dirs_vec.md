# Generate batch directories

Generate batch directories

Generate batch directories

## Usage

``` r
gen_dirs_vec(media, final)

gen_dirs_vec(media, final)
```

## Arguments

- media:

  character. First part of director path, with dash '/' at the end

- final:

  vector. Bundle of final directory name, without dash '/'.

## Examples

``` r
if (FALSE) { # \dontrun{
dir_final <- c("01-machine",
  "02-fertilizer",
  "03-plastic",
  "04-pesticide",
  "05-test")
  dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"

gen_dirs_vec(media = dir_media, final = dir_final)
} # }

if (FALSE) { # \dontrun{
dir_final <- c(
    "01-machine",
    "02-fertilizer",
    "03-plastic",
    "04-pesticide",
    "05-test"
)
dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"

gen_dirs_vec(media = dir_media, final = dir_final)
} # }
```
