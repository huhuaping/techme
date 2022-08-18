## code to prepare `wfl_useData_HitechFirms` dataset goes here

# ==== prepare ====
## load pacakge
require(devtools)
load_all()
source("data-raw/set-global.R")

#==== file path====
dir_media <- "data-raw/data-tidy/public-site/torch-innocom/"
dir_fina <- "xlsx/"
#gen_dirs_vec(dir_media, dir_fina)

out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)
files_id <- which(str_detect(files_all,"year-"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# ====loop read====
df_use <- NULL
for ( i in length(files_path):1) {
  df_tem <- openxlsx::read.xlsx(files_path[i]) #%>%
    #mutate(units = as.character(units))
  print(glue::glue("Export file {files_sel[i]} has finished!"))
  Sys.sleep(0.1)
  df_use <- bind_rows(df_use, df_tem)

}


# =====name data set=====
HitechFirmsPub <- df_use
usethis::use_data(HitechFirmsPub,
                  overwrite = TRUE)

# ====write document=====
require(devtools)
load_all()
use_r("tech-HitechFirmsPub.R")
document_dt(tech-HitechFirmsPub)
document()

