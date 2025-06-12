
## R包准备----
require(openxlsx)
require("rvest")
#require("xml2")
require("httr")
require("stringr")
require("tidyverse")
require("tidyselect")
require("here")


## techme维护数据集----

### 准备基本参数----

dir_path <- "topic/public-site/moa-agrimodern-zone/xlsx/"
files_xlsx <- list.files(here(dir_path))
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

use_list <- c("PubAgrimodernZone")
dir_path <- "D:/github/techme/data-raw/public-site/"
(data_path <- glue("{dir_path}{use_list[k]}.rda"))

save(tbl_out, file = data_path)

### 在techme包项目中更新----
#### "D:/github/techme/data-raw/wfl_useData_universe.R"
# use_data()
# use_r()
# document()

## 解析html/农业现代化示范区zone----
## 首先使用notepad 手动处理<div class="zone">
### 2021 html <div>----

# files html path
Year <- 2021
(files_dir <- here(
  "data-raw/public-site/moa-agrimodern-zone/", # dir
  glue::glue("html/list-year-{Year}.html")))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.zone"

tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_text() %>%
  paste0() %>%
  str_split("\n") %>% # split by "\n"
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"),fixed("\n")," ", "．"), # special character
      c("", "","", ".")),
    value = str_trim(value)) %>%
  filter(value!="") %>% # drop empty row
  mutate(value = str_extract(value, "(?<=\\.).+"))

tbl_out <- tbl_raw %>% 
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index")


### 2022 html <div>----

# files html path
Year <- 2022
(files_dir <- here(
  "data-raw/public-site/moa-agrimodern-zone/", # dir
  glue::glue("html/list-year-{Year}.html")))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.zone"

tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_text() %>%
  paste0() %>%
  str_split("\\d{1,3}\\.") %>% # split by "\n"
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"),fixed("\n")," ", "．"), # special character
      c("", "","", ".")),
    value = str_trim(value)) %>%
  filter(value!="") #%>% # drop empty row
#mutate(value = str_extract(value, "(?<=\\.).+"))

tbl_out <- tbl_raw %>% 
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index")

### 2023 html <div>----

# files html path
Year <- 2023
(files_dir <- here(
  "topic/public-site/moa-agrimodern-zone", # dir
  glue::glue("html/list-year-{Year}.html")))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.zone"

tbl_raw <- read_html(files_dir,encoding = "gbk") %>%
  html_nodes(css =  css_tar) %>%
  html_text() %>%
  paste0() %>%
  str_split("\\d{1,3}\\.") %>% # split by "\n"
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"),fixed("\n")," ", "．"), # special character
      c("", "","", ".")),
    value = str_trim(value)) %>%
  filter(value!="") #%>% # drop empty row
#mutate(value = str_extract(value, "(?<=\\.).+"))

## 匹配省区信息----
# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <- tbl_raw  %>%
  rename("name" = "value") %>%
  # 统一省区名称
  mutate(
    province_name = str_extract(name, ptn_province),
    city_clean= str_extract(name, ptn_city)
    ) %>%
  # match
  left_join(., select(ProvinceCity, city_clean, province_clean), by = "city_clean") %>%
  mutate(province = ifelse(is.na(province_name),
                           province_clean,
                           province_name)) %>%
  # 处理异常省区关系
  mutate(
    province = ifelse(
      is.na(province) & str_detect(name,"北大荒农垦集团"),
      c("黑龙江"),
      province
    )
  ) 

tbl_check <- tbl_info %>%
  filter(is.na(province))
if (nrow(tbl_check)>0) warning("存在省份信息缺省情况！")

## 添加整理信息----  
tbl_out <- tbl_info %>% 
  # 添加年份信息
  mutate(year = Year) %>%
  mutate(index = row_number(year)) %>%
  select(year, index, name, province)

## 导出年度xlsx----
type_tar <- "list"
files_dir <- "topic/public-site/moa-agrimodern-zone/xlsx"
(file_name <- glue("{type_tar}-year-{Year}.xlsx"))
(file_path <- here(glue("{files_dir}/{file_name}")))

tbl_park <- tbl_out %>%
  filter(type == type_tar) %>%
  select(year, index, name, province)

write.xlsx(tbl_out, file_path)



## 批量导出年度xlsx（备用代码）----

tbl_export <- tbl_info %>%
  select(year, index, name, province)

years_tar <-sort(unique(tbl_export$year))
type_tar <- "list"
files_dir <- "topic/public-site/moa-agrimodern-zone/xlsx/"


i <- 1
for (i in 1:length(years_tar)){
  (file_name <- glue("{type_tar}-year-{years_tar[i]}.xlsx"))
  (file_path <- here(glue("{files_dir}/{file_name}")))
  tbl_export %>%
    filter(year == years_tar[i]) %>%
    write.xlsx(., file_path)
}



tbl_check <- tbl_export %>%
  group_by(province) %>%
  summarise(n = sum(n)) 


