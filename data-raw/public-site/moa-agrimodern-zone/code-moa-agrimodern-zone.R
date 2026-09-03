
## R包准备----
require(openxlsx)
#require("xml2")
source("data-raw/deps/load-core.R")
source("data-raw/deps/load-scrape.R")
require("here")


## techme维护数据集----
### 在techme包项目中更新----
#### "D:/github/techme/data-raw/public-site/moa-agrimodern-zone/wfl-PubAgrimodernZone.R"


## 年度解析html/农业现代化示范区zone----
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
  "data-raw/public-site/moa-agrimodern-zone", # dir
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


### 2026 html <div>----
# files html path
Year <- 2026
(files_dir <- here(
  "data-raw/public-site/moa-agrimodern-zone", # dir
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
View(tbl_raw)

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
if (nrow(tbl_check)>0) warning("存在省份信息缺省情况！") else print("省份信息匹配成功！")
View(tbl_info)
## 添加整理信息----
tbl_out <- tbl_info %>%
  # 添加年份信息
  mutate(year = Year) %>%
  mutate(index = row_number(year)) %>%
  select(year, index, name, province)
View(tbl_out)
## 导出年度xlsx----
type_tar <- "list"
files_dir <- "data-raw/public-site/moa-agrimodern-zone/xlsx"
(file_name <- glue("{type_tar}-year-{Year}.xlsx"))
(file_path <- here(glue("{files_dir}/{file_name}")))

# tbl_park <- tbl_out %>%
#   filter(type == type_tar) %>%
#   select(year, index, name, province)

write.xlsx(tbl_out, file_path)
cat(glue("导出成功！{file_path}"))

## 拷贝到tidy 路径下
type_tar <- "list"
Year <- 2021
dir_path_src <- "data-raw/public-site/moa-agrimodern-zone/xlsx"
dir_path_dst <- "data-raw/data-tidy/public-site/moa-agrimodern-zone/xlsx"
(file_name <- glue("{type_tar}-year-{Year}.xlsx"))
(file_path_src <- here(glue("{dir_path_src}/{file_name}")))
(file_path_dst <- here(glue("{dir_path_dst}/{file_name}")))
# 如果文件不存在，则创建文件夹并拷贝文件
if (!dir.exists(dir_path_dst)) {
  dir.create(dir_path_dst, recursive = TRUE)
  cat(glue("创建文件夹成功！{dir_path_dst}"))
}
file.copy(file_path_src, file_path_dst, overwrite = TRUE)
cat(glue("拷贝成功！{file_path_src} -> {file_path_dst}"))



