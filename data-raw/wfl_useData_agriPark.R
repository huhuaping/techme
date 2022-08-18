## code to prepare `wfl_useData_NKRDP` dataset goes here

# source pkgs
require(devtools)
load_all()
source("data-raw/set-global.R")

#==== create dir =====

dir_media <- "data-raw/data-tidy/public-site/agri-park/"
dir_fina <- "xlsx/"
gen_dirs_vec(dir_media, dir_fina)

out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)

#===== part 1 approved list  ======

# file path
files_id <- which(str_detect(files_all,"list-batch"))
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

tbl_out <- tbl_read %>%
  .[-index_dup,]

# write out
PubAgriParkList <- tbl_out
usethis::use_data(PubAgriParkList, overwrite = TRUE)

# write document
use_r("Pub-AgriParkList")
document_dt(PubAgriParkList)
document()

#===== part 2 evaluation result ======

# file path
files_id <- which(str_detect(files_all,"eval-year"))
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

# write out
PubAgriParkEval <- tbl_read
usethis::use_data(PubAgriParkEval, overwrite = TRUE)

# write document
use_r("Pub-AgriParkEval")
document_dt(PubAgriParkEval)
document()

#===== part 3 check result ======

# file path
files_id <- which(str_detect(files_all,"check-year"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# batch read xlsx files

## helper function to uniform columns' format
flaten.cols <- function(xlsx){
  out <- openxlsx::read.xlsx(xlsxFile = xlsx) %>%
    mutate(index = as.numeric(index))
}

## vector read xlsx files
tbl_read <- tibble(url = files_path) %>%
  mutate(table = map(url,
                     .f = flaten.cols) # my custom
         ) %>%
  select(-url) %>%
  unnest(table)

## match province
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_check <-  tbl_read %>%
  mutate(province_name = str_extract(name, ptn_province),
         city_clean= str_extract(name, ptn_city)) %>%
  # match city
  left_join(.,
            select(ProvinceCity,
                   city_clean, province_clean),
            by = "city_clean") %>%
  # final matched
  mutate(province = ifelse(is.na(province_name),
                           province_clean,
                           province_name)) %>%
  select(year,index, name, result, province, doc_num )

# just for check
check <-  tbl_check %>%
  filter(is.na(province))

# write out
PubAgriParkCheck <- tbl_check
usethis::use_data(PubAgriParkCheck, overwrite = TRUE)

# write document
use_r("Pub-AgriParkCheck")
document_dt(PubAgriParkCheck)
document()
