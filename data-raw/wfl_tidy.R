## code to prepare `wfl_tidy` dataset goes here

#' Tidy dataset from unpivot yearbook table
#'
#' @param dt data.frame. typically the yearbook unpivot table by use \code{unpivot}.
#'
#' @return data.frame
#' @export getTidy
#'
#' @examples
#' df_tidy <- getTidy(dt = df_out)
#'
getTidy <- function(dt){
  dt_tidy <- dt %>%
    mutate(value = as.numeric(value),
           year = str_extract(year, "\\d{4}")) %>%
    mutate(province = str_replace(province," ", ""),
           province = str_replace(province,"地方合计", "全国")) %>%
    filter(!str_detect(province, "东部|中部|西部|东北")) %>%
    #separate(vars, into = c("vars", "unit"), sep = "\\(") %>%
    mutate(vars = str_trim(vars),
           # handle cell contain both chn and eng names.
           vars = str_replace_all(vars, "\\r\\n","_" ),
           vars = str_replace(vars, "(_[a-zA-Z].+)","" ),
           vars = str_replace_all(vars, "_","" ),
           # handel cell begin with number followed by dot.
           vars = str_replace(vars, "\\d",""),
           vars = str_replace(vars, "\\.",""),
           # handel cell contains units within round brackets.
           vars = str_replace(vars, "(\\(.+\\))",""),
           vars = str_replace(vars, " ","")#,
           #vars = str_trim(vars)
           #unit = str_extract(unit, "(.+)(?=\\))")
    ) %>%
    select(province, year, vars, value, units)
  if (any(is.na(dt_tidy$year))) warning("Variable 'year' missing in some rows, please check.")
  if (any(is.na(dt_tidy$vars))) warning("Variable 'vars' missing in some rows, please check.")

  return(dt_tidy)
}

df_tidy <- getTidy(dt = df_out)

#usethis::use_data(wfl_tidy, overwrite = TRUE)
