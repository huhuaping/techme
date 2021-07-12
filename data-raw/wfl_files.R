## code to prepare `wfl_files` dataset goes here

#-----construct file system and dir path----

#dir_final <- c("01-machine", "02-fertilizer","03-plastic", "04-pesticide")
#dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"

#dir_final <- c("01-labor-hour", "02-spend-intense","03-spend-inner", "05-public-professionals")
#dir_media <- "data-raw/tech-yearbook/part01-over/"

#dir_final <- c("yearbook-01-activity", "yearbook-02-source","yearbook-03-purpose")
#dir_media <- "data-raw/tech-yearbook/part01-over/03-spend-inner/"

#dir_final <- c("00-firms", "01-employee","03-spend-inner", "04-spend-outer",
#               "05-RD-projects","06-RD-institution","07-new-product",
#               "08-patent","09-tech-renew")
#dir_media <- "data-raw/tech-yearbook/part02-firm/"

#dir_final <- c("01-operation", "02-RD")
#dir_media <- "data-raw/tech-yearbook/part05-industry/"

#dir_final <- c("01-patent", "02-enrollmark","03-teckmarket-pull", "04-teckmarket-push")
#dir_media <- "data-raw/tech-yearbook/part08-output/"

dir_final <- c("01-public-income", "02-public-budget")
dir_media <- "data-raw/nation-yearbook/part07-finance/"

file_dir <- glue::glue("{dir_media}{dir_final}")


#i_sel <- 1 # default the first directory
dir_sel <- file_dir[i_sel]
#file_sel <- "raw-2018-2019.xls"
file_xls <- file_sel
path_xls <- glue::glue("{dir_sel}/{file_xls}")



#usethis::use_data(wfl_files, overwrite = TRUE)
