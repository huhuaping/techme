## code to prepare `wfl_genDirs` dataset goes here
# -----generate batch directories------
#' Generate batch directories
#'
#' @param media character. First part of director path, with dash '/' at the end
#' @param final vector. Bundle of  final directory name, without dash '/'.
#'
#' @return NULL
#' @export gen_dirs_vec
#'
#' @examples
#' dir_final <- c("01-machine",
#'   "02-fertilizer",
#'   "03-plastic",
#'   "04-pesticide",
#'   "05-test")
#'   dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"
#'
#' gen_dirs_vec(media = dir_media, final = dir_final)
#'
gen_dirs_vec <- function(media,final){
  file_dir <- glue::glue("{media}{final}")
  #unlink(file_dir, recursive = T)
  # create file directory
  sl <- sapply(file_dir, FUN = dir.create,recursive = T)
  warn_list <- utils::warnErrList(sl)
  if (length(warn_list)!=0){
    warn_list
  } else {
    print(glue::glue("Generate directores successfully." ))
  }
}

gen_dirs_vec(media = dir_media, final = dir_final)

# usethis::use_data(wfl_genDirs, overwrite = TRUE)
