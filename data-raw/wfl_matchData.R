## code to prepare `wfl_matchData` dataset goes here

#' Title
#'
#' @param dt_left data.frame. The tidy unpivot table
#' @param dt_right data.frame. The matched variables table and should be checked.
#'
#' @return data.frame
#' @export matchData
#'
#' @examples
#' df_matched <- matchData(dt_left = df_tidy, dt_right = vars_matched)
#' openxlsx::write.xlsx(df_matched, "data-raw/df-matched.xlsx")
#'
matchData <- function(dt_left, dt_right){
  require("mgsub")
  ptn <- dt_right$input
  rpl <- dt_right$chn_block4
  df_matched <- dt_left %>%
    mutate(vars = mgsub::mgsub(vars, pattern =ptn,
                               replacement = rpl )) %>%
    rename(chn_block4="vars") %>%
    left_join(., dt_right, by = "chn_block4") %>%
    select(-input, -asis)
}


df_matched <- matchData(dt_left = df_tidy, dt_right = df_vars_matched)
last_dir <- str_extract(path_xls, "(?<=/\\d{2}-)(.+)") %>%
  str_replace(., "(?<=\\.)(.+)", "xlsx")
tidy_dir <- mgsub::mgsub(last_dir,
                          c("raw", "/", "-edited"),
                          c("tidy", "-", ""))
tidy_path <-paste0("data-raw/data-tidy/",tidy_dir)
openxlsx::write.xlsx(df_matched, tidy_path)


#usethis::use_data(df_matched, overwrite = TRUE, internal = T)
