## code to prepare `wfl_files` dataset goes here

#-----construct file system and dir path----

dir_final <- c("01-machine",
               "02-fertilizer",
               "03-plastic",
               "04-pesticide")
dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"

file_dir <- glue::glue("{dir_media}{dir_final}")


#unlink(file_dir, recursive = T)
# create file directory
sapply(file_dir, FUN = dir.create,recursive = T)

i <- 2
dir_sel <- file_dir[i]
#path_xls <- "data-raw/MyFile.xls"
file_xls <- "raw-2018-2019.xls"
path_xls <- glue::glue("{dir_sel}/{file_xls}")

#usethis::use_data(wfl_files, overwrite = TRUE)
