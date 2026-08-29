## 脚本目标：根据a.国家农作物种质资源库(圃)批次公示文件，以及b.国家畜禽遗传资源保种场名单、基因库批次公示文件
## 整理清洗后形成标准化变量名称的xlsx文件，存放到`data-raw/data-tidy/public-site/moa-genetic-resource/xlsx/`目录下。
## 公示文件说明：
### a.国家农作物种质资源库(圃)批次公示文件：年度公示文件内一般包括2个公示类别：国家农作物种质资源圃、国家农业微生物种质资源库。
### b.国家畜禽遗传资源保种场名单、基因库批次公示文件：年度公示文件内一般包括2个公示类别：国家畜禽遗传资源保种场名单、国家畜禽遗传资源基因库名单。

## 目标变量：year（年份）	batch（批次）	type（类型：畜禽保种场 / 畜禽基因库 / 畜禽保护区 / 畜禽变更）	index（序号）	name（名称）	institution（机构）	province（省份）。

## 脚本思路（只针对2024年以前的国家畜禽遗传资源保种场名单、基因库批次公示文件）：
### 2023年文件`data-raw/public-site/moa-genetic-resource/html/list-livestock-year-2023.html`（表格文件）
### 2022年文件`data-raw/public-site/moa-genetic-resource/html/list-livestock-year-2022.html`及pdf扫描文件附件
### 2021年文件`data-raw/public-site/moa-genetic-resource/html/list-livestock-year-2021.html`及pdf扫描文件附件

## 1. （不编写R代码）根据初始公示文件，让Cursor agent提取公示信息，并整理为yaml文件，放到`data-raw/public-site/moa-genetic-resource/yaml/list-livestock-year-xxxx.yaml`目录下。这个步骤完全使用LLM模型，不要编写任何R代码。
## 2. （此处编写R代码）读取yaml文件，清洗形成标准化变量名称的xlsx文件，放到`data-raw/public-site/moa-genetic-resource/xlsx/list-livestock-year-xxxx.xlsx`目录下。
## 3. （此处编写R代码）将标准化变量名称的xlsx文件进一步清洗，存放到`data-raw/data-tidy/public-site/moa-genetic-resource/xlsx/list-livestock-year-xxxx.xlsx`目录下。

## 准备R包----
# 从仓库根目录运行。load-core 加载 dplyr/stringr/purrr 等；yaml/openxlsx/here/fs 本脚本再用。
source("data-raw/deps/load-core.R")
require("here")
require("glue")
require("openxlsx")
require("yaml")
require("fs")

## YAML 标量：null / 空 → NA，再统一成字符，与现有 list-year-*.xlsx 列类型对齐
yaml_chr <- function(x) {
  if (is.null(x) || length(x) == 0L) NA_character_ else as.character(x)
}

yaml_int <- function(x) {
  if (is.null(x) || length(x) == 0L) NA_integer_ else as.integer(x)
}

# 单条 named list 收成 list-of-lists；空节点给空 list，避免 for 循环拆成字段。
as_yaml_seq <- function(x) {
  if (is.null(x) || length(x) == 0L) {
    return(list())
  }
  nms <- names(x)
  if (!is.null(nms) &&
      any(nms %in% c(
        "index", "items", "mark", "annex", "type",
        "name", "institution", "batch", "code"
      ))) {
    return(list(x))
  }
  x
}

# 批次保持两位字符（01/02/03）；yaml 可能把 01 读成整数 1
pad_batch <- function(x) {
  batch <- yaml_chr(x)
  if (is.na(batch)) {
    return(batch)
  }
  stringr::str_pad(batch, width = 2L, side = "left", pad = "0")
}

# 第 2 步省份：兵团并入新疆；其余保持 YAML 已有简称
norm_province <- function(x) {
  prov <- yaml_chr(x)
  if (is.na(prov)) {
    return(prov)
  }
  if (prov %in% c("新疆生产建设兵团", "兵团")) {
    return("新疆")
  }
  prov
}

# 读一份 list-livestock-year-{YYYY}.yaml：annexes → items 展开为 7 列
expand_livestock_yaml <- function(path) {
  yml <- yaml::read_yaml(path)
  if (is.null(yml$annexes) || length(yml$annexes) == 0L) {
    stop("YAML 缺少 annexes：", path)
  }

  rows <- list()
  for (ax in as_yaml_seq(yml$annexes)) {
    type <- yaml_chr(ax$type)
    for (it in as_yaml_seq(ax$items)) {
      rows[[length(rows) + 1L]] <- tibble::tibble(
        year = yaml_chr(yml$year),
        batch = pad_batch(it$batch),
        type = type,
        index = yaml_chr(it$index),
        name = yaml_chr(it$name),
        institution = yaml_chr(it$institution),
        province = norm_province(it$province)
      )
    }
  }

  if (length(rows) == 0L) {
    stop("展开后 0 行：", path)
  }

  df_out <- dplyr::bind_rows(rows) |>
    dplyr::select(year, batch, type, index, name, institution, province)

  n_yml <- yaml_int(yml$counts[["合计"]])
  if (!is.na(n_yml) && n_yml != nrow(df_out)) {
    warning(
      glue::glue("{basename(path)} counts$合计={n_yml}，展开 {nrow(df_out)} 行"),
      call. = FALSE
    )
  }

  df_out
}

