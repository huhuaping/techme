## code to prepare dataset: `PubXmjStandard`

# ==== prepare ====
## load pacakge
source("data-raw/deps/load-dev.R")
source("data-raw/set-global.R")

# ==== file path====
dir_media <- "data-raw/data-tidy/public-site/moa-xmj-standard/"
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
    "year", "index", "area_name", "prod_name", "com_name"
)
df_use <- NULL
for (i in length(files_path):1) {
    df_tem <- openxlsx::read.xlsx(files_path[i]) |>
        dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) |>
        dplyr::mutate(
            area_name = dplyr::if_else(
                area_name %in% c("新疆生产建设兵团", "兵团"),
                "新疆",
                area_name
            )
        )
    print(glue::glue("Reading file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- bind_rows(df_use, df_tem)
}

df_use <- df_use |>
    dplyr::select(dplyr::all_of(header_target))

# 兵团并入新疆后写回 tidy-year，使 data-tidy 与即将入库的表一致
for (year_i in sort(unique(df_use$year))) {
    openxlsx::write.xlsx(
        dplyr::filter(df_use, year == year_i),
        file.path(out_dir, glue::glue("tidy-year-{year_i}.xlsx"))
    )
}

if (interactive()) View(df_use)

# =====name data set=====
PubXmjStandard <- df_use
usethis::use_data(PubXmjStandard,
    overwrite = TRUE
)

# ====write document=====
# R/PubXmjStandard.R 已手写，勿再用 use_r() / document_dt() 覆盖。
source("data-raw/deps/load-dev.R")
devtools::document()

