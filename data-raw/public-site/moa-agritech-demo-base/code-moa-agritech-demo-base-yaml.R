## 脚本目标：根据两类名单公示文件：农业农村部现代农业科技试验示范基地、国家农业科技示范展示基地，
## 整理清洗后形成标准化变量名称的xlsx文件，存放到`data-raw/data-tidy/public-site/moa-agritech-demo-base/xlsx/`目录下。
## 公示文件说明：
### 农业农村部现代农业科技试验示范基地公示文件：2025年度公示文件内包括5个公示类别：种植业（65个）、畜牧兽医（30个）、渔业（20个）、农机（20个）、资源环境（14个）,合计149个。
### 国家农业科技示范展示基地公示文件：2020年度公示文件，没有区分类别，合计110个。

## 目标变量：year（年份）index（序号）source(来源：现代农业科技试验示范基地、国家农业科技示范展示基地、国家农业科技创新与集成示范基地)	type（类型：种植业、畜牧兽医、渔业、农机、资源环境）name（基地名称）institution(牵头单位/运营单位) province（省份）。

## 脚本思路（针对2025年农业农村部现代农业科技试验示范基地、2020年国家农业科技示范展示基地公示文件）：
### 2025年文件`data-raw/public-site/moa-agritech-demo-base/modern-year-2025.html`（公示文件）、pdf附件：`data-raw/public-site/moa-agritech-demo-base/modern-year-2025-attach.pdf`。
### 2020年文件`data-raw/public-site/moa-agritech-demo-base/tech-year-2020.html`（公示文件）、docx附件1：`data-raw/public-site/moa-agritech-demo-base/tech-year-2020-attach.docx`。

## 1. （不编写R代码）根据初始公示文件，让Cursor agent提取公示信息，并整理为yaml文件，放到`data-raw/public-site/moa-agritech-demo-base/yaml/xxxx-year-xxxx.yaml`目录下。这个步骤完全使用LLM模型，不要编写任何R代码。
## 2. （此处编写R代码）读取yaml文件，清洗形成标准化变量名称的xlsx文件，放到`data-raw/public-site/moa-agritech-demo-base/xlsx/xxxx-year-xxxx.xlsx`目录下。
## 3. （此处编写R代码）将标准化变量名称的xlsx文件进一步清洗，存放到`data-raw/data-tidy/public-site/moa-agritech-demo-base/xlsx/xxxx-year-xxxx.xlsx`目录下。


## 准备R包----
# 从仓库根目录运行。load-core 加载 dplyr/stringr/purrr 等；yaml/openxlsx/here/fs 本脚本再用。
source("data-raw/deps/load-core.R")
require("here")
require("glue")
require("openxlsx")
require("yaml")
require("fs")

## YAML 标量：null / 空 → NA，再统一成字符
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
        "index", "items", "annex", "type",
        "name", "institution", "province", "partners"
      ))) {
    return(list(x))
  }
  x
}

# 第 2 步省份：兵团并入新疆；其余保持 YAML 已有简称
norm_province <- function(x) {
  prov <- yaml_chr(x)
  if (is.na(prov)) {
    return(prov)
  }
  if (prov %in% c("新疆生产建设兵团", "新疆兵团", "兵团")) {
    return("新疆")
  }
  prov
}

