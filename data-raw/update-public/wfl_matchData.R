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
  rpl <- dt_right$block4

  cols_tar <- c("id","year", "officer","index",
                 "block3","block4", "chn_block4",
                 "value", "variables")

  df_matched <- dt_left %>%
    mutate(vars = mgsub::mgsub(block4, pattern =ptn,
                               replacement = rpl )) %>%
    left_join(., dt_right, by = "block4") %>%
    select(-input, -asis) %>%
    filter(!is.na(variables)) %>%
    # create id column
    mutate(id = str_c(block3,
                      str_to_lower(officer),
                      year, sep="-")) %>%
    # sort columns
    select(all_of(cols_tar))
}


