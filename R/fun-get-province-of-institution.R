#' Helper Function to match and get province of target institution
#'
#' @param df, data frame, contains the target institution column
#' @param target_institution, character, the column name of target institution
#' @param target_province, character, the target output column name for province variable.
#'
#' @import stringr
#' @import dplyr
#' @import tidyselect
#' @importFrom magrittr %>%
#' @importFrom utils data
#' @importFrom rlang .data
#'
#' @return out
#' @export get_province_of_institution
#'
#' @examples
#' library(magrittr)
#' utils::data("PubObsStation",package = "techme")
#' tbl_read <- PubObsStation %>%
#'   dplyr::select(-province)
#'
#' tbl_out <- get_province_of_institution(df = tbl_read,
#'   target_institution ="institution",
#'   target_province = "province")
#'
#'head(tbl_out)


get_province_of_institution <- function(df, target_institution, target_province){
  #=====match data=====
  require("techme")
  utils::data("queryTianyan",package = "techme")
  dt_match <- queryTianyan %>%
    dplyr::select(name_origin, province) %>%
    rename(institution = "name_origin")

  utils::data("ProvinceCity",package = "techme")
  dt_city <- ProvinceCity %>%
    dplyr::select(city_clean, province_clean)

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
    dplyr::select(-tidyselect::one_of(list_exclude)) %>%
    # check here, see codes below
    rename_at(tidyselect::all_of(c("institution","province")),
              ~tidyselect::all_of(c(target_institution,target_province)))
  return(out)

}
