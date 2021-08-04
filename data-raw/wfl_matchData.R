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

last_dir <- str_extract(path_xls, "(part.+)") %>%
  str_replace(., "(?<=\\.)(.+)", "xlsx")
tidy_file_name <- mgsub::mgsub(last_dir,
                          c("raw", "/", "-edited"),
                          c("tidy", "-", ""))

# generte directory
dir_sub1 <- "data-raw/data-tidy/"
dir_sub2 <- gsub("data-raw/", "",dir_sel)
gen_dirs_vec(media = dir_sub1, final = dir_sub2)

# extract year
vec_year <- sort(unique(df_matched$year))
files_tidy <- glue::glue("{vec_year}.xlsx" )

# file path
tidy_path <-paste0(dir_sub1, dir_sub2,"/",files_tidy)


#usethis::use_data(df_matched, overwrite = TRUE, internal = T)
