## code to prepare `wfl_unpivot` dataset goes here

#------Helper function to get range of pivot table----
#' Get range of pivot table
#'
#' @param dt
#' @param ith number. when exist multiple table region in one sheet.
#' @param what character. What is the object function will return, whether "row" or "col".
#' @param reg_start character. regex pattern for start identifier, default \code{'^地.*区'}.
#' @param reg_end character. regex pattern for end identifier, default \code{'^新.*疆'}
#'
#' @return vector
#' @export
#'
#' @examples
#'
#' path_xls <- "data-raw/rural-yearbook/part03-agri-produce/01-machine/raw-2019-2020.xls"    # 4 by_row tbl
#' path_xls <- "data-raw/rural-yearbook/part03-agri-produce/03-plastic/raw-2019-2020.xls"    # one tbl
#' path_xls <- "data-raw/rural-yearbook/part03-agri-produce/02-fertilizer/raw-2018-2019-unlocked.xlsx" # 2 by_col tbl
#' wb <- loadWorkbook(path_xls, create = TRUE)
#' dt <- readWorksheet(wb, sheet = 1,header = F) %>%
#'   select_if(~ !all(is.na(.)))
#' i <- 2
#' myrows <- getRange(dt, ith = i, what = "row")
#' mycols <- getRange(dt, ith = i, what = "col")
#'

getRange <- function(dt, ith, sheet, what,
                     reg_start="^地.*区", reg_end ="^新.*疆"){
  # detect numbers of tables in this sheet
  n_tables <- dt %>%
    mutate_all(~str_detect(., "续表")) %>%
    unlist() %>%
    sum(na.rm = T)

  if (sheet ==1) {
    n_tables <- n_tables +1  # case in sheet 1
  } else  if (sheet >1){
    n_tables                 # case in sheet 2 and more
  }

  # search whole region
  dt_detect_region <- dt %>%
    mutate_all(~str_detect(., "^地.*区|^新.*疆"))

  # search along cols
  ## identify id rows
  range_row <- sapply(dt_detect_region,
         function(x){which(str_detect(x, "TRUE"))}
         )
  ## identify id cols
  index_row <- range_row %>%
    sapply(., function(x){length(x)!=0}) # filter index

  # position row index range
  df_row_mx <- range_row[which(index_row==TRUE)] %>%
    bind_rows() %>% unlist() %>% unname() %>%
    matrix(., ncol = n_tables) %>%
    as_tibble()

  # position col index range
  col_max <- dim(dt_detect_region)[2]   # max col index
  col_cuts<- which(index_row==TRUE) %>%
    bind_rows() %>% unlist() %>% unname()
  col_cuts_number <- length(col_cuts)
  if (col_cuts_number >1){
    df_col_mx <- c(col_cuts,col_cuts[-1]-1,col_max) %>%
      matrix(., ncol = 2) %>%
      t() %>% as_tibble()
  } else if(col_cuts_number==1){
    df_col_mx <- rep(c(col_cuts,col_max), times =n_tables) %>%
      matrix(., ncol = n_tables) %>%
      as_tibble()
  }

  # create sequence index
  rows <- min(unlist(df_row_mx[,ith])):max(unlist(df_row_mx[,ith]))
  cols <- min(unlist(df_col_mx[,ith])):max(unlist(df_col_mx[,ith]))

  if (what == "row") {
    return(rows)
  } else if (what == "col") {
    return(cols)
  }

}


# ------function to unpivot table-----

#' Unpivot table
#'
#' @param dt data.frame. Which is the wb object reading from xls workbook.
#' @param cols vector. Target cols of the region contains pivot table.
#' @param rows vector. Target rows of the region contains pivot table.
#' @param cols.drop vector. Columns numbers which will be dropped, default \code{NULL}.
#' @param header.mode character. One of the four options:  'vars-year', 'vars', 'vars-vars','year'
#' @param vars.add character. if header.mode = 'year', then the vars.add must be specified,
#'   And you can use the function \code{get_vars()} to get the variable name.
#'
#' @return data.frame
#' @export unpivot
#'
#' @examples
#' wb <- loadWorkbook(path_xls, create = TRUE)
#' dt <- readWorksheet(wb, sheet = 1,header = F) %>%
#'   select_if(~ !all(is.na(.)))
#' i <- 1
#' myrows <- getRange(dt, ith = i, what = "row")
#' mycols <- getRange(dt, ith = i, what = "col")
#' cols_drop <- c(2)
#' header_mode <- c("vars", "vars-vars")
#' vars_spc <- get_vars(df = varsList, lang = "eng",
#'                      block = list(block1 = "v4",
#'                                   block2 = "zh",
#'                                   block3 = "qd",
#'                                   block4 = "RD"),
#'                      what = "chn_block4")
#'
#' tbl_raw <- unpivot(dt, cols = mycols, rows = myrows,
#'                    cols.drop = cols_drop,
#'                    header.mode = header_mode[i],
#'                    vars.add = vars_spc)
#'

