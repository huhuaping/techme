require(devtools)
load_all()
library(here)

# Workflow: get target directory and  files ----

## setting 1: data.frame of the directory collection from my data base----
## obtain the directory table by custom function `create.dirTable()`
tbl_dir <- create.dirTable()
View(tbl_dir)

## setting 2: specify the regex pattern for table identifier
## use the helper function `choose.filePattern()` to generate the pattern
pattern_sel <- choose.filePattern(
    year = c(2022, 2023), # may have length 1 or 2
    mode = "year_twox", # must be one of the following: year_one, year_two, year_onex, year_twox, add_onex, add_one, edited_one, edited_two
    add_info = NULL # eg "amount", "funds", only used when mode is "add_onex", "add_one", "edited_one"
)

##  run the function to find target directory and files ----
find_result <- wfl.findFiles(
    dt = tbl_dir, # the directory table
    dir.case = "agri_prod", # the case name of the target directory
    i.final = 1, # the index of the final subdirectory
    pattern = pattern_sel # the regex pattern for table identifier
)

file_tar <- find_result$files # the target file path
dir_tar <- find_result$file_dir # the target directory path

# Workflow: convert protected xls file to xlsx file----
## it should remove the unnecessary sheet (copyright or empty, or other sheet not needed).
is.unprotected <- TRUE
if (!is.unprotected) {
    ## the default is to remove the sheet named "CNKI"
    file_xlsx <- wfl.Xls2Xlsx(file_path = file_tar, sheet_drop = c("CNKI"))
} else {
    file_xlsx <- file_tar
}
message(glue::glue("The target xlsx file is: {file_xlsx}"))

# Workflow: unpivot xlsx file ----
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
## use the target list by `get.targetList()`
list_block <- get.targetList(
    identifier = "v7_machine",
    show.all.identifier = FALSE # whether show all available identifier, default is FALSE
) %>%
    .[["out_list"]] # only get the target list

## setting 5: prepare the additional variable names if needed
## this is only used when header mode is "year"
## the `get.vars()` is a custom internal function in the `techme` package
## attention we also have exported `get_vars()` in the `techme` package
vars_spc <- get.vars(
    df = varsList, # the `varsList` data set in the package
    lang = "eng",
    block = list_block, # you can use the target list by `get.targetList()`
    what = "chn_block4"
)

## Now begin loop unpivot xlsx file
df_out <- wfl.unpivotXlsx(
    file = file_xlsx,
    header.mode = mode_sel, # default is "vars-year"
    vars.add = NULL, # default is NULL, only used when header mode is "year"
    cols.drop = cols_drop, # default is NULL
    pattern.table = "^地.*区", # default is "^地.*区"
    reg_start = "^地.*区", # getRange() argument
    reg_end = "^新.*疆", # getRange() argument
    unit_pattern = "单位:|单位：" # getInfo() argument
)

View(df_out)

# Workflow: tidy unpivoted table from xlsx file ----

df_tidy <- wfl.tidyTable(dt = df_out) %>%
    select(
        province, year,
        vars, value, units
    )

View(df_tidy)

# Workflow: match and check variables names to the varsList ----

## Match variables names to the varsList ----
## prepare setting: target search

df_vars_matched <- wfl.matchVars(
    dt = df_tidy,
    block_target = list_block, # see before
    block_lang = "eng" # default value is "eng"
)

View(df_vars_matched)

## check the raw variables names in the varsList ----
vars_spc # see before

## Replace chinese variables names if needed ----
## replace unconsistent variables names

## get the pattern and replacement using the helper function `choose.chnPattern()`
## this function is soft-coded in the package, you can change the pattern and replacement as you need
mycase <- "machine"
chn_pairs <- choose.chnPattern(mycase)
ptn <- chn_pairs$ptn
rpl <- chn_pairs$rpl

## now replace the variables names
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

# Workflow: add variables names to the tidy table ----
## left join the tidy table with the matched unified variables table
df_add_vars <- wfl.addVars(
    dt_left = df_tidy,
    dt_right = df_vars_matched_check
)

View(df_add_vars)

# Workflow: write out xlsx file ----

## you can see the interactive confirmation in the console

wfl.writeXlsx(
    dt = df_add_vars,
    file_source = file_xlsx,
    year_target = c(2023),
    prefix_label = NULL # default is NULL, other value may be "funds", "ammount", etc.
)

# Workflow: use data----
## settings 1: directory and file pattern
dir_tidy <- str_replace(dir_tar, "data-raw/", "data-raw/data-tidy/")
file_ptn <- "\\.xlsx$"

## settings 2: data name
## use the helper function `choose.nameData()` to select the data name
## this function is interactive, you can choose the data name from the console
name_dt <- choose.nameData()

## now run the function
## attention the output message in the console !
## this function will firstly loop read all xlsx files in the directory
## then it will check the data set and the units data set
## and finally it will write out the data set by `use_data()`
wfl.useData(
    directory.source = dir_tidy,
    file.pattern = file_ptn, # xlsx file name pattern
    name.dt = name_dt, # data name for use_data()
    which.dt = "df_use" # default is "df_use", other value is "df_units"
)

## Check and view the data by `do.call()`
load_all() # must refresh and load the package again
do.call("View", list(as.name(name_dt)))


# Workflow: use_r for new-coming data set----

## generate the name for R file
## we have custom name format style as following:
## - "tech-{name_dt}.R" such as "tech-AgriMachine.R"
## - "Pub{name_dt}.R" such as "PubFreshKeepCounty.R"
name_r <- paste0("tech-", name_dt, ".R")

## default is FALSE, which means not the new-coming data set
new_coming <- FALSE
if (new_coming) {
    use_r(name_r)
}

# write or update the data set document----
## use my custom function to help writing document

## default is FALSE, which means the column names of the data set is not modified
is_modified <- FALSE
if (is_modified) {
    do.call("document_dt", list(as.name(name_dt)))
}

## always update document
document()
