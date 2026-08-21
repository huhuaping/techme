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
pattern_select <- c("list-year-\\d{4}", "list-crops-year-\\d{4}")
(files_id <- which(str_detect(files_all, pattern_select[2])))
(files_sel <- files_all[files_id])
files_path <- paste0(out_dir, "/", files_sel)

# ====loop read====
df_use <- NULL
for (i in length(files_path):1) {
    df_tem <- openxlsx::read.xlsx(files_path[i]) # %>%
    # mutate(administrator = as.character(administrator))
    print(glue::glue("Read file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- bind_rows(df_use, df_tem)
}

View(df_use)

# =====name data set=====
# PubGeneticResource <- df_use
PubGeneticResourceCrop <- df_use
usethis::use_data(PubGeneticResourceCrop,
    overwrite = TRUE
)

# ====write document=====
source("data-raw/deps/load-dev.R")
use_r("PubGeneticResourceCrop.R")
document_dt(PubGeneticResourceCrop)
document()
