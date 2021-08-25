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
    select(-input, -asis) %>%
    filter(!is.na(variables))
}


df_matched <- matchData(dt_left = df_tidy, dt_right = df_vars_matched)

#last_dir <- str_extract(path_xls, "(part.+)") %>%
#  str_replace(., "(?<=\\.)(.+)", "xlsx")
#tidy_file_name <- mgsub::mgsub(last_dir,
#                          c("raw", "/", "-edited"),
#                          c("tidy", "-", ""))

# generte directory
dir_sub1 <- "data-raw/data-tidy/"
dir_sub2 <- gsub("data-raw/", "",dir_sel)
dir_tidy <- paste0(dir_sub1, dir_sub2)
gen_dirs_vec(media = dir_sub1, final = dir_sub2)

# extract year
#url_xlsx <- "data-raw/data-tidy/rural-yearbook/fertilizer-tidy-2018-2019.xlsx"
#url_xlsx <- "data-raw/data-tidy/rural-yearbook/plastic-tidy-2018-2019.xlsx"
#url_xlsx <- "data-raw/data-tidy/rural-yearbook/pesticide-tidy-2018-2019.xlsx"
#url_xlsx <- "data-raw/data-tidy/tech-yearbook/part01-over-02-spend-intense-tidy-2019.xlsx"
#url_xlsx <- "data-raw/data-tidy/tech-yearbook/part01-over-03-spend-inner-01-activity-tidy-2019.xlsx"

#df_matched <- openxlsx::read.xlsx(url_xlsx) %>%
#  filter(year ==2019)


#usethis::use_data(df_matched, overwrite = TRUE, internal = T)
