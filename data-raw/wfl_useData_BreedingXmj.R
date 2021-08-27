## code to prepare `wfl_useData_BreedingXmj` dataset goes here

source("data-raw/set-global.R")

# =====create dir====

dir_media <- "data-raw/data-tidy/public-site/moa-xmj-breeding/"
dir_fina <- "update/"
#gen_dirs_vec(dir_media, dir_fina)

# file path
out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)
files_id <- which(str_detect(files_all,"tidy-year-"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# helper function
read_file <- function(path) {
  df <- openxlsx::read.xlsx(path) %>%
    mutate_all(., .funs = as.character)
}

# target columns and names
header_target <- c("year","index","province", "type",
                   "name_origin", "name_change", "mark")

tbl_read <- tibble(url = files_path) %>%
  mutate(table = map(url, read_file)) %>%
  select(-url) %>%
  unnest(table) %>%
  # handle string newline
  mutate_all(.,.funs = str_replace,
             pattern = "\n",
             replacement = "") %>%
  rename(province_old ="province")

tbl_result <- techme::get_province_of_institution(df = tbl_read,
                                            target_institution ="name_origin",
                                            target_province = "province_origin") %>%
  mutate(province = ifelse(!is.na(province_old),
                           province_old,
                           province_origin)) %>%
  select(all_of(header_target))

# check begin
tbl_result %>%
  select(name_origin, province) %>%
  filter(!is.na(name_origin),is.na(province))


# write out
PubBreedingXmj <- tbl_result
usethis::use_data(PubBreedingXmj, overwrite = TRUE)

# write document
require(devtools)
load_all()
use_r("Pub-BreedingXmj")
document_dt(PubBreedingXmj)
document()
