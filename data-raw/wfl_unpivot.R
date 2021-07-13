## code to prepare `wfl_unpivot` dataset goes here

#------Helper function to get range of pivot table----
#' Get range of pivot table
#'
#' @param dt
#' @param reg_start character regex pattern for start identifier, default \code{'^地.*区'}.
#' @param reg_end character regex pattern for end identifier, default \code{'^新.*疆'}
#'
#' @return list
#' @export
#'
#' @examples
#'   wb <- loadWorkbook(path_xls, create = TRUE)
#'   dt <- readWorksheet(wb, sheet = 1,header = F)
#'   pivot_range <- getRange(dt)
#'   len <- nrow(pivot_range)
#'
getRange <- function(dt, reg_start="^地.*区", reg_end ="^新.*疆"){
  pivot_start <- which(str_detect(dt$Col1, reg_start))
  pivot_end <- which(str_detect(dt$Col1, reg_end ))

  # check length
  if (length(pivot_start)!=length(pivot_end)) stop("起止行长度不同。请检查识别字符是否正确！")
  if (all(pivot_start > pivot_end)) stop("start rows large then end rows. please check the identifier of rows!")

  pivot_range <- tibble(start = pivot_start,
                        end = pivot_end)
  return(pivot_range)
}


# ------function to unpivot table-----

#' Unpivot table
#'
#' @param dt
#' @param rows
#'
#' @return data.frame
#' @export unpivot
#'
#' @examples
#' wb <- loadWorkbook(path_xls, create = TRUE)
#' dt <- readWorksheet(wb, sheet = 1,header = F)
#' pivot_range <- getRange(dt)
#' pivot_rows <- pivot_range$start:pivot_range$end
#' vars_spc <- get_vars(df = varsList, lang = "eng",
#'                      block = list(block1 = "v4",
#'                                   block2 = "zh",
#'                                   block3 = "qd",
#'                                   block4 = "RD"),
#'                      what = "chn_block4")
#'
#'
#' tbl_raw <- unpivot(dt, rows = pivot_rows,
#'                    cols.drop = c(2),
#'                    header.mode = "year",
#'                    vars.add = vars_spc)
#'



if (yearbook=="rural") {
  unpivot <- function(dt, rows){
    dt_cell <- dt[rows,]  %>%
      as_cells() %>%
      arrange( col,row ) %>%
      behead("up-left", vars) %>%
      behead("up", year) %>%
      behead("left", province) %>%
      rename(value = chr) %>%
      select(-data_type, -row, -col)
    return(dt_cell)
  }
#
} else if (yearbook=="tech") {
  unpivot <- function(dt, rows, cols.drop = NULL,
                      header.mode = "year",
                      vars.add = NULL){
    # drop cols
    if (is.null(cols.drop)) {
      dt_cell <- dt[rows,]
    } else {
      dt_cell <- dt[rows,-cols.drop]
    }

    dt_cell <- dt_cell  %>%
      as_cells() %>%
      arrange( col,row )

    if(header.mode == "vars-year"){ # header mode 1
      dt_cell <- dt_cell %>%
        behead("up-left", vars) %>%
        behead("up", year) %>%
        behead("left", province)
    } else if (header.mode == "vars"){ # header mode 2
      dt_cell <- dt_cell %>%
        behead("up", vars) %>%
        behead("left", province) %>%
        add_column(year = str_extract(file_xls,"\\d{4}"))
    } else if (header.mode == "year"){ # header mode 3
      if (length(vars.add)!=1) stop("Added Vars info not correct, please specify by function 'get_vars()' ")
      dt_cell <- dt_cell %>%
        behead("up", year) %>%
        behead("left", province) %>%
        add_column(vars = vars.add)
    }
    dt_cell <- dt_cell %>%
      rename(value = chr) %>%
      select(province, year, vars, value)
    return(dt_cell)
  }

}



#------Helper function to Extract Information------

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


wb <- loadWorkbook(path_xls, create = TRUE)

getSheets(wb)
removeSheet(wb,"CNKI")
# get the numbers of sheets. It should minus one to drop the last sheet contains only copyright informal .
sheetnum <- length(getSheets(wb))

if (sheetnum==0) {
  stop("no files founded, please check file existed")
}  else{
  print(glue::glue("totally {sheetnum} xls sheet(s) need to unpivot."))
}


#i <- 2
df_out <- NULL
for (i in 1: sheetnum){
  print(glue::glue("begin unpivot the {i} of {sheetnum} xls sheet."))

  dt <- readWorksheet(wb, sheet = i,header = F)
  pivot_range <- getRange(dt)
  len <- nrow(pivot_range)
  print(glue::glue("totally {len} pivot table detect in this sheet."))

  #j <-1
  for (j in 1:len){
    pivot_rows <- pivot_range$start[j]:pivot_range$end[j]
    df_tem <- unpivot(dt, rows = pivot_rows)
    print(glue::glue("Successfully unpivot the {j} of {len} pivot data region."))
    df_out <- bind_rows(df_out, df_tem)
  } # end loop j
  # get unit when all variables have the same units.
  same_units <- getInfo(dt)
  if (length(same_units)==1) {
    print( glue::glue("Varibales in sheet {i} have same units: {same_units}"))
  } else if (length(same_units)==0) {
    print( glue::glue("Varibales in sheet {i} have different units"))
  } else {
    warning("Please check Varibales units in sheet {i} when unpivot.")
  }

  # given that units different and contains within () following variables names,
  ## or all variables have same units.
  df_out <- df_out %>%
    mutate(units = str_trim(str_extract(vars, "(?<=\\()(.+)(?=\\))"))) %>%
    mutate(units = ifelse(is.na(units), same_units, units))
} # end loop i

# usethis::use_data(wfl_unpivot, overwrite = TRUE)
