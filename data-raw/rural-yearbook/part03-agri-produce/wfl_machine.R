require(devtools)
load_all()
library(here)

dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"
dir_final <- c("01-machine", "02-fertilizer", "03-plastic", "04-pesticide")

i_sel <- 1
dir_tar <- paste0(dir_media, dir_final[i_sel], "/")
pattern_sel <- "^raw-2021-2022-unlocked.xlsx$"
pattern_sel <- "^raw-2022-2023.xlsx$"

# find target file ----
file_tar <- wfl.findFiles(directory = dir_tar, pattern = pattern_sel)

# convert protected xls file to xlsx file, and remove unnecessary sheet
# file_xlsx <- wfl.Xls2Xlsx(file_path = file_tar, sheet_drop = c("CNKI"))
file_xlsx <- file_tar

# unpivot xlsx file ----
## setting 1： whether drop columns and specify the header mode.
## cols_drop <- c(2)
cols_drop <- NULL

## setting 2： choose header mode
## change mode on conditions if needed in `wfl_unpivot_livestock.R`
header_mode <- c(
    "year", "vars", "vars-year", "vars-vars",
    "vars-h3", "vars-h4", "vars-h5"
)
mode_sel <- header_mode[3]

## setting 3： specify the regex pattern for table identifier
# pattern_table <- "^地.*区" # not to use "续表" !

## setting 4： specify the extra chinese variable list
## this only used when header mode is "year"
list_block <- list(block1 = "v7", block2 = "sctj", block3 = c("nyjx"))
vars_spc <- get_vars(
    df = varsList, lang = "eng",
    block = list_block,
    what = "chn_block4"
)


## Now begin loop unpivot xlsx file
df_out <- wfl.unpivotXlsx(
    file = file_xlsx,
    header.mode = mode_sel, # default is "vars-year"
    vars.add = NULL, # default is NULL
    cols.drop = cols_drop, # default is NULL
    pattern.table = "^地.*区", # default is "^地.*区"
    reg_start = "^地.*区", # getRange() argument
    reg_end = "^新.*疆", # getRange() argument
    unit_pattern = "单位:|单位：" # getInfo() argument
)

View(df_out)

# tidy unpivoted table from xlsx file ----
df_tidy <- wfl.tidyTable(dt = df_out) %>%
    select(
        province, year,
        vars, value, units
    )

View(df_tidy)

# match and check variables names to the varsList ----
## Match variables names to the varsList ----
## prepare setting: target search

df_vars_matched <- wfl.matchVars(
    dt = df_tidy,
    block_target = list_block, # see before
    block_lang = "eng" # default value is "eng"
)

View(df_vars_matched)

## check the raw variables names in the varsList ----
vars_raw <- get_vars(
    varsList,
    lang = "eng",
    block = list_block,
    what = "chn_block4"
)

## Tidy table again and replace variables names if needed ----
## replace unconsistent variables names
ptn <- c("谷物联合收割机")
rpl <- c("联合收获机")

df_tidy <- df_tidy %>%
    mutate(vars = mgsub::mgsub(vars, ptn, rpl))

View(df_tidy)

## rerun the variable matching function and check again
df_vars_matched_check <- wfl.matchVars(
    dt = df_tidy,
    block_target = list_block,
    block_lang = "eng" # default value is "eng"
)

is.unmatched <- any(df_vars_matched_check$asis == FALSE)
if (is.unmatched) {
    message("Warning: Some variables names are not matched to the varsList. Please check the variables names and the varsList.")
} else {
    message("Good news: All variables names are matched to the varsList.")
}

# left join the tidy table with the matched unified variables table ----
## add variables names to the tidy table
df_add_vars <- wfl.addVars(
    dt_left = df_tidy,
    dt_right = df_vars_matched_check
)

View(df_add_vars)

# write out xlsx file ----
## you can see the interactive confirmation in the console

wfl.writeXlsx(
    dt = df_add_vars,
    file_source = file_xlsx,
    year_target = c(2023),
    prefix_label = NULL # default is NULL, other value may be "funds", "ammount", etc.
)
