## code to prepare `wfl_workbook` dataset goes here

## code to prepare `unpivot_xls` dataset goes here
require(unpivotr)
library(XLConnect)
library(tidyverse)
library(readxl)
library(glue)



wb <- loadWorkbook(path_xls, create = TRUE)

getSheets(wb)
removeSheet(wb,"CNKI")
# get the numbers of sheets. It should minus one to drop the last sheet contains only copyright informal .
sheetnum <- length(getSheets(wb))

# save xls
file_unlocked <- str_replace(basename(file_xls), ".xlsx$", "-saved.xlsx")
file_unlocked_path <- glue::glue("{file_dir[2]}/{file_unlocked}")
saveWorkbook (wb, file_unlocked_path)

i <- 2
dt_check <- readWorksheet(wb, sheet = i,header = F)

fml <- paste0("地 区")
setCellFormula(object = wb,sheet = i,
               row = 3,col = 1,
               formula = fml)

library(xlsx)

wb <- openxlsx::loadWorkbook(path_xls)
openxlsx::getSheetNames(path_xls)
openxlsx::removeWorksheet(wb,"CNKI")
openxlsx::writeData(wb, sheet = i, x = "fml", xy = c(3,1))
openxlsx::saveWorkbook(wb,file_unlocked_path)
i <- 2
dt_check <- openxlsx::readWorkbook(wb, sheet = i,colNames =  F)
# usethis::use_data(wfl_workbook, overwrite = TRUE)
