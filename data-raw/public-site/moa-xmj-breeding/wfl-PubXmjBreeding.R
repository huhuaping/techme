## code to prepare dataset: `PubXmjBreeding`

# ==== prepare ====
## load pacakge
source("data-raw/deps/load-dev.R")
source("data-raw/set-global.R")

# ==== file path====
dir_media <- "data-raw/data-tidy/public-site/moa-xmj-breeding/"
dir_fina <- "xlsx/"
# gen_dirs_vec(dir_media, dir_fina)

out_dir <- here::here(paste0(dir_media, dir_fina))
files_all <- list.files(out_dir)
# choose file pattern
pattern_select <- c("tidy-year-\\d{4}")
(files_id <- which(str_detect(files_all, pattern_select[1])))
(files_sel <- files_all[files_id])
files_path <- paste0(out_dir, "/", files_sel)

# ====loop read====
# 与 2010–2020 tidy 对齐：全部转字符，避免 openxlsx 把部分年份读成数值后 bind_rows 失败
header_target <- c(
    "year", "index", "province", "type",
    "name_origin", "name_change", "mark"
)
df_use <- NULL
for (i in length(files_path):1) {
    df_tem <- openxlsx::read.xlsx(files_path[i]) |>
        dplyr::mutate(dplyr::across(dplyr::everything(), as.character))
    print(glue::glue("Reading file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- bind_rows(df_use, df_tem)
}

df_use <- df_use |>
    dplyr::select(dplyr::all_of(header_target))

if (interactive()) View(df_use)

# =====name data set=====
PubXmjBreeding <- df_use
usethis::use_data(PubXmjBreeding,
    overwrite = TRUE
)

# ====write document=====
source("data-raw/deps/load-dev.R")
usethis::use_r("PubXmjBreeding")
document_dt(PubXmjBreeding) # for new data set
devtools::document()

