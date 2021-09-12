## code to prepare `district` dataset goes here

##====full district info ====
library("tidyverse")
full_name <- c("id", "name", "parent_id", "initial", "initials",
               "pinyin", "extra", "suffix", "code", "area_code", "order")


url_csv <- "https://raw.githubusercontent.com/eduosi/district/master/district-full.csv"
district <- readr::read_delim(url(url_csv), col_types = cols(.default = "c"),
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

##====telephone area code info ====

data("BasicDistrict")
data("BasicProvince")

# get the province full code
dt_code_pro <- BasicDistrict %>%
  select(name, code) %>%
  filter(name %in% BasicProvince$province) %>%
  rename(district = "name",code_province = "code")

# get area code and match province
cols_list <- c("name", "code", "area_code")
dt_district <- BasicDistrict %>%
  select(all_of(cols_list)) %>%
  filter(!is.na(area_code)) %>%
  distinct(area_code, .keep_all = T) %>%
  # string padding
  mutate(code_province = str_pad(str_extract(as.character(code), "\\d{2}"), side = "right", width = 6, pad = "0")) %>%
  left_join(., dt_code_pro, by = "code_province") %>%
  filter(!is.na(district),
         str_length(code)==6)

# write out
BasicTelcode <- dt_district
usethis::use_data(BasicTelcode, overwrite = TRUE)

# write document
require(devtools)
load_all()
use_r("BasicTelcode")
document_dt(BasicTelcode)
document()
