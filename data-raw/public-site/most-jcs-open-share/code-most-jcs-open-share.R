## R包准�?---
source("data-raw/deps/load-core.R")
source("data-raw/deps/load-scrape.R")
require("here")
library(glue)
require("openxlsx")
require("techme")

## 抓取html表格�?021年）----

Year <- 2021

# files html path
file_dir <- "html/"
file_name <- list.files(file_dir)
file_id <- which(str_detect(
  file_name,
  glue::glue("-{Year}")
))
file_sel <- file_name[file_id]
file_path <- paste0(file_dir, file_sel)

xpath_tbl <- "//*[@id='Zoom']//table"

# only for year 2021
file_path <- "https://www.most.gov.cn/xxgk/xinxifenlei/fdzdgknr/qtwj/qtwj2021/202112/t20211209_178495.html"

tbl_raw <- read_html(file_path, encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tbl) %>%
  html_table(
    fill = T,
    header = T
  ) %>%
  .[[1]]

if (Year %in% c(2020, 2021)) {
  title_list <- c("index", "institution", "result")
} else {
  title_list <- c(
    "index", "institution",
    "result", "administrator"
  )
}

# tidy
tbl_out <- tbl_raw %>%
  as_tibble() %>%
  rename_at(all_of(names(.)), ~title_list) %>%
  type_convert(cols(index = col_number())) %>%
  add_column(year = Year, .before = "index") %>%
  # only year 2020 and after
  add_column(
    administrator = "",
    .after = "result"
  ) %>%
  # handle multiple institutions
  mutate(
    institution = mgsub::mgsub(
      institution,
      c(" "),
      c("�?)
    )
  )

# just for check
tbl_out %>%
  filter(is.na(institution)) %>%
  nrow(.)

# files xlsx path
path_out <- paste0("xlsx/eval-", Year, "-wide.xlsx")
write.xlsx(tbl_out, path_out)


## 抓取pdf表格txt�?023年）----

Year <- 2023

# files html path
file_dir <- here("data-raw/public-site/most-jcs-open-share/html/")
file_name <- list.files(file_dir)
file_id <- which(str_detect(
  file_name,
  glue::glue("-{Year}\\.txt")
))
(file_sel <- file_name[file_id])
(file_path <- paste0(file_dir, "/", file_sel))

ptn <- c("优秀", "良好", "合格", "较差")

tbl_raw <- read_lines(file_path) %>%
  as_tibble() %>%
  # 去除空格
  mutate(value = str_replace_all(value, " ", "")) %>%
  separate(col = value, into = c("index", "str"), sep = "\\|") %>%
  mutate(
    institution = mgsub::mgsub(
      str, ptn, rep("", length(ptn))
    ),
    result = str_extract(str, paste0(ptn, collapse = "|"))
  ) %>%
  select(index, institution, result)


if (Year %in% c(2020, 2021, 2022)) {
  title_list <- c("index", "institution", "result")
} else {
  title_list <- c(
    "index", "institution",
    "result", "administrator"
  )
}

# tidy
tbl_out <- tbl_raw %>%
  as_tibble() %>%
  # rename_at(all_of(names(.)), ~title_list) %>%
  type_convert(cols(index = col_number())) %>%
  add_column(year = Year, .before = "index") %>%
  # only year 2020 and after
  add_column(
    administrator = "",
    .after = "result"
  ) # %>%
# handle multiple institutions
# mutate(
#   institution = mgsub::mgsub(
#     institution,
#     c(" "),
#     c("�?)
#   )
# )

# just for check
tbl_out %>%
  filter(is.na(institution)) %>%
  nrow(.)

# files xlsx path
(path_out <- glue("data-raw/public-site/most-jcs-open-share/xlsx-raw/eval-{Year}-wide.xlsx"))
write.xlsx(tbl_out, here(path_out))


# 2024年数据处�?---
## 经过doc转xlsx处理

Year <- 2024

file_dir <- here("data-raw/public-site/most-jcs-open-share/html/")
file_name <- list.files(file_dir)
file_id <- which(str_detect(
  file_name,
  glue::glue("year-{Year}\\.xlsx")
))
(file_sel <- file_name[file_id])
(file_path <- paste0(file_dir, "/", file_sel))

tbl_out <- read.xlsx(file_path) %>%
  setNames(c("index", "institution", "result")) %>%
  add_column(year = Year, .before = "index") %>%
  mutate(administrator = "") %>%
  mutate(index = as.numeric(index)) %>%
  # 处理多个机构
  mutate(institution = mgsub::mgsub(
    institution,
    c(" "),
    c("�?)
  )) %>%
  # 特殊机构�?
  mutate(institution = mgsub::mgsub(
    institution,
    c(
      "中国科学院、水利部成都山地灾害与环境研究所", # 实际上是一家机�?
      "中国医学科学院血液病医院（中国医学科学院血液学研究所�?
    ),
    c(
      "中国科学院水利部成都山地灾害与环境研究所",
      "中国医学科学院血液病医院（血液学研究所�?
    ) # queryTianyan已经存在
  ))

# 导出
(path_out <- glue("data-raw/public-site/most-jcs-open-share/xlsx/eval-{Year}-wide.xlsx"))
write.xlsx(tbl_out, here(path_out))

## 合并全部年份数据----

file_dir <- here("data-raw/public-site/most-jcs-open-share/xlsx-raw/")
file_name <- list.files(file_dir)
file_path <- fs::dir_ls(file_dir)

tbl_out <- tibble(url = file_path) %>%
  mutate(dt = map(url, openxlsx::read.xlsx)) %>%
  select(-url) %>%
  # unify column type
  mutate(dt = map(dt, .f = function(df) {
    out <- df %>% mutate(administrator = as.character(administrator))
  })) %>%
  unnest(dt)

View(tbl_out)

## 机构名称列表（唯一化处理）----

data("queryTianyan")
dt_match <- queryTianyan %>%
  select(name_origin, province) %>%
  rename(institution = "name_origin")

data("ProvinceCity")
dt_city <- ProvinceCity %>%
  select(city_clean, province_clean)

ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")


list_institution <- tbl_out %>%
  mutate(institution_raw = institution) %>%
  # use only the first institution
  mutate(
    institution = map_chr(
      .x = institution_raw,
      .f = function(x) as.character(unlist(str_split(x, pattern = "�?))[[1]])
    )
  ) %>%
  select(institution) %>%
  unique() %>%
  left_join(., dt_match, by = "institution") %>%
  # filter obvious province info
  mutate(province_raw = str_extract(institution, ptn_province)) %>%
  mutate(province = ifelse(is.na(province), province_raw, province)) %>%
  # match city
  mutate(city_clean = str_extract(institution, ptn_city)) %>%
  left_join(., dt_city, by = "city_clean") %>%
  mutate(province = ifelse(is.na(province), province_clean, province)) %>%
  filter(is.na(province)) %>%
  select(institution) %>%
  arrange(institution)

# check
(check <- sum(!is.na(list_institution$institution)))
if (check > 0) stop("please check the name of institution!")

dir_xlsx <- "d:/github/techme/data-raw/data-tidy/hack-tianyan/ship/"
file_xlsx <- glue::glue("ship-tot{nrow(list_institution)}-{Sys.Date()}.xlsx")
(path_xlsx <- paste0(dir_xlsx, file_xlsx))

openxlsx::write.xlsx(list_institution, path_xlsx)



## 在R包techme中进行天眼查----
# - 循环查询#
# - 得到结果，并人工确认#
# - 重新整合更新`qureyTianyan`#
# - build 并push `techme`#
# - 在repo `tech-report`中安装更新后的R包`techme`
# - `renv::install("huhuaping/techme")`

# 匹配省份和地区信�?---

## 获得queryTianyan和ProvinceCity数据----

require("techme")

data("queryTianyan")
dt_match <- queryTianyan %>%
  select(name_origin, province) %>%
  rename(institution = "name_origin")

data("ProvinceCity")
dt_city <- ProvinceCity %>%
  select(city_clean, province_clean)

ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

# 循环处理xlsx文件----
## 导出到data-tidy对应的文件夹�?
list_xlsx <- list.files(here("data-raw/public-site/most-jcs-open-share/xlsx-raw/"), full.names = TRUE)
list_years <- str_extract(list_xlsx, "\\d{4}")

i <- 1

for (i in seq_along(list_xlsx)) {
  Year <- list_years[i]
  tbl_wide <- read.xlsx(list_xlsx[i])

  tbl_province <- tbl_wide %>%
    # replicate new columns
    mutate(institution_raw = institution) %>%
    # use only the first institution, 只分析排序第一的主管机�?
    mutate(
      institution = map_chr(
        .x = institution_raw,
        .f = function(x) as.character(unlist(str_split(x, pattern = "�?))[[1]])
      )
    ) %>%
    # match `queryTianyan`
    left_join(., dt_match, by = "institution") %>%
    rename(province_match = "province") %>%
    # match `ProvinceCity`
    mutate(
      city = str_extract(institution, ptn_city),
      province_raw = str_extract(institution, ptn_province)
    ) %>%
    left_join(., select(ProvinceCity, province, city_clean), by = c("city" = "city_clean")) %>%
    ## city province
    mutate(province = ifelse(is.na(province),
      province_raw,
      province
    )) %>%
    ## simplify the name of province
    mutate(province = str_extract(
      province,
      paste0(BasicProvince$province, collapse = "|") # 简化后、统一化的省份名称
    )) %>%
    # combine matched province from `queryTianyan`
    mutate(province = ifelse(is.na(province),
      province_match,
      province
    )) %>%
    # # match the region
    # left_join(., BasicProvince, by = "province") %>%
    # ## unique rows
    # unique() %>%
    # reset institution column
    mutate(institution = institution_raw) %>%
    select(-institution_raw) %>%
    select(year, index, institution, result, administrator, province)

  # just for check
  # View(tbl_province)

  check <- sum(is.na(tbl_province$province))

  if (check > 0) {
    na_index <- which(is.na(tbl_province$province))
    warning(glue::glue("bad! there are {check} provinces are not indentified, please check it!"))
    warning(glue::glue("The NA province row index: {na_index}"))
  } else {
    message(glue::glue("Good! No NA province in {Year} xlsx file!"))
  }

  ## 创建目录文件�?
  dir_tar <- here("data-raw/data-tidy/public-site/most-jcs-open-share/xlsx/")
  if (!dir.exists(dir_tar)) {
    dir.create(dir_tar, recursive = TRUE)
    message(glue::glue("The {dir_tar} directory has been created!"))
  }

  ## 导出数据�?---
  path_xlsx <- glue::glue("{dir_tar}/eval-{Year}.xlsx")
  openxlsx::write.xlsx(tbl_province, here(path_xlsx))
  message(glue::glue("The {Year} xlsx file has been exported to {path_xlsx}!"))
}