# 读一份 {prefix}-year-{YYYY}.yaml：annexes → items 展开为 7 列
# partners（联合单位）按 schema 不进入 tidy。
expand_demo_yaml <- function(path) {
  yml <- yaml::read_yaml(path)
  if (is.null(yml$annexes) || length(yml$annexes) == 0L) {
    stop("YAML 缺少 annexes：", path)
  }

  source_val <- yaml_chr(yml$source)
  rows <- list()
  for (ax in as_yaml_seq(yml$annexes)) {
    type <- yaml_chr(ax$type)
    for (it in as_yaml_seq(ax$items)) {
      rows[[length(rows) + 1L]] <- tibble::tibble(
        year = yaml_chr(yml$year),
        index = yaml_chr(it$index),
        source = source_val,
        type = type,
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
    dplyr::select(year, index, source, type, name, institution, province)

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
tidy_demo_tbl <- function(df_raw) {
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
    dplyr::mutate(
      type = dplyr::na_if(type, ""),
      type = dplyr::na_if(type, "NA"),
      province = dplyr::if_else(
        province %in% c("新疆生产建设兵团", "新疆兵团", "兵团"),
        "新疆",
        province
      )
    ) |>
    dplyr::select(year, index, source, type, name, institution, province)
}

## 确定路径----
dir_yaml <- here::here("data-raw", "public-site", "moa-agritech-demo-base", "yaml")
dir_xlsx <- here::here("data-raw", "public-site", "moa-agritech-demo-base", "xlsx")
dir_tidy <- here::here("data-raw", "data-tidy", "public-site", "moa-agritech-demo-base", "xlsx")
fs::dir_create(dir_xlsx)
fs::dir_create(dir_tidy)

# 只读年度名单 YAML，不要碰到 _schema.yaml
files_yaml <- list.files(
  path = dir_yaml,
  pattern = "^(modern|tech)-year-\\d{4}\\.yaml$",
  full.names = TRUE
)
if (length(files_yaml) == 0L) {
  stop("未找到 modern/tech-year-*.yaml，请检查：", dir_yaml)
}
files_yaml <- sort(files_yaml)

## 2. yaml → xlsx/{prefix}-year-{YYYY}.xlsx----
df_all <- NULL
files_xlsx_out <- character()
for (file_yaml in files_yaml) {
  file_xlsx <- stringr::str_replace(basename(file_yaml), "\\.yaml$", ".xlsx")
  df_out <- expand_demo_yaml(file_yaml)
  path_xlsx <- fs::path(dir_xlsx, file_xlsx)
  openxlsx::write.xlsx(df_out, path_xlsx)
  message(glue::glue("已写出 {file_xlsx}（{nrow(df_out)} 条）"))

  n_na_prov <- sum(is.na(df_out$province) | df_out$province == "")
  if (n_na_prov > 0L) {
    message(glue::glue("  其中 province 为空 {n_na_prov} 条"))
  }

  files_xlsx_out <- c(files_xlsx_out, file_xlsx)
  df_all <- dplyr::bind_rows(df_all, df_out)
}

if (is.null(df_all) || nrow(df_all) == 0L) {
  stop("第 2 步没有写出任何年份，请检查 yaml 是否覆盖 2020、2025。")
}

if (interactive()) View(df_all)
message(glue::glue(
  "第 2 步合计 {nrow(df_all)} 条，覆盖 {dplyr::n_distinct(df_all$year)} 个年份"
))

## 3. xlsx → data-tidy/.../{prefix}-year-{YYYY}.xlsx----
# 只读上一步写出的 xlsx，不再解析 yaml。
df_tidy_all <- NULL
for (file_xlsx in files_xlsx_out) {
  path_xlsx <- fs::path(dir_xlsx, file_xlsx)
  if (!file.exists(path_xlsx)) {
    stop("缺少第 2 步产物：", path_xlsx)
  }

  df_raw <- openxlsx::read.xlsx(path_xlsx)
  df_tidy <- tidy_demo_tbl(df_raw)
  openxlsx::write.xlsx(df_tidy, fs::path(dir_tidy, file_xlsx))
  message(glue::glue("已写出 data-tidy {file_xlsx}（{nrow(df_tidy)} 条）"))

  df_tidy_all <- dplyr::bind_rows(df_tidy_all, df_tidy)
}

if (interactive()) View(df_tidy_all)
message(glue::glue(
  "第 3 步合计 {nrow(df_tidy_all)} 条，覆盖 {dplyr::n_distinct(df_tidy_all$year)} 个年份"
))
