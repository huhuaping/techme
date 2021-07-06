## code to prepare `varsList` dataset goes here
library("openxlsx")
library(tidyverse)
library("dplyr")
library("stringr")
library("usethis")

# read vars set
file_path <- "data-raw/varsList.xlsx"
out_path <- "data-raw/varsOut.xlsx"
varsList <- openxlsx::read.xlsx(file_path) %>%
  mutate(variables= stringr::str_c(block1, block2, block3, block4, sep = "_"))

write.xlsx(varsList, out_path)

usethis::use_data(varsList, overwrite = TRUE)
