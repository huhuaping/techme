#' Read all tidy xlsx files by loop
#'
#' @param dir.media character vector.
#' @param dir.fina  character vector. must be end with '/'
#' @param file.pattern character. regex pattern for target files.
#'
#' @return data.frame
#' @export loop_read
#'
#' @examples
#' dir_media <- "data-raw/data-tidy/rural-yearbook/part03-agri-produce/"
#' dir_fina <- "01-machine/"
#' df_use <- loop_read(dir.media = dir_media,
#'                     dir.fina =dir_fina,
#'                     file.pattern = "\\d{4}")

loop_read <- function(dir.media = dir_media,
                      dir.fina =dir_fina,
                      file.pattern = "\\d{4}" ){
  out_dir <- paste0(dir.media, dir.fina,"/")
  files_all <- list.files(out_dir)
  files_id <- which(str_detect(files_all, file.pattern))
  files_sel <- files_all[files_id]
  files_path <- paste0(out_dir, files_sel)

  n_files <- length(files_path)
  print(glue::glue("totally {n_files} files to read! \n"))

  # loop read
  df_use <- NULL
  for ( i in n_files:1) {
    df_tem <- openxlsx::read.xlsx(files_path[i])
    print(glue::glue("Export file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- bind_rows(df_use, df_tem)
  } # end loop
  return(df_use)
}




#' Match units to base varsList
#'
#' @param df data.frame. data set which is  tidy ready.
#'
#' @return
#' @export
#'
#' @examples
#' df_units <- match_units(df = df_use)

match_units <- function(df){
  #devtools::load_all()
  data("varsList")
  df_base <- varsList %>%
    select(variables, units) %>%
    rename(units_base = "units")

  df_units <- left_join(df, df_base, by = "variables") %>%
    mutate(units = units_base) %>%
    select(-units_base)

  return(df_units)
}


#sum(is.na(df_use_units$units_base))

# name data set


#' Use my specified data.frame by use_data()
#'
#' @param name.dt character. target name for rds file
#' @param which.dt character. which data set to use
#'
#' @return
#' @export use_mydata
#'
#' @examples
#' name_dt <- "AgriMachine"
#' which_dt <- "df_use"
#' use_mydata(name.dt = name_dt,
#'            which.dt = which_dt)

use_mydata <- function(name.dt = name_dt,
                       which.dt = which_dt){
  ## assign data table
  do.call("assign", list(name.dt, as.name(which_dt)))
  print("assign data set successed!")
  ## use data
  do.call("use_data", list(as.name(name.dt), overwrite = TRUE))
  print("use_data() successed!")
}


