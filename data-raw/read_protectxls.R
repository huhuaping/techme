## code to prepare `read_protectxls` dataset goes here
## the xls file is protected,can't edit, but can read by XLconnect

library(XLConnect)
wb <- loadWorkbook("data-raw/MyFile.xls", create = TRUE)
dt <- readWorksheet(wb, sheet = 1,header = F)

#usethis::use_data(read_protectxls, overwrite = TRUE)
