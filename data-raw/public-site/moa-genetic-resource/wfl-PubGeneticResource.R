## code to prepare `wfl_useData_PubGeneticResource` dataset goes here

# ==== prepare ====
## load pacakge
source("data-raw/deps/load-dev.R")
source("data-raw/set-global.R")

# ==== file path====
dir_media <- "data-raw/data-tidy/public-site/moa-genetic-resource/"
dir_fina <- "xlsx/"
# gen_dirs_vec(dir_media, dir_fina)

out_dir <- here::here(paste0(dir_media, dir_fina))
files_all <- list.files(out_dir)
# choose file pattern
## list-year-\\d{4} for PubGeneticResource
## list-crops-year-\\d{4} for PubGeneticResourceCrop
pattern_select <- c(
    "list-year-\\d{4}", # PubGeneticResource for crops and livestock (start from 2022)
    "list-livestock-year-\\d{4}", # PubGeneticResource for livestock (year 2021 to 2023 only)
    "list-crops-year-\\d{4}") # PubGeneticResourceCropfor annual crops full list (start from 2026)
(files_id <- which(!str_detect(files_all, pattern_select[3])))
(files_sel <- files_all[files_id])
files_path <- paste0(out_dir, "/", files_sel)

# ====loop read====
df_use <- NULL
for (i in length(files_path):1) {
    df_tem <- openxlsx::read.xlsx(files_path[i]) |>
    dplyr::mutate(year = as.integer(year), index = as.integer(index))
    print(glue::glue("Read file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- dplyr::bind_rows(df_use, df_tem)
}

View(df_use)

# =====name data set=====
# PubGeneticResource <- df_use
PubGeneticResource <- df_use
usethis::use_data(PubGeneticResource,
    overwrite = TRUE
)

# ====write document=====
source("data-raw/deps/load-dev.R")
use_r("PubGeneticResource.R")
document_dt(PubGeneticResource)
document()
