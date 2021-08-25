## code to prepare `wfl_editXls` dataset goes here

## code to prepare `unpivot_xls` dataset goes here
require(unpivotr)
library(XLConnect)
library(tidyverse)
#library(readxl)
library(glue)

#wb <- loadWorkbook(path_xls, create = TRUE)
wb <- XLConnect::loadWorkbook(file_unlocked_path, create = TRUE)
file_edited_path <- str_replace(file_unlocked_path, "unlocked", "edited")

# you should copy region or change cell values by hand
## create new sheet and save save change to xls
XLConnect::createSheet(wb, "add.sheet")
XLConnect::saveWorkbook(wb,file = file_edited_path )
#input <- tibble(myvalue="地 区") # must be data.frame
#writeWorksheet(wb, input, sheet = getSheets(wb)[1],
               #startRow = 3, startCol = 10)

# release the xls file permission
## see https://stackoverflow.com/questions/63279386/rstudio-holds-excelfile-permission-xlconnect
## XLConnect::xlcFreeMemory()
.rs.restartR()

Sys.sleep(1)

# check edited sheet
wb <- XLConnect::loadWorkbook(file_edited_path, create = TRUE)

# clear sheets
XLConnect::saveWorkbook(wb)
XLConnect::getSheets(wb)
XLConnect::removeSheet(wb,"CNKI")
## get the numbers of sheets. It should minus one to drop the last sheet contains only copyright informal .
sheetnum <- length(getSheets(wb))

i <- 1 # default the first sheet
dt_check <- XLConnect::readWorksheet(wb, sheet = i,header = F)

# release file permission again
.rs.restartR()
# usethis::use_data(wfl_editXls, overwrite = TRUE)

Sys.sleep(1)

print("OK! Edit the xlsx file finished!")
