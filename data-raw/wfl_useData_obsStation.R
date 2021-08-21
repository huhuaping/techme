## code to prepare `wfl_useData_obsStation` dataset goes here

# source pkgs

source("data-raw/set-global.R")

#==== create dir =====

dir_media <- "data-raw/data-tidy/public-site/observe-station/"
dir_fina <- "xlsx/"
gen_dirs_vec(dir_media, dir_fina)

out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)


# file path
files_id <- which(str_detect(files_all,"list-"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# batch read xlsx files
tbl_read <- tibble(url = files_path) %>%
  mutate(table = map(url, ~openxlsx::read.xlsx(.x))) %>%
  select(-url) %>%
  unnest(table)

# just for check
index_dup <- which(duplicated(tbl_read$name))
tbl_check <-  tbl_read %>%
  .[index_dup,]

#=====match institution to province=====
require("techme")

data("queryTianyan")
dt_match <- queryTianyan %>%
  select(name_origin, province) %>%
  rename(institution = "name_origin")

data("ProvinceCity")
dt_city <- ProvinceCity %>%
  select(city_clean, province_clean)

ptn_city<- paste0(unique(ProvinceCity$city_clean), collapse = "|")
ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse = "|")

list_exclude <- c("province_raw", "province_clean","city_clean")
tbl_out <- tbl_read %>%
  left_join(., dt_match, by= "institution" ) %>%
  # filter obvious province info
  mutate(province_raw = str_extract(institution, ptn_province)) %>%
  mutate(province = ifelse(is.na(province), province_raw, province)) %>%
  # match city
  mutate(city_clean = str_extract(institution, ptn_city)) %>%
  left_join(., dt_city, by= "city_clean" ) %>%
  mutate(province = ifelse(is.na(province), province_clean, province)) %>%
  dplyr::select(-one_of(list_exclude))

# check
check <- sum(is.na(tbl_out$province))
if(check > 0) stop("please check the name of institution!")


# write out
PubObsStation <- tbl_out
usethis::use_data(PubObsStation, overwrite = TRUE)

# write document
require(devtools)
load_all()
use_r("Pub-ObsStation")
document_dt(PubObsStation)
document()
