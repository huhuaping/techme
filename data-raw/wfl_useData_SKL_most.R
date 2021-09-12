## code to prepare `wfl_useData_SKL` dataset goes here
source("data-raw/set-global.R")

# =====create dir====

dir_media <- "data-raw/data-tidy/public-site/most-SKL/"
dir_fina <- "xlsx/"
gen_dirs_vec(dir_media, dir_fina)

# file path
out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)
files_id <- which(str_detect(files_all,"year-"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# helper function
read_file <- function(path) {
  df <- openxlsx::read.xlsx(path) %>%
    mutate_at(vars(contains("NO")), .funs = as.character)
}

# target columns and names
header_target <- c("year","type",
                "index", "name", "area",
                "institution","administrator",
                "province_raw",
                "NO","start_year")
tbl_read <- tibble(url = files_path) %>%
  mutate(table = map(url, read_file)) %>%
  select(-url) %>%
  unnest(table) %>%
  # handle string newline
  mutate_all(.,.funs = str_replace,
             pattern = "\n",
             replacement = "")



# ==== reduced province ===
data("ProvinceCity")
ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

header_target <- c("year","type",
                   "index", "name", "area",
                   "institution","administrator",
                   "province",
                   "NO","start_year")

tbl_result <- tbl_read %>%
  mutate(province = str_extract(province_raw, ptn_province)) %>%
  #mutate(province_city = str_extract(area_name, ptn_city)) %>%
  #mutate(province = ifelse(is.na(province),
                           #province_city, province)) %>%
  select(all_of(header_target))

# check begin
tbl_result %>%
  select(province) %>%
  filter(is.na(province))

unique(tbl_result$province)

# write out
PubSKLMost <- tbl_result
usethis::use_data(PubSKLMost, overwrite = TRUE)

# write document
require(devtools)
load_all()
use_r("Pub-SKLMost")
document_dt(PubSKLMost)
document()

