## code to prepare `wfl_useData_obsStation` dataset goes here

source("data-raw/deps/load-dev.R")
library(here)


# Workflow: get target directory and  files ----

## setting 1: data.frame of the directory collection from my data base----
## obtain the directory table by custom function `create.dirTable()`
# tbl_dir <- create.dirTable()
tbl_dir <- tribble(
  ~case, ~media, ~final,
  "PubObsStation", "data-raw/public-site/observe-station/", c("xlsx/")
)
View(tbl_dir)

## setting 2: specify the regex pattern for table identifier
## use the helper function `choose.filePattern()` to generate the pattern
prefix_add <- "^list-moa.+?2018.+?.xlsx$" # default is NULL, other value may be "amount", "funds", only used when mode is "add_onex", "add_one", "edited_one"
pattern_sel <- choose.filePattern(
  year = c(2021), # may have length 1 or 2
  mode = "custom", # must be one of the following: year_one, year_two, year_onex, year_twox, add_onex, add_one, edited_one, edited_two
  add_info = prefix_add # default is NULL, other value may be "amount", "funds", only used when mode is "add_onex", "add_one", "edited_one"
)

##  run the function to find target directory and files ----
find_result <- wfl.findFiles(
  dt = tbl_dir, # the directory table
  dir.case = "PubObsStation", # the case name of the target directory
  i.final = 1, # the index of the final subdirectory
  pattern = pattern_sel # the regex pattern for table identifier
)

(file_tar <- find_result$files) # the target file path
(dir_tar <- find_result$file_dir) # the target directory path

file.ext <- str_extract(file_tar, "\\.[^.]+$")

# Workflow: convert protected xls file to xlsx file----
## it should remove the unnecessary sheet (copyright or empty, or other sheet not needed).
is.unprotected <- TRUE
if (!is.unprotected & file.ext == ".xls") {
  ## the default is to remove the sheet named "CNKI"
  file_xlsx <- wfl.Xls2Xlsx(file_path = file_tar, sheet_drop = c("CNKI"))
} else if (is.unprotected & file.ext == ".xlsx") {
  file_xlsx <- file_tar
}
message(glue::glue("The target xlsx file is: {file_xlsx}"))

## setting 4ï¼?specify the target block list
## use the target list by `get.targetList()`
## this function is interactive, you can choose the target list from the console
# list_block <- get.targetList()
list_block <- list(
  block1 = "v99",
  block2 = "obstation",
  block3 = c("list")
)

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

## read the xlsx file
tbl_read <- openxlsx::read.xlsx(file_xlsx, sheet = 1, startRow = 1)

View(tbl_read)

## tidy the table
### institution should not be multiples, and should be extracted
### the only one which before "ã€? if there are multiple institutions
tbl_tidy <- tbl_read %>%
  mutate(
    institution_first = ifelse(
      str_detect(institution, "ã€?),
      str_extract(institution, "(.*?)(?=ã€?"),
      institution
    )
  ) %>%
  # rename the institution column and use the first institution name
  rename(
    institution_raw = institution,
    institution = institution_first
  )
View(tbl_tidy)

## match institution and get the province info
## use the helper function `wfl.queryInstituton()`
## this function will return a list of length 3
## containing the matched table, the unmatched table, and the number of unmatched records
tbl_match <- wfl.queryInstituton(
  dt = tbl_tidy # the data frame to be processed
)

### get the matched table and rename the institution column
tbl_province <- tbl_match$tbl_out %>%
  select(-institution) %>%
  rename(institution = institution_raw)

View(tbl_province)

### get the unmatched table if num_unmatched is greater than 0
### and then save the unmatched table to the "data-raw/data-tidy/hack-tianyan/ship/" directory
### use the custom function `wfl.write2ship()`
(num_unmatched <- tbl_match$num_unmatched)
if (num_unmatched > 0) {
  tbl_unmatched <- tbl_match$tbl_unmatched
  wfl.write2ship(
    dt = tbl_unmatched,
    date = Sys.Date() # change the date to the current date
  )
  message("The unmatched table has been written out to the ship directory")
} else {
  tbl_unmatched <- NULL
  message("The unmatched table is NULL, so the table will not be written out")
}


## workflow: query Tianyan and renew data set `queryTianyan`
## if tbl_unmatched is not NULL, the queryTianyan will be updated




## workflow: write out the matched table to tidy directory
## if the `province` column of tbl_province'  contains non NULL values
## use the custom function `wfl.write2tidy()`

if (any(!is.na(tbl_province$province))) {
  wfl.writeXlsx(
    dt = tbl_province,
    file_source = file_xlsx,
    year_target = 2018,
    prefix_label = "tidy-list-moa"
  )
  message("The matched table has been written out to the tidy directory")
} else {
  message("The `province` column of tbl_province contains  NULL values, so the table will not be written out")
}


# Workflow: use data----
## settings 1: directory and file pattern
dir_tidy <- str_replace(dir_tar, "data-raw/", "data-raw/data-tidy/")
file_ptn <- "^tidy-.+?\\.xlsx$"

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
# name_r <- paste0("tech-", name_dt, ".R")
(name_r <- paste0(str_replace(name_dt, "Pub", "Pub-"), ".R"))
path_r <- here::here("R", name_r)
file.exist <- file.exists(path_r)
use.r <- FALSE # default is FALSE, which means not the new-coming data set
if (file.exist) {
  message(glue::glue("The R file {name_r} already exists, so the file will not be created"))
} else {
  message(glue::glue("The R file {name_r} has not existed, so the file will be created"))
}

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

usethis::use_version(which = "dev")
