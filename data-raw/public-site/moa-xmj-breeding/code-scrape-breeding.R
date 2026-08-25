## 脚本目标：根据国家畜禽核心育种场初始公示文件，整理清洗后形成标准化变量名称的xlsx文件，存放到`data-raw/data-tidy/public-site/moa-xmj-breeding/xlsx/`目录下。
## 公示文件说明：年度公示文件内一般包括4个公示类别：遴选公示、核验通过、资格取消、名称变更。其中遴选公示和核验通过的公示文件内，一般包括多个畜禽品种育种场/良种扩繁推广场等的公示信息。

## 目标变量：year（年份）	index（序号）	province（省份）	type（育种场类型，例如国家生猪、肉牛、肉羊、肉鸡、蛋鸡良种扩繁推广基地/核心育种场等）	name_origin（原名称）	name_change（变更名称）	mark（公示类别，包括：遴选公示、核验通过、资格取消、名称变更）

## 脚本思路（只针对2021年及其以后的公示文件）：
## 1. （不编写R代码）根据初始公示文件，让Cursor agent提取公示信息，并整理为yaml文件，放到`data-raw/public-site/moa-xmj-breeding/yaml/`目录下。这个步骤完全使用LLM模型，不要编写任何R代码。
## 2. （此处编写R代码）读取yaml文件，清洗形成标准化变量名称的xlsx文件，放到`data-raw/public-site/moa-xmj-breeding/xlsx/`目录下。
## 3. （此处编写R代码）将标准化变量名称的xlsx文件进一步清洗，存放到`data-raw/data-tidy/public-site/moa-xmj-breeding/xlsx/`目录下。

## 准备R包----
# 从仓库根目录运行。load-core 加载 dplyr/stringr/purrr 等；yaml/openxlsx/here/fs 本脚本再用。
source("data-raw/deps/load-core.R")
require("here")
require("glue")
require("openxlsx")
require("yaml")
require("fs")

## YAML 标量：null / 空 → NA，再统一成字符，与 2010–2020 tidy 列类型对齐
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
      any(nms %in% c("index", "type", "items", "mark", "groups", "annex", "name_origin"))) {
    return(list(x))
  }
  x
}

# 读一份 year-{YYYY}.yaml：annexes → groups → items 展开为目标 7 列
expand_breeding_yaml <- function(path) {
  yml <- yaml::read_yaml(path)
  if (is.null(yml$annexes) || length(yml$annexes) == 0L) {
    stop("YAML 缺少 annexes：", path)
  }

  rows <- list()
  for (ax in as_yaml_seq(yml$annexes)) {
    mark <- yaml_chr(ax$mark)
    for (g in as_yaml_seq(ax$groups)) {
      type <- yaml_chr(g$type)
      for (it in as_yaml_seq(g$items)) {
        rows[[length(rows) + 1L]] <- tibble::tibble(
          year = yaml_chr(yml$year),
          index = yaml_chr(it$index),
          province = yaml_chr(it$province),
          type = type,
          name_origin = yaml_chr(it$name_origin),
          name_change = yaml_chr(it$name_change),
          mark = mark
        )
      }
    }
  }

  if (length(rows) == 0L) {
    stop("展开后 0 行：", path)
  }

  df_out <- dplyr::bind_rows(rows) |>
    dplyr::select(year, index, province, type, name_origin, name_change, mark)

  n_yml <- yaml_int(yml$counts[["合计"]])
  if (!is.na(n_yml) && n_yml != nrow(df_out)) {
    warning(
      glue::glue("{basename(path)} counts$合计={n_yml}，展开 {nrow(df_out)} 行"),
      call. = FALSE
    )
  }

  df_out
}

# 第 3 步：全部转字符，去掉换行/不换行空格，再 trim（对齐历史 scrape-breeding.Rmd）
tidy_breeding_tbl <- function(df_raw) {
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
    dplyr::select(year, index, province, type, name_origin, name_change, mark)
}

## 确定路径----
dir_yaml <- here::here("data-raw", "public-site", "moa-xmj-breeding", "yaml")
dir_xlsx <- here::here("data-raw", "public-site", "moa-xmj-breeding", "xlsx")
dir_tidy <- here::here("data-raw", "data-tidy", "public-site", "moa-xmj-breeding", "xlsx")
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
# 只处理 2021 年起；不要 glob 本目录历史 year-2010-pig-*.xlsx。
df_all <- NULL
for (file_yaml in files_yaml) {
  year_file <- as.integer(stringr::str_extract(basename(file_yaml), "\\d{4}"))
  if (is.na(year_file) || year_file < 2021L) {
    next
  }

  df_out <- expand_breeding_yaml(file_yaml)
  file_xlsx <- glue::glue("year-{year_file}.xlsx")
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
  df_tidy <- tidy_breeding_tbl(df_raw)
  file_tidy <- glue::glue("tidy-year-{year_i}.xlsx")
  openxlsx::write.xlsx(df_tidy, fs::path(dir_tidy, file_tidy))
  message(glue::glue("已写出 {file_tidy}（{nrow(df_tidy)} 条）"))

  df_tidy_all <- dplyr::bind_rows(df_tidy_all, df_tidy)
}

if (interactive()) View(df_tidy_all)
message(glue::glue(
  "第 3 步合计 {nrow(df_tidy_all)} 条，覆盖 {dplyr::n_distinct(df_tidy_all$year)} 个年份"
))

