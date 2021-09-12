## code to prepare `TelArea` dataset goes here
##====full district info ====
library("tidyverse")
full_name <- c("area_code", "province_raw","district")

url_csv <- "https://gist.githubusercontent.com/vvtommy/a1bee4cd9e65e6d57b84f35f4e4dd5e1/raw/a0aa736eeec30134ca2a2367c55c115be23d5dd1/%25E4%25B8%25AD%25E5%259B%25BD%25E5%258C%25BA%25E5%258F%25B7.csv"
district <- readr::read_delim(url(url_csv), col_types = cols(.default = "c"),
                              col_names = T, delim = ",") %>%
  as_tibble() %>%
  rename_all(., ~all_of(full_name))

BasicTelAreaCode<- district
usethis::use_data(BasicTelAreaCode, overwrite = TRUE)

# write document
require(devtools)
load_all()
use_r("BasicTelAreaCode")
document_dt(BasicTelAreaCode)
document()
