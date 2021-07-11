## code to prepare `wfl_getInfo` dataset goes here


#' Helper function to Extract Information
#'
#' Such as units (thousand tons, etc.),given that all variables have the same units scale in pivot table.
#'
#' @param dt data.frame. Should be characterer the type of pivot table .
#'
#' @return vector
#'
#' @export getInfo
#'
#' @examples
#' same_units <- getInfo(dt)

getInfo <- function(dt){
  dt_cell <- dt  %>%
    unpivotr::as_cells() %>%
    filter(str_detect(chr,"单位:|单位："))
  info_list <- dt_cell %>%
    mutate(chr = str_trim(str_extract(chr, "(?<=单位:|单位：)(.+)"))) %>%
    select(chr) %>%
    unique() %>%
    unlist() %>%
    unname()
  if (length(info_list) > 1) stop( glue::glue("Info items (units) more than 1, please check raw xls file!"))

  return(info_list)
}


# usethis::use_data(wfl_getInfo, overwrite = TRUE)
