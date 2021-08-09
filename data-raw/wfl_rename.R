## code to prepare `wfl_rename` dataset goes here

#-----download yearbook dataset----


# -----rename batch files without special characters-----
## all change to the same file names.
rename_files_vec <- function(media, final, char_exclude=NA, char_replace){
  require("stringr")
  if (is.na(char_exclude)) stop("Excluded character for file name not set, it is danger to do bantch rename.")

  dir_dest <- glue::glue("{media}{final}")

  path_all <- list.files(dir_dest, full.names = T)
  files_all <- basename(path_all)

  id_not <- which(!str_detect(files_all,
                              paste0("(",char_exclude,".+)(?=\\.)")))

  if (length(id_not)==0) {
    print("No files detect with current reg pattern.")
  } else {
    path_new <- str_replace(path_all[id_not],
                            str_extract(files_all[id_not],".+(?=\\.)"),
                            char_replace)
    files_new <- file.rename(path_all[id_not], path_new )
    print(glue::glue("rename file: \n '{path_all[id_not]}' to \n '{path_new};'"))
  }
}

# example
rpl <- str_extract(file_sel, ".*(?=\\.)")
rename_files_vec(media = dir_media, final = dir_final,
                 char_exclude = "raw",
                 char_replace = rpl)

# usethis::use_data(wfl_rename, overwrite = TRUE)
