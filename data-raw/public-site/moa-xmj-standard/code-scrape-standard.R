## 脚本目标：根据畜禽养殖标准化示范场初始公示文件，整理清洗后形成标准化变量名称的xlsx文件，存放到`data-raw/data-tidy/public-site/moa-xmj-standard/xlsx/`目录下。
## 公示文件说明：年度公示文件内一般包括2个公示类别：认定名单、复验通过名单。其中认定名单公示文件内，一般包括多个畜禽品种养殖场等的公示信息。本次数据集维护仅针对认定名单，不处理复验通过名单。

## 目标变量：year(年份)	index(序号)	area_name(省份)	prod_name(畜禽品种名称)	com_name(养殖场名称)


## 脚本思路（只针对2021年及其以后的认定名单公示文件）：
## 1. （不编写R代码）根据初始公示文件，让Cursor agent提取公示信息，并整理为yaml文件，放到`data-raw/public-site/moa-xmj-standard/yaml/`目录下。这个步骤完全使用LLM模型，不要编写任何R代码。
## 2. （此处编写R代码）读取yaml文件，清洗形成标准化变量名称的xlsx文件，放到`data-raw/public-site/moa-xmj-standard/xlsx/`目录下。
### 省份处理，如新疆生产建设兵团，需要单独处理为“新疆”。
## 3. （此处编写R代码）将标准化变量名称的xlsx文件进一步清洗，存放到`data-raw/data-tidy/public-site/moa-xmj-standard/xlsx/`目录下。

## 准备R包----
# 从仓库根目录运行。load-core 加载 dplyr/stringr/purrr 等；yaml/openxlsx/here/fs 本脚本再用。
source("data-raw/deps/load-core.R")
require("here")
require("glue")
require("openxlsx")
require("yaml")
require("fs")

## YAML 标量：null / 空 → NA，再统一成字符，与 2010–2020 year-*.xlsx 列类型对齐
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
        "index", "items", "mark", "groups", "annex",
        "area_name", "prod_name", "com_name"
      ))) {
    return(list(x))
  }
  x
}

# 第 2 步省份：兵团并入新疆，其余 area_name 保持公示原文
norm_area_name <- function(x) {
  area <- yaml_chr(x)
  if (is.na(area)) {
    return(area)
  }
  if (area %in% c("新疆生产建设兵团", "兵团")) {
    return("新疆")
  }
  area
}

# 读一份 year-{YYYY}.yaml：annexes → groups → items 展开为 5 列
expand_standard_yaml <- function(path) {
  yml <- yaml::read_yaml(path)
  if (is.null(yml$annexes) || length(yml$annexes) == 0L) {
    stop("YAML 缺少 annexes：", path)
  }

  rows <- list()
  for (ax in as_yaml_seq(yml$annexes)) {
    for (g in as_yaml_seq(ax$groups)) {
      area_name <- norm_area_name(g$area_name)
      for (it in as_yaml_seq(g$items)) {
        rows[[length(rows) + 1L]] <- tibble::tibble(
          year = yaml_chr(yml$year),
          index = yaml_chr(it$index),
          area_name = area_name,
          prod_name = yaml_chr(it$prod_name),
          com_name = yaml_chr(it$com_name)
        )
      }
    }
  }

  if (length(rows) == 0L) {
    stop("展开后 0 行：", path)
  }

  df_out <- dplyr::bind_rows(rows) |>
    dplyr::select(year, index, area_name, prod_name, com_name)

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
tidy_standard_tbl <- function(df_raw) {
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
    dplyr::select(year, index, area_name, prod_name, com_name)
}

## 确定路径----
dir_yaml <- here::here("data-raw", "public-site", "moa-xmj-standard", "yaml")
dir_xlsx <- here::here("data-raw", "public-site", "moa-xmj-standard", "xlsx")
dir_tidy <- here::here("data-raw", "data-tidy", "public-site", "moa-xmj-standard", "xlsx")
fs::dir_create(dir_xlsx)
fs::dir_create(dir_tidy)

files_yaml <- list.files(
  path = dir_yaml,
  pattern = "^year-\\d{4}\\.yaml$",
  full.names = TRUE
)
if (length(files_yaml) == 0L) {
  stop("未找到 year-*.yaml，请检查：", dir_yaml)
}
files_yaml <- sort(files_yaml)

## 2. yaml → xlsx/year-{YYYY}.xlsx----
# 只处理 2021 年起；不要覆盖本目录历史 year-2010.xlsx 等。
df_all <- NULL
for (file_yaml in files_yaml) {
  year_file <- as.integer(stringr::str_extract(basename(file_yaml), "\\d{4}"))
  if (is.na(year_file) || year_file < 2021L) {
    next
  }

  df_out <- expand_standard_yaml(file_yaml)
  file_xlsx <- glue::glue("year-{year_file}.xlsx")
  path_xlsx <- fs::path(dir_xlsx, file_xlsx)
  openxlsx::write.xlsx(df_out, path_xlsx)
  message(glue::glue("已写出 {file_xlsx}（{nrow(df_out)} 条）"))

  n_na_area <- sum(is.na(df_out$area_name) | df_out$area_name == "")
  if (n_na_area > 0L) {
    message(glue::glue("  其中 area_name 为空 {n_na_area} 条"))
  }

  df_all <- dplyr::bind_rows(df_all, df_out)
}

if (is.null(df_all) || nrow(df_all) == 0L) {
  stop("第 2 步没有写出任何年份，请检查 yaml 是否覆盖 2021 及以后。")
}

if (interactive()) View(df_all)
message(glue::glue(
  "第 2 步合计 {nrow(df_all)} 条，覆盖 {dplyr::n_distinct(df_all$year)} 个年份"
))

## 3. xlsx/year-{YYYY}.xlsx → data-tidy/.../tidy-year-{YYYY}.xlsx----
# 只读上一步写出的 year-{YYYY}.xlsx，不再解析 yaml。
df_tidy_all <- NULL
years_out <- sort(unique(as.integer(df_all$year)))
for (year_i in years_out) {
  path_xlsx <- fs::path(dir_xlsx, glue::glue("year-{year_i}.xlsx"))
  if (!file.exists(path_xlsx)) {
    stop("缺少第 2 步产物：", path_xlsx)
  }

  df_raw <- openxlsx::read.xlsx(path_xlsx)
  df_tidy <- tidy_standard_tbl(df_raw)
  file_tidy <- glue::glue("tidy-year-{year_i}.xlsx")
  openxlsx::write.xlsx(df_tidy, fs::path(dir_tidy, file_tidy))
  message(glue::glue("已写出 {file_tidy}（{nrow(df_tidy)} 条）"))

  df_tidy_all <- dplyr::bind_rows(df_tidy_all, df_tidy)
}

if (interactive()) View(df_tidy_all)
message(glue::glue(
  "第 3 步合计 {nrow(df_tidy_all)} 条，覆盖 {dplyr::n_distinct(df_tidy_all$year)} 个年份"
))
