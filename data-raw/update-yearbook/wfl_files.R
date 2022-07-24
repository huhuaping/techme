## code to prepare `wfl_files` dataset goes here


#-----construct file system and dir path----
file_dir <- glue::glue("{dir_media}{dir_final}")

#i_sel <- 1 # default the first directory
dir_sel <- file_dir[i_sel]
files_all <- list.files(dir_sel)
file_xls <- files_all[which(str_detect(files_all, pattern_sel ))]
path_xls <- glue::glue("{dir_sel}/{file_xls}")



