
## R包准备----
require(openxlsx)
require("rvest")
#require("xml2")
require("httr")
require("stringr")
require("tidyverse")
require("tidyselect")
require("here")
library(glue)
library(techme)


## techme维护数据集----

### 准备基本参数----

dir_path <- "topic/public-site/moa-rural-infobase/xlsx/"
(files_xlsx <- list.files(here(dir_path)))

### 循环读取----
k <- 1 # 选择
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

use_list <- c("PubRuralInfoBase")
dir_path <- "D:/github/techme/data-raw/public-site/"
(data_path <- glue("{dir_path}{use_list[k]}.rda"))

save(tbl_out, file = data_path)

### 在techme包项目中更新----
#### "D:/github/techme/data-raw/wfl_useData_universe.R"
# use_data()
# use_r()
# document()

## 解析html----

### 2023 html <div>----
## 首先使用notepad 手动处理<div class="info">
# files html path
Year <- 2023
(files_dir <- here(
  "topic/public-site/moa-rural-infobase", # dir
  glue::glue("html/list-year-{Year}.html")))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.info"

tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_text() %>%
  #paste0() %>%
  str_split("\\n\\t") %>% # split by "\n"
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
  # 识别类型
  mutate(type = str_extract(value, "(?<=、)(.+)(?=\\（)")) %>%
  fill(type, .direction = "down") %>%
  filter(!str_detect(value, "）：$"))

### 2021 html <div>----
## 首先使用notepad 手动处理<div class="info">
# files html path
Year <- 2021
(files_dir <- here(
  "topic/public-site/moa-rural-infobase", # dir
  glue::glue("html/list-year-{Year}.html")))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.info"

tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_text() %>%
  #paste0() %>%
  str_split("\\n") %>% # split by "\n"
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
  # 识别类型
  mutate(type = str_extract(value, "(?<=、)(.+)(?=\\（)")) %>%
  fill(type, .direction = "down") %>%
  filter(!str_detect(value, "）：$"))

## 添加整理信息----  
tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  # 添加年份信息
  mutate(year = Year) %>%
  group_by(type) %>%
  mutate(index = row_number(year)) %>%
  ungroup() %>%
  select(year, type, index, name)

## [init]匹配省区信息1：初步----
# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <- tbl_raw  %>%
  #rename("name" = "value") %>%
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

tbl_check2 <- tbl_info %>%
  filter(is.na(province))
if (nrow(tbl_check)>0) warning("存在省份信息缺省情况！")

## [init]匹配机构信息----
### 机构名称列表（唯一化处理）----
tbl_out <- bind_rows(tbl_check, tbl_check2) %>%
  select(name) %>%
  unique() %>%
  rename("institution"= "name")

data("queryTianyan")
dt_match <- queryTianyan %>%
  select(name_origin, province) %>%
  rename(institution = "name_origin")

data("ProvinceCity")
dt_city <- ProvinceCity %>%
  select( city_clean, province_clean)

ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse =  "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse =  "|")


list_institution <- tbl_out %>%
  mutate(institution_raw = institution) %>%
  #use only the first institution
  mutate(
    institution = map_chr(
      .x = institution_raw,
      .f = function(x) as.character(unlist(str_split(x, pattern='、'))[[1]]) 
    )
  ) %>%
  select(institution) %>%
  unique() %>%
  left_join(., dt_match, by= "institution" ) %>%
  # filter obvious province info
  mutate(province_raw = str_extract(institution, ptn_province)) %>%
  mutate(province = ifelse(is.na(province), province_raw, province)) %>%
  # match city
  mutate(city_clean = str_extract(institution, ptn_city)) %>%
  left_join(., dt_city, by= "city_clean" ) %>%
  mutate(province = ifelse(is.na(province), province_clean, province)) %>%
  filter(is.na(province)) %>%
  select(institution) %>%
  arrange(institution)

# check 
(check <- sum(!is.na(list_institution$institution)))
if(check > 0) stop("please check the name of institution!")

dir_xlsx <- "d:/github/techme/data-raw/data-tidy/hack-tianyan/ship/"
file_xlsx <- glue::glue("ship-tot{nrow(list_institution)}-{Sys.Date()}.xlsx")
(path_xlsx <- paste0(dir_xlsx, file_xlsx))

openxlsx::write.xlsx(list_institution, path_xlsx)



### 在R包techme中进行天眼查----
# - 循环查询# 
# - 得到结果，并人工确认# 
# - 重新整合更新`qureyTianyan`# 
# - build 并push `techme`# 
# - 在repo `tech-report`中安装更新后的R包`techme`
# - `renv::install("huhuaping/techme")`


## 匹配省区信息2：加省区----

# files xlsx path
tbl_wide <- tbl_out 

data("ProvinceCity")
dt_city <- ProvinceCity %>%
  select( city_clean, province_clean)

ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse =  "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse =  "|")


tbl_province <- tbl_wide %>%
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

## 匹配省区信息2：加机构信息----

data("queryTianyan")
dt_match <- queryTianyan %>%
  select(name_origin, province) %>%
  rename(institution = "name_origin")

tbl_inst <- tbl_province %>%
  select(year, type, index, name, province) %>%
  # replicate new columns
  rename("institution" = "name", 
         "province_known" = "province") %>%
  mutate(institution_raw = institution) %>%
  #use only the first institution
  mutate(
    institution = map_chr(
      .x = institution_raw,
      .f = function(x) as.character(unlist(str_split(x, pattern='、'))[[1]]) 
    )
  ) %>%
  # match `queryTianyan`
  left_join(., dt_match, by = "institution") %>%
  rename(province_match = "province" ) %>%
  # combine matched province from `queryTianyan`
  mutate(province = ifelse(is.na(province_known),
                           province_match,
                           province_known)) %>%
  select(year, type, index, institution, province ) 

# just for check 

(check <- sum(is.na(tbl_inst$province)))
tbl_check <- tbl_inst %>%
  filter(is.na(province))

if (check > 0) {
  warning(glue::glue("{check} province not indentified, please check it!"))
  which(is.na(tbl_inst$province))
}


## 导出年度xlsx----
type_tar <- "list"
files_dir <- "topic/public-site/moa-rural-infobase/xlsx"
(file_name <- glue("{type_tar}-year-{Year}.xlsx"))
(file_path <- here(glue("{files_dir}/{file_name}")))

write.xlsx(tbl_inst, file_path)

