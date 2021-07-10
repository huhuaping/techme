## code to prepare `wfl_unlocked` dataset goes here

# remove sheet protection in Excel
# Sample file: https://www.dropbox.com/s/4ul0kowrscyr8cz/excel_protected.xlsx?dl=0

library(stringr)
#install.packages("zip")
library(zip)

# you should firstly "save as" locked .xls to .xlsx format manually.

# file with protected sheets
file <- str_replace(basename(file_xls), ".xls", ".xlsx")
file_locked_path <- glue::glue("{dir_sel}/{file}")

# file name and path after removing protection
file_unlocked <- str_replace(basename(file), ".xlsx$", "-unlocked.xlsx")
#file_unlocked_path <- glue::glue("{dir_sel}/{file_unlocked}")
file_unlocked_path <- file.path(getwd(),dir_sel,file_unlocked)

# create temporary directory in project folder
# so we see what is going on
temp_dir <- "data-raw/_tmp"

# remove and recreate _tmp folder in case it already exists
unlink(temp_dir, recursive = T)
dir.create(temp_dir)

# unzip Excel file into temp folder
unzip(file_locked_path, exdir = temp_dir)

# get full path to XML files for all worksheets
worksheet_paths <- list.files(
  paste0(temp_dir, "/xl/worksheets"),
  full.name = TRUE,
  pattern = ".xml")

# remove the XML node which contains the sheet protection
# We might of course use e.g. xml2 to parse the XML file, but this simple approach will suffice here
for (ws in worksheet_paths) {
  x <- readLines(ws, encoding = "windows1")
  # the "sheetProtection" node contains the hashed password "<sheetProtection SOME INFO />"
  # we simply remove the whole node
  out <- str_replace(x, "<sheetProtection.*?/>", "")
  writeLines(out, ws)
}

# create a new zip, i.e. Excel file, containing the modified XML files
old_wd <- setwd(temp_dir)
f <- list.files(recursive = T, full.names = F, all.files = T, no..=T)
# as the Excel file is a zip file, we can directly replace the .zip extension by .xlsx
zip::zip(file_unlocked_path, files = f) # utils::zip does not work for some reason
setwd(old_wd)

# clean up and remove temporary directory
unlink(temp_dir, recursive = T)


# usethis::use_data(wfl_unlocked, overwrite = TRUE)
