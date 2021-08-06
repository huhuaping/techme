## code to prepare `wfl_useData` dataset goes here

dir_tidy
files_use <- list.files(dir_tidy)
path_use <- paste0(dir_tidy,"/", files_use)

df_use <- NULL
for ( i in length(files_use):1) {
  df_tem <- openxlsx::read.xlsx(path_use[i])
  print(glue::glue("Export file {files_use[i]} has finished!"))
  Sys.sleep(0.1)
  df_use <- bind_rows(df_use, df_tem)

}

#AgriMachine <- df_use
#AgriFertilizer <- df_use
#AgriPlastic <- df_use
#AgriPesticide <- df_use
PublicBudget <- df_use

#usethis::use_data(AgriMachine, overwrite = TRUE)
#usethis::use_data(AgriFertilizer, overwrite = TRUE)
#usethis::use_data(AgriPlastic, overwrite = TRUE)
#usethis::use_data(AgriPesticide, overwrite = TRUE)
usethis::use_data(PublicBudget, overwrite = TRUE)
