## code to prepare `wfl_useData` dataset goes here

#==== file path====
dir_media <- "data-raw/data-tidy/livestock-yearbook/"
dir_fina <- "02-breeding/"
#gen_dirs_vec(dir_media, dir_fina)

out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)
files_id <- which(str_detect(files_all,"year-"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# ====loop read====
df_use <- NULL
for ( i in length(files_path):1) {
  df_tem <- openxlsx::read.xlsx(files_path[i]) %>%
    mutate(units = as.character(units))
  print(glue::glue("Export file {files_sel[i]} has finished!"))
  Sys.sleep(0.1)
  df_use <- bind_rows(df_use, df_tem)

}

# ====match units ====
df_base <- varsList %>%
  select(variables, units) %>%
  rename(units_base = "units")

df_use_units <- left_join(df_use, df_base, by = "variables") %>%
  mutate(units = units_base) %>%
  select(-units_base)

#sum(is.na(df_use_units$units_base))

# =====name data set=====

#AgriMachine <- df_use
#AgriFertilizer <- df_use
#AgriPlastic <- df_use
#AgriPesticide <- df_use
#PublicBudget <- df_use
#RDIntense <- df_use
#RDActivity <- df_use
#MarketPull <- df_use
#MarketPush <- df_use
#HitechFirmsPub <- df_use
#IndustryTrade <- df_use
#IndustryRD <- df_use
#IndustryOperation <- df_use
LivestockBreeding <- df_use_units

#usethis::use_data(AgriMachine, overwrite = TRUE)
#usethis::use_data(AgriFertilizer, overwrite = TRUE)
#usethis::use_data(AgriPlastic, overwrite = TRUE)
#usethis::use_data(AgriPesticide, overwrite = TRUE)
#usethis::use_data(PublicBudget, overwrite = TRUE)
#usethis::use_data(RDIntense, overwrite = TRUE)
#usethis::use_data(RDActivity, overwrite = TRUE)
#usethis::use_data(MarketPull, overwrite = TRUE)
#usethis::use_data(MarketPush, overwrite = TRUE)
#usethis::use_data(HitechFirmsPub, overwrite = TRUE)
#usethis::use_data(IndustryTrade, overwrite = TRUE)
#usethis::use_data(IndustryRD, overwrite = TRUE)
#usethis::use_data(IndustryOperation, overwrite = TRUE)
usethis::use_data(LivestockBreeding, overwrite = TRUE)

# ====write document=====
require(devtools)
load_all()
use_r("Livestock-Breeding.R")
document_dt(LivestockBreeding)
document()

