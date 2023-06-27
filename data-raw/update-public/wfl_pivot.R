#' Pivot all columns exclude foreign ids to long data.frame.
#'
#' @param df data.frame. must contain columns c( "year","officer","index")
#'
#' @return data.frame.
#'
#' @export pivot_long
#'
#' @examples
#' df_long <- pivot_long(df = df_province)
#'
pivot_long <- function(df){
  cols_id <- c( "year","officer","index")
  tbl_out <- df %>%
    pivot_longer(names_to = "block4", values_to = "value",
                 -all_of(cols_id))
  return(tbl_out)
}

