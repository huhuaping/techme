## R包准备----
require(openxlsx)
source("data-raw/deps/load-core.R")
source("data-raw/deps/load-scrape.R")
require("here")
library(glue)

## 农作物种质资源库圃列表----
## 2026年开始，更新形成数据集：PubGeneticResourceCrop
## 页面入口：https://ncgrip.cgris.net/web/home/protection
## 参数化爬取：https://ncgrip.cgris.net/srv/api/coops/list?pageNum=1&pageSize=10000
## 接口 JSON：code / msg / total / rows（库圃记录在 rows，不是 data$list）

### 2026年参数化爬取----
### 先手动下载json文件到html目录下（备存）：html/list-crops-year-2026.json
### 然后进行参数化爬取
Year <- 2026
page_num <- 1
page_size <- 10000
url_page <- "https://ncgrip.cgris.net/web/home/protection"
url_api <- glue(
  "https://ncgrip.cgris.net/srv/api/coops/list?pageNum={page_num}&pageSize={page_size}"
)

# 带 Referer，避免接口拦截缺省 UA
res_api <- httr::GET(
  url_api,
  httr::user_agent("Mozilla/5.0"),
  httr::add_headers(Referer = url_page),
  httr::timeout(60)
)
if (httr::status_code(res_api) != 200) {
  stop("库圃列表 HTTP ", httr::status_code(res_api), "：", url_api)
}

res_api_json <- httr::content(res_api, as = "text", encoding = "UTF-8") |>
  jsonlite::fromJSON(flatten = TRUE)
if (!identical(as.integer(res_api_json$code), 200L)) {
  stop("库圃列表接口返回异常：", res_api_json$msg)
}

tbl_crop_raw <- as_tibble(res_api_json$rows)
n_total <- as.integer(res_api_json$total)
if (nrow(tbl_crop_raw) != n_total) {
  warning(
    "返回条数与 total 不一致：nrow=", nrow(tbl_crop_raw),
    " total=", n_total
  )
}
if (n_total >= page_size) {
  warning("total 达到 pageSize，可能被截断，请加大 pageSize 或改为分页循环")
}

# 主字段：title 名称, supportUnit 依托单位,
# nature 类型（长期库/中期库/种质圃/试管苗库）,
# province 所在地, determineYear 认定年份, crops / majorCrops 保存作物
View(tbl_crop_raw)

## 保存为xlsx到html/list-crops-year-2026.xlsx
## 与手工下载得到的原始的json文件并排存档，确保没有丢失信息
path_out <- here(glue("data-raw/public-site/moa-genetic-resource/html/list-crops-year-{Year}.xlsx"))
write.xlsx(tbl_crop_raw, path_out, rowNames = FALSE)


## 清洗整理数据表
### 保留字段：title 名称, supportUnit 依托单位, nature 类型（长期库/中期库/种质圃/试管苗库）, majorCrops 主要保存作物，province_raw 所在省-市/区，introduction 简介，determineYear 认定年份
### 添加字段：year 抓取年度, index 序号, province 所在省份
### 重命名字段：province_raw 所在省-市/区, supportUnit 依托单位
### 最终列顺序：year, index, determineYear, province, nature, title
### 清洗认定年份，确保为4为整数
### 检查核对省份是否缺失
data("BasicProvince")
ptn_province <- paste0(BasicProvince$province, collapse = "|")

tbl_crop_tidy <- tbl_crop_raw %>%
 rename(  province_raw = province , institution = supportUnit) %>%
  mutate(
    year = Year,
    province = str_extract(province_raw, ptn_province),  # 提取省份
    determineYear = as.integer(str_extract(determineYear, "\\d{4}")) # 清洗认定年份
    ) %>%
    mutate(index = 1:nrow(.)) %>% # 添加序号
  select(year, index, determineYear, province, nature, title, institution) # 最终列顺序

if (any(is.na(tbl_crop_tidy$province))) {
  warning("存在省份信息缺省情况！")
} else {
  cat("省份信息完整，无缺省情况！")
}

View(tbl_crop_tidy)

## 保存为xlsx分别到如下位置：
##  data-raw/public-site/moa-genetic-resource/xlsx/list-crops-year-{Year  }.xlsx
##  data-raw/data-tidy/public-site/moa-genetic-resource/xlsx/list-crops-year-{Year}.xlsx
path_out_public <- here(glue("data-raw/public-site/moa-genetic-resource/xlsx/list-crops-year-{Year}.xlsx"))
path_out_tidy <- here(glue("data-raw/data-tidy/public-site/moa-genetic-resource/xlsx/list-crops-year-{Year}.xlsx"))
write.xlsx(tbl_crop_tidy, path_out_public, rowNames = FALSE, overwrite = TRUE)
write.xlsx(tbl_crop_tidy, path_out_tidy, rowNames = FALSE, overwrite = TRUE)


### 在wfl-PubGeneticResource.R中更新数据集----
## 更新数据集：PubGeneticResourceCrop

