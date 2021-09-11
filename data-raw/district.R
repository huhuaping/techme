## code to prepare `district` dataset goes here
library("tidyverse")

full_name <- c("id", "name", "parent_id", "initial", "initials",
               "pinyin", "extra", "suffix", "code", "area_code", "order")


url_csv <- "https://raw.githubusercontent.com/eduosi/district/master/district-full.csv"
district <- readr::read_delim(url(url_csv),
                              col_names = F, delim = "\t") %>%
  as_tibble() %>%
  rename_all(., ~all_of(full_name))



# write out
BasicDistrict <- district
usethis::use_data(BasicDistrict, overwrite = TRUE)

# write document
require(devtools)
load_all()
use_r("BasicDistrict")
document_dt(BasicDistrict)
document()