# 第 3 步：全部转字符，去掉换行/不换行空格，再 trim
tidy_livestock_tbl <- function(df_raw) {
  df_raw |>
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) |>
    dplyr::mutate(
      dplyr::across(
        dplyr::everything(),
        ~ stringr::str_replace_all(.x, "[\r\n\u00a0]", "")
      )
    ) |>
    dplyr::mutate(
      dplyr::across(dplyr::everything(), ~ stringr::str_trim(.x, side = "both"))
    ) |>
    dplyr::mutate(batch = stringr::str_pad(batch, width = 2L, side = "left", pad = "0")) |>
    dplyr::select(year, batch, type, index, name, institution, province)
}

## 确定路径----
dir_yaml <- here::here("data-raw", "public-site", "moa-genetic-resource", "yaml")
dir_xlsx <- here::here("data-raw", "public-site", "moa-genetic-resource", "xlsx")
dir_tidy <- here::here("data-raw", "data-tidy", "public-site", "moa-genetic-resource", "xlsx")
fs::dir_create(dir_xlsx)
fs::dir_create(dir_tidy)

# 只读畜禽 YAML，不要碰到农作物 list-year-*.yaml
files_yaml <- list.files(
  path = dir_yaml,
  pattern = "^list-livestock-year-\\d{4}\\.yaml$",
  full.names = TRUE
)
if (length(files_yaml) == 0L) {
  stop("未找到 list-livestock-year-*.yaml，请检查：", dir_yaml)
}
files_yaml <- sort(files_yaml)

## 2. yaml → xlsx/list-livestock-year-{YYYY}.xlsx----
# 不要覆盖本目录已有农作物 list-year-*-batch-*.xlsx。
df_all <- NULL
for (file_yaml in files_yaml) {
  year_file <- as.integer(stringr::str_extract(basename(file_yaml), "\\d{4}"))
  if (is.na(year_file) || year_file < 2021L || year_file > 2023L) {
    next
  }

  df_out <- expand_livestock_yaml(file_yaml)
  file_xlsx <- glue::glue("list-livestock-year-{year_file}.xlsx")
  path_xlsx <- fs::path(dir_xlsx, file_xlsx)
  openxlsx::write.xlsx(df_out, path_xlsx)
  message(glue::glue("已写出 {file_xlsx}（{nrow(df_out)} 条）"))

  n_na_prov <- sum(is.na(df_out$province) | df_out$province == "")
  if (n_na_prov > 0L) {
    message(glue::glue("  其中 province 为空 {n_na_prov} 条"))
  }

  df_all <- dplyr::bind_rows(df_all, df_out)
}

if (is.null(df_all) || nrow(df_all) == 0L) {
  stop("第 2 步没有写出任何年份，请检查 yaml 是否覆盖 2021–2023。")
}

if (interactive()) View(df_all)
message(glue::glue(
  "第 2 步合计 {nrow(df_all)} 条，覆盖 {dplyr::n_distinct(df_all$year)} 个年份"
))

## 3. xlsx → data-tidy/.../list-livestock-year-{YYYY}.xlsx----
# 只读上一步写出的 list-livestock-year-{YYYY}.xlsx，不再解析 yaml。
df_tidy_all <- NULL
years_out <- sort(unique(as.integer(df_all$year)))
for (year_i in years_out) {
  path_xlsx <- fs::path(dir_xlsx, glue::glue("list-livestock-year-{year_i}.xlsx"))
  if (!file.exists(path_xlsx)) {
    stop("缺少第 2 步产物：", path_xlsx)
  }

  df_raw <- openxlsx::read.xlsx(path_xlsx)
  df_tidy <- tidy_livestock_tbl(df_raw)
  file_tidy <- glue::glue("list-livestock-year-{year_i}.xlsx")
  openxlsx::write.xlsx(df_tidy, fs::path(dir_tidy, file_tidy))
  message(glue::glue("已写出 data-tidy {file_tidy}（{nrow(df_tidy)} 条）"))

  df_tidy_all <- dplyr::bind_rows(df_tidy_all, df_tidy)
}

if (interactive()) View(df_tidy_all)
message(glue::glue(
  "第 3 步合计 {nrow(df_tidy_all)} 条，覆盖 {dplyr::n_distinct(df_tidy_all$year)} 个年份"
))

