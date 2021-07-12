## code to prepare `wfl_files` dataset goes here

#-----construct file system and dir path----

dir_final <- c("01-machine",
               "02-fertilizer",
               "03-plastic",
               "04-pesticide")
dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"

file_dir <- glue::glue("{dir_media}{dir_final}")


#i_sel <- 1 # default the first directory
dir_sel <- file_dir[i_sel]
#file_sel <- "raw-2018-2019.xls"
file_xls <- file_sel
path_xls <- glue::glue("{dir_sel}/{file_xls}")



#usethis::use_data(wfl_files, overwrite = TRUE)
