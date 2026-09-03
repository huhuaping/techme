## code to prepare dataset: `PubAgrimodernZone`

# ==== prepare ====
## load pacakge
source("data-raw/deps/load-dev.R")
source("data-raw/set-global.R")

# ==== file path====
dir_media <- "data-raw/data-tidy/public-site/moa-agrimodern-zone/"
dir_fina <- "xlsx/"
# gen_dirs_vec(dir_media, dir_fina)

out_dir <- here::here(paste0(dir_media, dir_fina))
files_all <- list.files(out_dir)
# 第 3 步产物：list-year-{YYYY}.xlsx
pattern_select <- c("list-year-\\d{4}")
(files_id <- which(stringr::str_detect(files_all, pattern_select[1])))
(files_sel <- files_all[files_id])
if (length(files_sel) == 0L) {
    stop("未找到 list-year-*.xlsx，请先跑 code-moa-agrimodern-zone.R：", out_dir)
}
files_path <- paste0(out_dir, "/", files_sel)

# ====loop read====
header_target <- c("year", "index", "name", "province")
df_use <- NULL
for (i in length(files_path):1) {
    df_tem <- openxlsx::read.xlsx(files_path[i]) |>
        dplyr::mutate(
            year = as.integer(year),
            index = as.integer(index),
            name = as.character(name),
            province = as.character(province)
        ) |>
        dplyr::select(dplyr::all_of(header_target))
    print(glue::glue("Read file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- dplyr::bind_rows(df_use, df_tem)
}

if (interactive()) View(df_use)

# =====name data set=====
PubAgrimodernZone <- df_use
usethis::use_data(PubAgrimodernZone,
    overwrite = TRUE
)

# ====write document=====
# R/PubAgrimodernZone.R 已手写，勿再用 use_r() / document_dt() 覆盖。
source("data-raw/deps/load-dev.R")
devtools::document()
