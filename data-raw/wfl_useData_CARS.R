## code to prepare `wfl_useData_CARS` dataset goes here

# source pkgs

source("data-raw/set-global.R")

# =====create dir====

dir_media <- "data-raw/data-tidy/public-site/moa-agri-system/"
dir_fina <- "xlsx/"
gen_dirs_vec(dir_media, dir_fina)

# file path
out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)
files_id <- which(str_detect(files_all,"list-industry"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# helper function
read_file <- function(path) {
  df <- openxlsx::read.xlsx(path) %>%
    mutate_all(., .funs = as.character)
}

# ======batch read xlsx files=====
# all names
names_sel <- c("year", "index",
               "area_num_eng", "area_name",
               "chairman_industry", "institution_industry",
               "func_num", "func_name", "func_inst", "func_director",
               "researcher_area", "researcher_name", "researcher_inst")

tbl_read <- tibble(url = files_path) %>%
  mutate(table = map(url, read_file)) %>%
  select(-url) %>%
  unnest(table) %>%
  # handle string newline
  mutate_all(.,.funs = str_replace,
             pattern = "\n",
             replacement = "")

# check
setdiff(names_sel,names(tbl_read))

#' Helper Function to match and get province of target institution
#'
#' @param df, data frame, contains the target institution column
#' @param target_institution, character, the column name of target institution
#' @param target_province, character, the target output column name for province variable.
#'
#' @return out
#' @export get_province_of_institution
#'
#' @examples
#' tbl_industry <- get_province_of_institution(df = tbl_read,
#'   target_institution ="institution_industry",
#'   target_province = "province_industry")
#'

get_province_of_institution <- function(df, target_institution, target_province){
  #=====match data=====
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

  # match and get
  out <- df %>%
    rename(institution = target_institution) %>%
    left_join(., dt_match, by= "institution" ) %>%
    # filter obvious province info
    mutate(province_raw = str_extract(institution, ptn_province)) %>%
    mutate(province = ifelse(is.na(province), province_raw, province)) %>%
    # match city
    mutate(city_clean = str_extract(institution, ptn_city)) %>%
    left_join(., dt_city, by= "city_clean" ) %>%
    mutate(province = ifelse(is.na(province), province_clean, province)) %>%
    dplyr::select(-one_of(list_exclude)) %>%
    # check here, see codes below
    rename_at(all_of(c("institution","province")),
              ~all_of(c(target_institution,target_province)))
  return(out)

}

# ====== step 1/3 match 'institution_industry'====

tbl_industry <- get_province_of_institution(df = tbl_read,
                                            target_institution ="institution_industry",
                                            target_province = "province_industry")

# check begin
tbl_industry %>%
  select(institution_industry, province_industry) %>%
  filter(!is.na(institution_industry),is.na(province_industry))

# ====== step 2/3 match 'func_inst'====

tbl_func <- get_province_of_institution(df = tbl_industry,
                                            target_institution ="func_inst",
                                            target_province = "province_func")

# check begin
tbl_func  %>%
  select(func_inst, province_func) %>%
  filter(!is.na(func_inst),is.na(province_func))

# ====== step 3/3 match  'researcher_inst'====

tbl_researcher <- get_province_of_institution(df = tbl_func,
                                              target_institution ="researcher_inst",
                                              target_province = "province_researcher")

# check begin
tbl_researcher %>%
  select(researcher_inst, province_researcher) %>%
  filter(!is.na(researcher_inst),is.na(province_researcher))


# write out
PubCars <- tbl_researcher
usethis::use_data(PubCars , overwrite = TRUE)

# write document
require(devtools)
load_all()
use_r("Pub-Cars")
document_dt(PubCars)
document()


