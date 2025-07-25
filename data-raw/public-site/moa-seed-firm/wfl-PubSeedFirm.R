## code to prepare `wfl_useData_PubSeedFirm` dataset goes here

# ==== prepare ====
## load pacakge
require(devtools)
load_all()
source("data-raw/set-global.R")

# ==== file path====
dir_media <- "data-raw/data-tidy/public-site/moa-seed-firm/"
dir_fina <- "data-update/"
# gen_dirs_vec(dir_media, dir_fina)

out_dir <- here::here(paste0(dir_media, dir_fina))
files_all <- list.files(out_dir)
files_id <- which(str_detect(files_all, "upto-\\d{4}"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, "/", files_sel)

# ====loop read====
df_use <- NULL
# i <- 1
for (i in length(files_path):1) {
    df_tem <- read_rds(files_path[i]) %>%
        add_column(date_upto = str_extract(files_sel[i], "\\d{4}-\\d{2}-\\d{2}"), .before = 1)
    print(glue::glue("Export file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- bind_rows(df_use, df_tem)
}

View(df_use)
# View(df_tem)
# =====name data set=====
PubSeedFirm <- df_use
usethis::use_data(PubSeedFirm,
    overwrite = TRUE
)

# ====write document=====
require(devtools)
load_all()
use_r("PubSeedFirm.R")
document_dt(PubSeedFirm)
document()
