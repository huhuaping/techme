# Get names from basic variables table

Get names from basic variables table

## Usage

``` r
get_vars(df, lang = "eng", block, what = "variables")
```

## Arguments

- df:

  data frame

- lang:

  characer. Which is the language of variables selected, default "eng",
  other options is "chn".

- block:

  list. The list must be length 4, with its names following:
  "block1","block2", "block3", "block4".

- what:

  character. The options are including:
  "variables"(default),"short_chn", "short_eng"

## Value

list

## Examples

``` r
options(encoding = "UTF-8")
block_sel <- list(block1 ="v7",
block2="sctj",
block3 ="nyjx",
block4= c("zdl","dztlj","xtlj",
"dztlj_pt","xtlj_pt",
"pgddj","pgcyj"))

vars_set <-  get_vars(df = varsList, block = block_sel, what = "variables")
```
