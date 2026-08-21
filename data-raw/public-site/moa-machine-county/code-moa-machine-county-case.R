# code to prepare dataset `PubMachineCountyCase`
## read each yearly batch yaml files, such as
## `data-raw/public-site/moa-machine-county/html/case-year-2025-batch05.yaml`
## convert each yaml file into a data frame, and tidy the data frame, and include columns:
## - 文件年份 year, 批次 batch, 类别 category, 序号 id， 类别内部序号 index, 名称 title, 省份 province, 地区 place, 作物 crop
## - 重命名类别内部序号index为order,
## - 重命名id为年度序号index
## save as xlsx file to both raw and tidy data directories:
## - for raw data, save to `data-raw/public-site/moa-machine-county/xlsx/case-year-${year}-batch${batch}.xlsx`
## - for tidy data, save to `data-raw/data-tidy/public-site/moa-machine-county/xlsx/case-year-${year}-batch${batch}.xlsx`

## 准备R包----
source("data-raw/deps/load-core.R")
require("here")
require("glue")
require("openxlsx")
require("yaml")

## YAML 嵌套读取----
## 文件顶层是公示元数据（year/batch 等标量），名单在 cases 列表里。
## yaml::read_yaml() 会把 YAML null 收成 NULL，先转成 NA 再逐条拼行。

# 标量字段：null 或空 → NA
yaml_chr <- function(x) {
  if (is.null(x) || length(x) == 0L) NA_character_ else as.character(x)
}
yaml_int <- function(x) {
  if (is.null(x) || length(x) == 0L) NA_integer_ else as.integer(x)
}

# 读一份公示 yaml：顶层 year/batch 挂到每一行，再展开 cases
read_case_yaml <- function(path) {
  yml <- yaml::read_yaml(path)
  if (is.null(yml$cases) || length(yml$cases) == 0L) {
    stop("YAML 缺少嵌套的 cases 列表：", path)
  }

  # 每条 case 是独立 named list，按字段逐项取出
  df_cases <- purrr::map(yml$cases, function(item) {
    tibble::tibble(
      id = yaml_int(item$id),
      category = yaml_chr(item$category),
      index = yaml_int(item$index),
      title = yaml_chr(item$title),
      province = yaml_chr(item$province),
      place = yaml_chr(item$place),
      crop = yaml_chr(item$crop)
    )
  }) |>
    purrr::list_rbind()

  df_cases |>
    dplyr::mutate(
      year = yaml_int(yml$year),
      batch = yaml_int(yml$batch),
      .before = 1
    ) |>
    dplyr::rename(order = index, index = id) |>
    dplyr::select(
      year, batch, category, index, order,
      title, province, place, crop
    )
}

## 确定路径----
dir_html <- here::here("data-raw", "public-site", "moa-machine-county", "html")
dir_raw <- here::here("data-raw", "public-site", "moa-machine-county", "xlsx")
dir_tidy <- here::here("data-raw", "data-tidy", "public-site", "moa-machine-county", "xlsx")
fs::dir_create(dir_raw)
fs::dir_create(dir_tidy)

files_yaml <- list.files(
  path = dir_html,
  pattern = "^case-year-\\d{4}-batch\\d{2}\\.yaml$",
  full.names = TRUE
)
if (length(files_yaml) == 0L) {
  stop("未找到 case-year-*.yaml，请检查：", dir_html)
}
files_yaml <- sort(files_yaml)

## 逐份 yaml 展开并写出 xlsx----
df_all <- NULL
i <- 1L
for (i in seq_along(files_yaml)) {
  file_yaml <- files_yaml[[i]]
  df_out <- read_case_yaml(file_yaml)

  year <- unique(df_out$year)
  batch <- unique(df_out$batch)
  if (length(year) != 1L || length(batch) != 1L) {
    stop("year/batch 不是单一值：", file_yaml)
  }

  # 批次补成两位，与 yaml 文件名 batch01 对齐
  file_xlsx <- glue::glue("case-year-{year}-batch{sprintf('%02d', batch)}.xlsx")
  openxlsx::write.xlsx(df_out, fs::path(dir_raw, file_xlsx))
  openxlsx::write.xlsx(df_out, fs::path(dir_tidy, file_xlsx))
  message(glue::glue("已写出 {file_xlsx}（{nrow(df_out)} 条）"))

  df_all <- dplyr::bind_rows(df_all, df_out)
}

# 交互检查点：合并后的历年案例表
if (interactive()) View(df_all)
message(glue::glue("合计 {nrow(df_all)} 条，覆盖 {dplyr::n_distinct(df_all$year)} 个年份"))
