## code to prepare `wfl_rename` dataset goes here

#-----download yearbook dataset----

# -----generate batch directories------
gen_dirs_vec<- function(media,final){
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

# examples
dir_final <- c("01-machine",
               "02-fertilizer",
               "03-plastic",
               "04-pesticide",
               "05-test")
dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"
gen_dirs_vec(media = dir_media,
                final = dir_final)
length("")
# -----rename batch files without special characters-----
## all change to the same file names.
renmae_files_vec<- function(media, final, char_exclude=NA, char_replace){
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
renmae_files_vec(dir_media, dir_final, "raw", "my-raw")

# usethis::use_data(wfl_rename, overwrite = TRUE)
