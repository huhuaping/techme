## code to prepare `load_province` dataset goes here

source("data-raw/set-global.R")

file_path <- "data-raw/xlsx/basic-province.xlsx"

dt_out <- openxlsx::read.xlsx(file_path)

BasicProvince <- dt_out

usethis::use_data(BasicProvince, overwrite = TRUE)
