## 准备R包----

require(openxlsx)
require("rvest")
# require("xml2")
require("httr")
require("stringr")
require("tidyverse")
require("tidyselect")
require("here")
library(glue)
library(lubridate)
library(janitor)

## 基本参数----
Year <- 2025 # 抓取年份
date_valid <- "2024-12-31" # 证书有效截止期，也即这一天之前是有效的

## 读取rds文件----
(file_path <- here(glue("data-raw/public-site/moa-seed-firm/data/table-json-{Year}.rds"))) # change here
tbl_rds <- read_rds(file_path) %>%
  unnest(dt)

## 处理列格式----
date_valid <- lubridate::date(date_valid) # 证书有效日期（截止这一天还有效）
vars_tar <- c(
  "label", "id", "type",
  "LicenceNo", "ApplyCompanyName",
  "PrinterProductionManageCrops",
  "IssuingAuthorityCaption",
  "InitialPublishDate", "PublishDate",
  "ExpireDate", "licence_type"
)
tbl_clean <- tbl_rds %>%
  # clean and filter Licence NO
  mutate(LicenceNo = str_squish(LicenceNo)) %>%
  mutate(licence_type = str_extract(LicenceNo, "(^[A-Z]{1,6})")) %>%
  # filter(is.na(license_type)) # for check
  filter(str_detect(licence_type, "A")) %>%
  # date handling
  mutate_at(vars(ends_with("Date")),
    .funs = lubridate::as_date
  ) %>%
  # 证书有效日期截止
  filter(ExpireDate > date_valid) %>%
  select(all_of(vars_tar))


## 处理证书重复行----

# 重复情形1：处理证书编号和企业名重复的行，
## 表明证书过期换领，但是证书编号不便，只是更新有效期
## 但是有效期还是大于报告日期`date_valid`
tbl_dup <- tbl_clean %>%
  mutate(index = 1:nrow(.)) %>%
  janitor::get_dupes(LicenceNo, ApplyCompanyName)
## 找到重复行里，有效日期最大的行，确定其行序号。
index_dup <- tbl_dup %>%
  group_by(LicenceNo) %>%
  slice_max(ExpireDate) %>% # 有效日期最大
  ungroup() %>%
  select(index) %>%
  unlist() %>%
  unname()
## 第一次剔除
tbl_unique <- tbl_clean %>%
  .[-index_dup, ]

# 重复情形2：证书编号不同，但企业名称和产品名称重复，，
## 表明证书过期“重新申请”并且重新给了证书编号
## 但是有效期还是大于报告日期`date_valid`
tbl_dup2 <- tbl_unique %>%
  mutate(index = 1:nrow(.)) %>%
  janitor::get_dupes(
    PrinterProductionManageCrops,
    ApplyCompanyName
  )
## 找到重复行里，有效日期最大的行，确定其行序号。
index_dup2 <- tbl_dup2 %>%
  group_by(ApplyCompanyName) %>%
  slice_max(ExpireDate) %>% # 有效日期最大
  ungroup() %>%
  select(index) %>%
  unlist() %>%
  unname()
## 第二次剔除
tbl_unique <- tbl_unique %>%
  .[-index_dup2, ]



## 匹配省区信息----

# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <- tbl_unique %>%
  mutate(
    province_name = str_extract(label, ptn_province),
    city_clean = str_extract(label, ptn_city)
  ) %>%
  # match
  left_join(., select(ProvinceCity, city_clean, province_clean), by = "city_clean") %>%
  mutate(province = ifelse(is.na(province_name),
    province_clean,
    province_name
  )) %>%
  # special case
  mutate(
    province = ifelse(
      is.na(province) & label == "杨陵市",
      "陕西",
      province
    )
  ) %>%
  select(province, all_of(vars_tar))

# check
check <- sum(is.na(tbl_info$province))
if (check > 0) warning("Povince with NA, please check!")


## 导出到data-update/文件夹----

date_upto <- date_valid
dir_path <- here::here("data-raw/data-tidy/public-site/moa-seed-firm/data-update")
(path_out <- paste0(dir_path, "/list-seedfirm-upto-", date_upto, ".rds"))

write_rds(tbl_info, path_out)
