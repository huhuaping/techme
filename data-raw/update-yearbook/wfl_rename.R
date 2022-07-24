## code to prepare `wfl_rename` dataset goes here

#-----download yearbook dataset----


# -----rename batch files without special characters-----

#' Helper function  rename xls files in directory
#'
#' @param dir character, the directory of files.
#' @param ptn_target_file character,  expression of 'regex' to target files.
#' @param ptn  character, 'regex' expression of string pattern to rename.
#' @param rpl character, 'regex' expression of  string replacement to rename.
#'
#' @export rename_xls_files
#'
#'

rename_xls_files <- function(dir , ptn_target_file,
                             ptn , rpl){
  old_files <- list.files(dir)
  id_sel <- which(str_detect(old_files, ptn_target_file))
  files_sel <- old_files[id_sel]

  names_full <- str_extract(files_sel, "(.+)(?=\\.xlsx)")

  names_new <- str_replace(names_full, ptn, rpl )

  if (length(names_new)>0) {
    print(glue::glue("OK. Your new file name mode is : {names_new[1]}"))
  } else {
    stop("Ops! String replace is not success, check you regex pattern expression!")
    }

  path_old <- paste0(dir,"/",names_full, ".xlsx")
  path_new <- paste0(dir,"/",names_new, ".xlsx")

  # copy old to new
  file.copy(path_old, to = path_new )

  print(glue::glue("copy totally {length(path_old)} old files to directory: {dir}"))

  # remove old files
  #file.remove(path_old)

  #print(glue::glue("remove totally {length(path_old)} old files from directory: {dir}"))

}




# usethis::use_data(wfl_rename, overwrite = TRUE)
