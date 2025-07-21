## R包准备----
require(openxlsx)
require("rvest")
# require("xml2")
require("httr")
require("stringr")
require("tidyverse")
require("tidyselect")
require("here")
library(glue)


## 解析html----


### 2023 html <div>----
# files html path
Year <- 2023
batch <- "02"
(files_dir <- here(
  "data-raw/public-site/moa-genetic-resource/", # dir
  glue::glue("html/list-year-{Year}-batch-{batch}.html")
)) # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table

tbl_raw <- read_html(files_dir, encoding = "UTF-8") %>%
  html_table(header = FALSE, trim = TRUE) %>%
  bind_rows()

# 清洗数据
names_eng <- c("index", "name", "institution", "province_read")
tbl_tidy <- tbl_raw %>%
  # 重命名
  rename_all(., ~names_eng) %>%
  # 去掉空格
  mutate_all(
    ., mgsub::mgsub,
    pattern = c("\\s"),
    replacement = c("")
  ) %>%
  # 类别变量
  mutate(
    type = case_when(
      name == "国家库（圃）名称" ~ "农作物",
      name == "国家库名称" ~ "农业微生物"
    )
  ) %>%
  fill(type, .direction = "down") %>%
  filter(index != "序号") %>%
  mutate(index = as.numeric(index))

### 2022 html <div>----
# files html path
Year <- 2022
batch <- "01"
(files_dir <- here(
  "data-raw/public-site/moa-genetic-resource/", # dir
  glue::glue("html/list-year-{Year}-batch-{batch}.htm")
)) # file

# xpath for data table

tbl_raw <- read_html(files_dir, encoding = "UTF-8") %>%
  html_table(header = FALSE, trim = TRUE) %>%
  bind_rows()

# 清洗数据
names_eng <- c("index", "name", "institution", "province_read")
tbl_tidy <- tbl_raw %>%
  # 重命名
  rename_all(., ~names_eng) %>%
  # 去掉空格
  mutate_all(
    ., mgsub::mgsub,
    pattern = c("\\s"),
    replacement = c("")
  ) %>%
  # 类别变量
  mutate(
    type = case_when(
      name == "国家级库（圃）名称" ~ "农作物",
      name == "国家级库名称" ~ "农业微生物"
    )
  ) %>%
  fill(type, .direction = "down") %>%
  filter(index != "序号") %>%
  mutate(index = as.numeric(index))


## 匹配省区信息----
# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <- tbl_tidy %>%
  # 统一省区名称
  mutate(
    province_name = str_extract(province_read, ptn_province),
    city_clean = str_extract(province_read, ptn_city)
  ) %>%
  # match
  left_join(., select(ProvinceCity, city_clean, province_clean), by = "city_clean") %>%
  mutate(province = ifelse(is.na(province_name),
    province_clean,
    province_name
  )) %>%
  # 处理异常省区关系
  mutate(
    province = ifelse(
      is.na(province) & str_detect(name, "北大荒农垦集团"),
      c("黑龙江"),
      province
    )
  )

tbl_check <- tbl_info %>%
  filter(is.na(province))
if (nrow(tbl_check) > 0) warning("存在省份信息缺省情况！")

## 添加整理信息----
tbl_out <- tbl_info %>%
  # 添加年份信息
  mutate(year = Year, batch = batch) %>%
  # mutate(index = row_number(year)) %>%
  select(year, batch, type, index, name, institution, province)

## 导出年度xlsx----
type_tar <- "list"
files_dir <- "data-raw/public-site/moa-genetic-resource/xlsx"
(file_name <- glue("{type_tar}-year-{Year}-batch-{batch}.xlsx"))
(file_path <- here(glue("{files_dir}/{file_name}")))

write.xlsx(tbl_out, file_path)



## techme维护数据集----

### 准备基本参数----

dir_path <- "data-raw/public-site/moa-genetic-resource/xlsx"
(files_xlsx <- list.files(here(dir_path)))
k <- 1 # 选择

### 循环读取----
data_names <- c("list")
(type_tar <- data_names[k])
(files_target <- files_xlsx[which(str_detect(files_xlsx, type_tar))])
url_xlsx <- paste0(dir_path, "/", files_target)
years_target <- str_extract_all(files_target, "(\\d{4})") %>%
  unlist() %>%
  as.numeric(.)

tbl_out <- NULL
i <- 1
for (i in length(files_target):1) {
  tbl_tem <- read.xlsx(url_xlsx[i]) %>%
    mutate(index = as.numeric(index))
  tbl_out <- bind_rows(tbl_out, tbl_tem)
  cat(years_target[i], sep = "\n")
}

### 导出到techme/data-raw/public----

use_list <- c("PubGeneticResource")
dir_path <- "D:/github/techme/data-raw/public-site/"
(data_path <- glue("{dir_path}{use_list[k]}.rda"))

save(tbl_out, file = data_path)

### 在techme包项目中更新----
#### "D:/github/techme/data-raw/wfl_useData_universe.R"
# use_data()
# use_r()
# document()
