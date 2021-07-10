## code to prepare `wfl_editXls` dataset goes here

## code to prepare `unpivot_xls` dataset goes here
require(unpivotr)
library(XLConnect)
library(tidyverse)
library(readxl)
library(glue)



#wb <- loadWorkbook(path_xls, create = TRUE)
wb <- loadWorkbook(file_unlocked_path, create = TRUE)

# you should copy region or change cell values by hand
file_edited_path <- str_replace(file_unlocked_path, "unlocked", "edited")
## create new sheet and save save change to xls
createSheet(wb, "add.sheet")
saveWorkbook(wb,file = file_edited_path )
#input <- tibble(myvalue="地 区") # must be data.frame
#writeWorksheet(wb, input, sheet = getSheets(wb)[1],
               #startRow = 3, startCol = 10)

# check edited sheet
wb <- loadWorkbook(file_edited_path, create = TRUE)
i <- 1
dt_check <- readWorksheet(wb, sheet = i,header = F)

# clear sheets
saveWorkbook(wb)
getSheets(wb)
removeSheet(wb,"CNKI")
# get the numbers of sheets. It should minus one to drop the last sheet contains only copyright informal .
sheetnum <- length(getSheets(wb))



# save xls
file_unlocked <- str_replace(basename(file_xls), ".xlsx$", "-saved.xlsx")
file_unlocked_path <- glue::glue("{file_dir[2]}/{file_unlocked}")
saveWorkbook (wb, file_unlocked_path)

i <- 1
dt_check <- readWorksheet(wb, sheet = i,header = F)



fml <- paste0("地 区")
dt_check[3,10] <- fml
writeWorksheetToFile(file = file_unlocked_path, data = dt_check,
                     sheet = getSheets(wb)[i], styleAction = XLC$STYLE_ACTION.NONE)

setCellFormula(object = wb,sheet = i,
               row = 3,col = 10,
               formula = fml)

library(xlsx)

wb <- openxlsx::loadWorkbook(path_xls)
openxlsx::getSheetNames(path_xls)
openxlsx::removeWorksheet(wb,"CNKI")
openxlsx::writeData(wb, sheet = i, x = "fml", xy = c(3,1))
openxlsx::saveWorkbook(wb,file_unlocked_path)
i <- 2
dt_check <- openxlsx::readWorkbook(wb, sheet = i,colNames =  F)
# usethis::use_data(wfl_editXls, overwrite = TRUE)
