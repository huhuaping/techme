## code to prepare `wfl_tidy` dataset goes here

#' Tidy dataset from unpivot yearbook table
#'
#' @param dt data.frame. typically the yearbook unpivot table by use \code{unpivot}.
#'
#' @return data.frame
#' @export getTidy
#'
#' @examples
#'
getTidy <- function(dt){
  dt_tidy <- dt %>%
    mutate(value = as.numeric(value),
           year = str_extract(year, "\\d{4}"),
           province = str_replace(province," ", "")) %>%
    #separate(vars, into = c("vars", "unit"), sep = "\\(") %>%
    mutate(vars = str_trim(vars),
           vars = str_replace(vars, "\\d",""),
           vars = str_replace(vars, "\\.",""),
           vars = str_replace(vars, "(\\(.+\\))",""),
           vars = str_replace(vars, " ",""),
           vars = str_trim(vars)
           #unit = str_extract(unit, "(.+)(?=\\))")
    ) %>%
    select(province, year, vars, value, units)
  if (any(is.na(dt_tidy$year))) warning("Variable 'year' missing in some rows, please check.")
  if (any(is.na(dt_tidy$vars))) warning("Variable 'vars' missing in some rows, please check.")

  return(dt_tidy)
}

df_tidy <- getTidy(dt = df_out)

#usethis::use_data(wfl_tidy, overwrite = TRUE)
