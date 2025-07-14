## code to prepare `wfl_useData_HitechFirms` dataset goes here

# ==== prepare ====
## load pacakge
require(devtools)
load_all()
source("data-raw/set-global.R")

# ==== file path====
dir_media <- "data-raw/data-tidy/public-site/most-jcs-open-share/"
dir_fina <- "xlsx/"
# gen_dirs_vec(dir_media, dir_fina)

out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)
files_id <- which(str_detect(files_all, "eval-\\d{4}"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# ====loop read====
df_use <- NULL
for (i in length(files_path):1) {
    df_tem <- openxlsx::read.xlsx(files_path[i]) %>%
        mutate(administrator = as.character(administrator))
    print(glue::glue("Export file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- bind_rows(df_use, df_tem)
}


# =====name data set=====
PubOpenShare <- df_use
usethis::use_data(PubOpenShare,
    overwrite = TRUE
)

# ====write document=====
require(devtools)
load_all()
use_r("PubOpenShare.R")
document_dt(PubOpenShare)
document()
