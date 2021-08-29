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
#' wb <- loadWorkbook(path_xls[1], create = TRUE)
#' dt <- readWorksheet(wb, sheet = 1,header = F) %>%
#'   select_if(~ !all(is.na(.)))
#' i <- 1
#' myrows <- getRange(dt, ith = i, what = "row")
#' mycols <- getRange(dt, ith = i, what = "col")
#'
getRange <- function(dt, ith, what,
                     reg_start="^地.*区", reg_end ="^新.*疆"){

  dt_detect_region <- dt %>%
    mutate_all(.funs = funs(str_detect(., "^地.*区|^新.*疆")))
  # search along cols
  range_row <- sapply(dt_detect_region,
         function(x){which(str_detect(x, "TRUE"))}
         )
  index_row <- range_row %>%
    sapply(., function(x){length(x)!=0}) # filter index

  df_row <- range_row[which(index_row==TRUE)] %>% data.frame()
  df_col <- which(index_row==TRUE) %>%t(.) %>% data.frame()
  # check length
  if (dim(df_row)[2]!=dim(df_col)[2]) stop("行和列的维度不同。请检查识别字符是否正确！")
  n_tbl <- dim(df_col)[2]

  col_max <- dim(dt_detect_region)[2]
  # get the col interval by cut
  col_region <- tibble(col_index = 1:col_max) %>%
    mutate(col_cat= cut(1:col_max, breaks = c(unlist(df_col),col_max),
                        include.lowest = T,right = F))

  rows <- min(unlist(df_row[,ith])):max(unlist(df_row[,ith]))
  cols <- col_region %>% filter(col_cat==levels(.$col_cat)[ith]) %>%
    select(col_index) %>%
    unlist() %>% unname()

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
#' @param file character. current file with full names (contains '.xls').
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
#' wb <- loadWorkbook(path_xls[1], create = TRUE)
#' dt <- readWorksheet(wb, sheet = 1,header = F) %>%
#'   select_if(~ !all(is.na(.)))
#' i <- 1
#' myrows <- getRange(dt, ith = i, what = "row")
#' mycols <- getRange(dt, ith = i, what = "col")
#' #cols_drop <- c(2)
#' cols_drop <- NULL
#' #header_mode <- c("vars", "vars-vars")
#' header_mode <- c("vars-h4")
#' vars_spc <- get_vars(df = varsList, lang = "eng",
#'                      block = list(block1 = "v8",
#'                                   block2 = "t1",
#'                                   block3 = "zcqc"#,
#'                                   #block4 = "RD"
#'                                   ),
#'                      what = "chn_block4")
#'
#' tbl_raw <- unpivot(dt, file=file_xls[1], cols = mycols, rows = myrows,
#'                    cols.drop = cols_drop,
#'                    header.mode = header_mode[i],
#'                    vars.add = vars_spc)
#'

unpivot <- function(dt, file, rows, cols,
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
    dt_cell <- dt_cell %>%
      behead("up-left", vars) %>%
      behead("up", year) %>%
      behead("left", province)
  } else if (header.mode == "vars"){ # header mode 2
    dt_cell <- dt_cell %>%
      behead("up", vars) %>%
      behead("left", province) %>%
      add_column(year = str_extract(file,"\\d{4}"))
  } else if (header.mode == "vars-vars"){ # header mode 3
    dt_cell <- dt_cell %>%
      behead("up-left", vars_tot) %>%
      behead("up", vars) %>%
      mutate(vars = ifelse(is.na(vars), vars_tot, vars)) %>%
      behead("left-up", province) %>%
      add_column(year = str_extract(file,"\\d{4}")) %>%
      select(-vars_tot)
  }else if (header.mode == "vars-h3"){ # 3 headers for livestock
    dt_cell <- dt_cell %>%
      behead("left", province) %>%
      behead("up", vars) %>%
      behead("up", h2) %>%
      behead("up", h3) %>%
      mutate(vars = ifelse(!is.na(h3), h3, vars)) %>%
      mutate(vars = ifelse(is.na(h3)&!is.na(h2) , h2, vars)) %>%
      add_column(year = str_extract(file,"\\d{4}")) %>%
      select(-h3,-h2)
  }else if (header.mode == "vars-h4"){ # 4 headers for livestock
    dt_cell <- dt_cell %>%
      behead("left", province) %>%
      behead("up", vars) %>%
      behead("up", h2) %>%
      behead("up", h3) %>%
      behead("up", h4) %>%
      mutate(vars = ifelse(!is.na(h4) , h4, vars)) %>%
      mutate(vars = ifelse(is.na(h4)&!is.na(h3), h3, vars)) %>%
      mutate(vars = ifelse( is.na(h4)&is.na(h3)&!is.na(h2), h2, vars)) %>%
      add_column(year = str_extract(file,"\\d{4}")) %>%
      select(-h4,-h3,-h2)
  }else if (header.mode == "vars-h5"){ # 5 headers for livestock
    dt_cell <- dt_cell %>%
      behead("left", province) %>%
      behead("up", vars) %>%
      behead("up", h2) %>%
      behead("up", h3) %>%
      behead("up", h4) %>%
      behead("up", h5) %>%
      mutate(vars = ifelse(!is.na(h5) , h5, vars)) %>%
      mutate(vars = ifelse(is.na(h5) &!is.na(h4) , h4, vars)) %>%
      mutate(vars = ifelse(is.na(h5) &is.na(h4)&!is.na(h3), h3, vars)) %>%
      mutate(vars = ifelse(is.na(h5) &is.na(h4)&is.na(h3)&!is.na(h2), h2, vars)) %>%
      add_column(year = str_extract(file,"\\d{4}")) %>%
      select(-h5,-h4,-h3,-h2)
  }else if (header.mode == "year"){ # header mode 4
    if (length(vars.add)!=1) stop("Added Vars info not correct, please specify by function 'get_vars()' ")
    dt_cell <- dt_cell %>%
      behead("up", year) %>%
      behead("left", province) %>%
      add_column(vars = unname(unlist(vars.add)))
  }

  dt_cell <- dt_cell %>%
    rename(value = chr) %>%
    select(province, year,
           vars, value)
  return(dt_cell)
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

k <- 1
df_all <-NULL
# loop k xls files
for (k in 1: length(path_xls)) {

  wb <- XLConnect::loadWorkbook(path_xls[k], create = TRUE)

  XLConnect::getSheets(wb)
  XLConnect::removeSheet(wb,"CNKI")
  # get the numbers of sheets. It should minus one to drop the last sheet contains only copyright informal .
  sheetnum <- length(XLConnect::getSheets(wb))

  if (sheetnum==0) {
    stop("no files founded, please check file existed")
  }  else{
    print(glue::glue("totally {sheetnum} xls sheet(s) need to unpivot."))
  }

  # j = 1
  df_out <- NULL
  for (j in 1: sheetnum){
    print(glue::glue("begin unpivot the {j} of {sheetnum} xls sheet."))
    # load workbook
    wb <- XLConnect::loadWorkbook(path_xls[k], create = TRUE)
    dt <- XLConnect::readWorksheet(wb, sheet = j,header = F) %>%
      select_if(~ !all(is.na(.)))

    # detect numbers of tables in this sheet
    n_tables <- dt %>%
      mutate_all(.funs = funs(str_detect(., "续表"))) %>%
      unlist() %>%
      sum(na.rm = T) +1

    print(glue::glue("totally {n_tables} pivot table detect in this sheet."))

    # loop tables in sheet
    # i <- 1
    for (i in 1:n_tables) {
      sel_rows <- getRange(dt, ith = i, what = "row")
      sel_cols <- getRange(dt, ith = i, what = "col")

      #header_mode <- c("vars", "vars-vars")
      # livestock tab1: 2011=h4, 2012-2017 =h5
      # livestock tab2: 2011-2017 =h5
      # livestock tab3\4: 2011-2017 =h4
      # livestock tab5: 2011-2017 =h3
      # livestock tab6\tab7: 2011-2017 =h4
      # livestock tab8: 2011-2017 =h4
      if (k %in% c(1:7) ) {
        mode <- header_mode[3]
      } else {
        mode <- header_mode[4]
      }

      tbl_tem <- unpivot(dt = dt,
                         file = file_xls[k],
                         rows = sel_rows,
                         cols = sel_cols,
                         cols.drop = cols_drop,
                         header.mode = mode ,
                         vars.add = vars_spc)
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

df_all <- bind_rows(df_all, df_out)

print(glue::glue("Succesful unpivot file {k}/{length(file_xls)}: {file_xls[k]}") )
Sys.sleep(0.5)

} # end loop k


# usethis::use_data(wfl_unpivot, overwrite = TRUE)