unpivot <- function(dt, rows, cols,
                    cols.drop = cols_drop,
                    header.mode ,
                    vars.add = vars_spc ){
  # drop cols
  if (is.null(cols.drop)) {

    dt_cell <- dt[rows,cols]
  } else {
    dt_cell <- dt[rows,cols] %>%
      .[,-cols.drop]
  }

  dt_cell <- dt_cell  %>%
    as_cells() %>%
    arrange( col, row )

  if(header.mode == "vars-year"){ # header mode 1
    dt_cellout <- dt_cell %>%
      behead("up-left", vars) %>%
      behead("up", year) %>%
      behead("left", province)
  } else if (header.mode == "vars"){ # header mode 2
    dt_cellout <- dt_cell %>%
      behead("up", vars) %>%
      behead("left", province) %>%
      add_column(year = str_extract(file_xls,"\\d{4}"))
  } else if (header.mode == "vars-vars"){ # header mode 3
    dt_cellout <- dt_cell %>%
      behead("up-left", vars_tot) %>%
      behead("up", vars) %>%
      mutate(vars = ifelse(is.na(vars), vars_tot, vars)) %>%
      behead("left-up", province) %>%
      add_column(year = str_extract(file_xls,"\\d{4}")) %>%
      select(-vars_tot)
  }else if (header.mode == "year"){ # header mode 4
    if (length(vars.add)!=1) stop("Added Vars info not correct, please specify by function 'get_vars()' ")
    dt_cellout <- dt_cell %>%
      behead("up", year) %>%
      behead("left", province) %>%
      add_column(vars = unname(unlist(vars.add)))
  }

  # detect data type
  value_type <- unique(dt_cellout$data_type)
  if (length(value_type)==1){
    # only one type
    value_tar <- value_type

    dt_cellfinal <- dt_cellout %>%
      rename(value = value_tar) %>%
      dplyr::select(province, year, vars, value)

  } else if (length(value_type)>1) {
    # one more types
    # use the numerical cells
    index_tar <- which(str_detect(value_type, "dbl"))
    value_tar <- value_type[index_tar]

    dt_cellfinal <- dt_cellout %>%
      filter(is.na(chr)) %>% # drop the chr colums
      rename(value = value_tar) %>%
      dplyr::select(province, year, vars, value)
  }

  return(dt_cellfinal)
}





#------Helper function to Extract Information------

#' Helper function to Extract Information
#'
#' Such as units (thousand tons, etc.),given that all variables have the same units scale in pivot table.
#'
#' @param dt data.frame. Should be character the type of pivot table .
#'
#' @return vector
#'
#' @export getInfo
#'
#' @examples
#' same_units <- getInfo(dt )

getInfo <- function(dt){
  dt_cell <- dt  %>%
    unpivotr::as_cells() %>%
    filter(str_detect(chr,"单位:|单位："))
  info_list <- dt_cell %>%
    mutate(chr = str_extract(chr, "(?<=单位:|单位：)(.+)"),
           chr = str_trim(chr)) %>%
    select(chr) %>%
    unique() %>%
    unlist() %>%
    unname()
  if (length(info_list) > 1) stop( glue::glue("Info items (units) more than 1, please check raw xls file!"))

  return(info_list)
}

#-----begin run-----


loop_unpivot <- function(tar_file=mypath,
                         hd_mode="vars-year",
                         vars_add = NULL,
                         cols_drop=NULL){

  require(XLConnect)
  require(unpivotr)

  wb <- XLConnect::loadWorkbook(tar_file, create = TRUE)

  getSheets(wb)
  removeSheet(wb,"CNKI")
  # get the numbers of sheets. It should minus one to drop the last sheet contains only copyright informal .
  sheetnum <- length(getSheets(wb))

  if (sheetnum==0) {
    stop("no files founded, please check file existed")
  }  else{
    print(glue::glue("totally {sheetnum} xls sheet(s) need to unpivot."))
  }

  # j = 1
  df_out <- NULL
  for (j in 1:sheetnum){
    print(glue::glue("begin unpivot the {j} of {sheetnum} xls sheet."))
    # load workbook
    wb <- loadWorkbook(tar_file, create = TRUE)
    dt <- readWorksheet(wb, sheet = j,header = F) %>%
      select_if(~ !all(is.na(.)))

    # detect numbers of tables in this sheet
    n_tables <- dt %>%
      mutate_all(~str_detect(., "续表")) %>%
      unlist() %>%
      sum(na.rm = T)

    if (j ==1) {
      n_tables <- n_tables +1  # case in sheet 1
    } else  if (j >1){
      n_tables                 # case in sheet 2 and more
    }

    print(glue::glue("totally {n_tables} pivot table detect in this sheet."))

    # loop tables in sheet
    # i <- 1
    for (i in 1:n_tables) {
      sel_rows <- getRange(dt, ith = i, sheet=j,what = "row")
      sel_cols <- getRange(dt, ith = i, sheet=j, what = "col")

      #header_mode <- c("vars", "vars-vars")
      tbl_tem <- unpivot(dt = dt,
                         rows = sel_rows,
                         cols = sel_cols,
                         cols.drop = cols_drop,
                         header.mode = hd_mode,  # default "vars-year"
                         vars.add = vars_add     # base vars chn names
                         )
      print(glue::glue("Successfully unpivot the {i} of {n_tables} pivot data region."))

      df_out <- bind_rows(df_out, tbl_tem)
    }# end loop i

    # get unit when all variables have the same units.
    same_units <- getInfo(dt)
    if (length(same_units)==1) {
      print( glue::glue("Varibales in sheet {j} have same units: {same_units}"))
    } else if (length(same_units)==0) {
      print( glue::glue("Varibales in sheet {j} have different units"))
    } else {
      warning("Please check Varibales units in sheet {j} when unpivot.")
    }

    # given that units different and contains within () following variables names,
    ## or all variables have same units.
    df_out <- df_out %>%
      mutate(units = str_extract(vars, "(?<=\\()(.+)(?=\\))"),
             units = str_trim(units)) %>%
      mutate(units = ifelse(is.na(units), same_units, units))
  } # end loop i

  return(df_out)

}



# usethis::use_data(wfl_unpivot, overwrite = TRUE)
