# Workflow Functions: match variables

Internal functions for handling various workflow tasks in the techme
package.

This function provides an interactive way to select a target list from a
predefined collection used for filtering and organizing data in the
package. The lists are organized by different categories (v4, v6, v7,
v8) and contain block identifiers for data filtering.

This function retrieves variable names from a basic variables table
based on specified language and block criteria. It supports filtering
variables by hierarchical block structure in both English and Chinese.

## Usage

``` r
get.targetList()

get.vars(df, lang = "eng", block, what = "variables")

get.best.match(word, charvec)

wfl.matchVars(dt, block_target, block_lang = "eng")
```

## Arguments

- df:

  data.frame. The input data frame containing variable information.

- lang:

  character. The language of variables to select. Must be either "eng"
  (default) or "chn".

- block:

  list. A list which the length is not greater than 4 with names
  "block1", "block2", "block3", "block4". Each element contains the
  block identifiers to filter by. Note that block4 is optional.

- what:

  character. The type of variable names to return. Options include:

  - "variables" (default): Full variable names

  - "short_chn": Short Chinese names

  - "short_eng": Short English names

  - "chn_block4": Chinese block4 names

  - "eng_block4": English block4 names

  - other: other variable names in the input data frame (typically
    `varList`)

- word:

  character. The word to match.

- charvec:

  character vector. The vector of words to match against.

- dt:

  data.frame. The input data frame containing a 'vars' column.

- block_target:

  list. Names of the list should be part or all of: block1, block2,
  block3, block4.

- block_lang:

  character. Specify which language to use, either 'eng'(default) or
  'chn'.

## Value

list. List of target list with block identifiers.

data.frame. A data frame containing the filtered variable names.

character. The best matched word from charvec.

data.frame. A data frame containing the matched variables.

## Details

This file contains a collection of internal functions for:

- function `get.targetList()`: get the target list

- function `get.vars()`: get the variables from the package data
  `varsList`

- function `get.best.match()`: get the best match

- function `wfl.matchVars()`: match the variables with the tidy
  data.frame

The target lists are organized into several categories:

- v4: Research and Development related lists (RDnbs, RDinner, RDfirm,
  etc.)

- v6: Budget related lists

- v7: Agricultural production related lists (machine, fertilizer,
  plastic, pesticide)

- v8: Livestock related lists (t1-t9)

Each list contains block identifiers (block1, block2, block3) used for
filtering data.

The function filters variables based on a hierarchical block structure
(block1-4) and returns the specified variable names. It supports both
English and Chinese variable names through the language parameter. The
block4 parameter is optional in the block list.

## Examples

``` r
if (FALSE) { # \dontrun{
# Interactive selection of target list
target_list <- get.targetList()
} # }

if (FALSE) { # \dontrun{
options(encoding = "UTF-8")
block_sel <- list(
    block1 = "v7",
    block2 = "sctj",
    block3 = "nyjx"
)

vars_set <- get.vars(df = varsList, block = block_sel, what = "variables")
} # }

if (FALSE) { # \dontrun{
get.best.match(
    "\u519c\u4e1a\u673a\u68b0",
    c(
        "\u519c\u4e1a\u673a\u68b0",
        "\u519c\u4e1a\u673a\u68b0\u603b\u52a8\u529b"
    )
)
} # }

if (FALSE) { # \dontrun{
target <- list(block1 = "v7", block2 = "sctj", block3 = "nyjx")
df_vars_matched <- wfl.matchVars(dt = df_tidy, block_target = target)
} # }
```
