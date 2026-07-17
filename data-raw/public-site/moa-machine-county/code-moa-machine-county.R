## 准备R�?---
source("data-raw/deps/load-core.R")
source("data-raw/deps/load-scrape.R")
require("here")
require("glue")
require("openxlsx")

## 引入省份信息----
###把省份信息导进来
# basic province info
path_script <- here::here("R","get.province.R")
source(path_script, encoding = "utf-8")

province <- techme::BasicProvince
province_list <- province$province
pattern_list <- paste0(province_list, collapse = "|")

## 确定参数----
Year <- 2024
(file_path <- here(glue("topic/public-site/moa-machine-county/html/list-year-{Year}.html")))
if(!fs::file_exists(file_path)) cat("目标文件不存在！")

## 抓取年度数据----

### 抓取html-year2016----

# xpath for data table
css_tbl <- "body > div.main.bjjM.hd_wzxq > div.border.pd_rl_24.hd_zbftMPContent > div.arc_body.mg_auto.w_855.pd_b_35 > div.TRS_PreAppend > p:nth-child(n+4)"
#xpath_tbl <- "//*[@id='Zoom']/table"

tbl_raw <- read_html(file_path,encoding = "UTF-8") %>%
  html_nodes(css =  css_tbl) %>%
  html_text() 

#title_list <- c("index", "name", "institution", "administrator", "result")

tbl_out <- tbl_raw %>%
  as_tibble() %>%
  separate(col = "value", into=c("index", "name"))%>%
  #rename_at(all_of(names(.)), ~title_list) %>%
  type_convert(cols(index=col_number())) %>%
  # extract the province 
  mutate(province = str_extract(name, pattern_list)) %>%
  # hand the extra city
  #mutate(province= mgsub::mgsub(province, list_extra, list_norm)) %>%
  mutate(county=gsub("(.+省|自治�?", "", name, perl=T)) %>%
  mutate(county=gsub("(.*北京市|天津市|上海�?", "", county, perl=T)) %>%
  add_column(year=Year, .before = "index") %>%
  add_column(batch ="第一�?, .before = "index") %>%
  add_column(id= 1:nrow(.), .before = "index") %>%
  select(-name)

# files csv path
path_out <- paste0("xlsx/list-year-",Year, ".xlsx")
write.xlsx(tbl_out, path_out)



### 抓取html-year2017----
# xpath for data table
css_tbl <- "body > div.main.bjjM.hd_wzxq > div.border.pd_rl_24.hd_zbftMPContent > div.arc_body.mg_auto.w_855.pd_b_35 > div.TRS_Editor > div > p:nth-child(n+10)"
#xpath_tbl <- "//*[@id='Zoom']/table"

tbl_raw <- read_html(file_path,encoding = "UTF-8") %>%
  html_nodes(css =  css_tbl) %>%
  html_text() 

title_list <- c("index", "name", "institution", "administrator", "result")

tbl_out <- tbl_raw %>%
  as_tibble() %>%
  mutate(value=gsub("\u00a0", ";", value)) %>%
  separate(col = "value", into=c("province", "county"), sep = ";")%>%
  mutate(county= str_trim(county, side="both")) %>%
  add_column(index=1:nrow(.), .before = "province") %>%
  type_convert(cols(index=col_number())) %>%
  # extract the province 
  mutate(province = str_extract(province, pattern_list)) %>%
  # hand the extra city
  mutate(province= mgsub::mgsub(province, list_extra, list_norm)) %>%
  #filter(is.na(province))
  mutate(county = map(county, .f = function(county){unlist(str_split(county, "�?))})) %>%
  #select(-county) %>%
  unnest(county) %>%
  #rename_at(all_of(names(.)), ~title_list) %>%
  add_column(year=Year, .before = "index") %>%
  add_column(batch ="第二�?, .before = "index") %>%
  add_column(id= 1:nrow(.), .before = "index")

# files csv path
path_out <- paste0("xlsx/list-year-",Year, ".xlsx")
write.xlsx(tbl_out, path_out)


### 抓取html-year2018----
# xpath for data table
#css_tbl <- "body > div.main.bjjM.hd_wzxq > div.border.pd_rl_24.hd_zbftMPContent > div.arc_body.mg_auto.w_855.pd_b_35 > div.TRS_Editor > div > p:nth-child(n+10)"
xpath_tbl <- "/html/body/div[3]/div/div[2]/div/div/table"

tbl_raw <- read_html(file_path,encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tbl) %>%
  html_table() %>%
  .[[1]]

title_list <- c("province", "county")
tbl_out <- tbl_raw %>%
  as_tibble() %>%
  rename_at(all_of(names(.)), ~title_list) %>%
  add_column(index=1:nrow(.), .before = "province") %>%
  # extract the province 
  mutate(province = str_extract(province, pattern_list)) %>%
  # hand the extra city
  mutate(province= mgsub::mgsub(province, list_extra, list_norm)) %>%
  #filter(is.na(province))
  mutate(county = map(county, .f = function(county){unlist(str_split(county, "�?))})) %>%
  #select(-county) %>%
  unnest(county) %>%
  #rename_at(all_of(names(.)), ~title_list) %>%
  add_column(year=Year, .before = "index") %>%
  add_column(batch ="第三�?, .before = "index") %>%
  add_column(id= 1:nrow(.), .before = "index")

# files csv path
path_out <- paste0("xlsx/list-year-",Year, ".xlsx")
write.xlsx(tbl_out, path_out)

### 抓取html-year2019----
# xpath for data table
#css_tbl <- "body > div.main.bjjM.hd_wzxq > div.border.pd_rl_24.hd_zbftMPContent > div.arc_body.mg_auto.w_855.pd_b_35 > div.TRS_Editor > div > p:nth-child(n+10)"
xpath_tbl <- "/html/body/div[2]/div[4]/div/div[3]/div[2]/table"

tbl_raw <- read_html(file_path,encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tbl) %>%
  html_table() %>%
  .[[1]]

title_list <- c("province", "county")

tbl_out <- tbl_raw %>%
  as_tibble() %>%
  rename_at(all_of(names(.)), ~title_list) %>%
  add_column(index=1:nrow(.), .before = "province") %>%
  # extract the province 
  mutate(province = str_extract(province, pattern_list)) %>%
  # hand the extra city
  mutate(province= mgsub::mgsub(province, list_extra, list_norm)) %>%
  #filter(is.na(province))
  mutate(county = map(county, .f = function(county){unlist(str_split(county, "�?))})) %>%
  #select(-county) %>%
  unnest(county) %>%
  #rename_at(all_of(names(.)), ~title_list) %>%
  add_column(year=Year, .before = "index") %>%
  add_column(batch ="第四�?, .before = "index") %>%
  add_column(id= 1:nrow(.), .before = "index")

# files csv path
path_out <- paste0("xlsx/list-year-",Year, ".xlsx")
write.xlsx(tbl_out, path_out)

### 抓取html-year2020----
# xpath for data table
#css_tbl <- "body > div.main.bjjM.hd_wzxq > div.border.pd_rl_24.hd_zbftMPContent > div.arc_body.mg_auto.w_855.pd_b_35 > div.TRS_Editor > div > p:nth-child(n+10)"
xpath_tbl <-"/html/body/div[2]/div[4]/div/div[3]/div[2]/table"

tbl_raw <- read_html(file_path,encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tbl) %>%
  html_table() %>%
  .[[1]]

title_list <- c("province", "county")

tbl_out <- tbl_raw %>%
  as_tibble() %>%
  rename_at(all_of(names(.)), ~title_list) %>%
  add_column(index=1:nrow(.), .before = "province") %>%
  # extract the province 
  mutate(province = str_extract(province, pattern_list)) %>%
  # hand the extra city
  mutate(province= mgsub::mgsub(province, list_extra, list_norm)) %>%
  #filter(is.na(province))
  mutate(county = str_squish(county),
         county = map(county, .f = function(county){unlist(str_split(county, "�?))})) %>%
  #select(-county) %>%
  unnest(county) %>%
  #rename_at(all_of(names(.)), ~title_list) %>%
  add_column(year=Year, .before = "index") %>%
  add_column(batch ="第五�?, .before = "index") %>%
  add_column(id= 1:nrow(.), .before = "index")

# files csv path
path_out <- paste0("xlsx/list-year-",Year, ".xlsx")
write.xlsx(tbl_out, path_out)

### 抓取html-year2021----
# xpath for data table
#css_tbl <- "body > div.main.bjjM.hd_wzxq > div.border.pd_rl_24.hd_zbftMPContent > div.arc_body.mg_auto.w_855.pd_b_35 > div.TRS_Editor > div > p:nth-child(n+10)"
xpath_tbl <-"/html/body/div[2]/div[4]/div/div[3]/div[2]/table"

tbl_raw <- read_html(file_path,encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tbl) %>%
  html_table() %>%
  .[[1]]

title_list <- c("province", "county")

tbl_out <- tbl_raw %>%
  as_tibble() %>%
  rename_at(all_of(names(.)), ~title_list) %>%
  add_column(index=1:nrow(.), .before = "province") %>%
  # extract the province 
  mutate(province = str_extract(province, pattern_list)) %>%
  # hand the extra city
  mutate(province= mgsub::mgsub(province, list_extra, list_norm)) %>%
  #filter(is.na(province))
  mutate(county = str_squish(county),
         county = map(county, .f = function(county){unlist(str_split(county, "�?))})) %>%
  #select(-county) %>%
  unnest(county) %>%
  #rename_at(all_of(names(.)), ~title_list) %>%
  add_column(year=Year, .before = "index") %>%
  add_column(batch ="第六�?, .before = "index") %>%
  add_column(id= 1:nrow(.), .before = "index") %>%
  mutate(province = ifelse(
    is.na(province),
    "黑龙�?, province) # special case
  )

# files csv path
path_out <- paste0("xlsx/list-year-",Year, ".xlsx")
write.xlsx(tbl_out, path_out)

### 抓取year 2022(html table)----
# css path for data table
css_tbl <-"table.county"
tbl_raw <- read_html(file_path, encoding = "UTF-8") %>%
  html_nodes(css = css_tbl) %>%
  html_table() %>%
  .[[1]]

title_list <- c("province", "county")

tbl_out <- tbl_raw %>%
  as_tibble() %>%
  rename_at(all_of(names(.)), ~title_list) %>%
  add_column(index=1:nrow(.), .before = "province") %>%
  # extract the province 
  mutate(province = str_extract(province, pattern_list)) %>%
  # hand the extra city
  mutate(province= mgsub::mgsub(province, list_extra, list_norm)) %>%
  #filter(is.na(province))
  mutate(county = str_squish(county),
         county = map(county, .f = function(county){unlist(str_split(county, "�?))})) %>%
  #select(-county) %>%
  unnest(county) %>%
  #rename_at(all_of(names(.)), ~title_list) %>%
  add_column(year=Year, .before = "index") %>%
  add_column(batch ="第七�?, .before = "index") %>%
  add_column(id= 1:nrow(.), .before = "index") %>%
  mutate(province = ifelse(
    is.na(province),
    "黑龙�?, province) # special case "北大荒农垦集团有限公�?
  )



# files csv path
(file_out <- paste0("xlsx/list-year-",Year, ".xlsx"))
(path_out <- paste0(dir_tar, file_out))
write.xlsx(tbl_out, path_out)

### 抓取year 2024(html table)----
#### 第一批农业生产全程机械化示范县创建名�?
#### 为了保持前向兼容，需要设定如下编码体�?

tbl_id <- tribble(
  ~id, ~cat,
  1, "农作�?, # 实际上id取值小�?65，都可以设定为该类别
  666, "养殖",
  777, "设施种植"#,
  #888,
)

# css path for data table
css_tbl <-"table"
tbl_raw <- read_html(file_path, encoding = "UTF-8") %>%
  html_nodes(css = css_tbl) %>%
  html_table() %>%
  .[[1]]

title_list <- c("province", "county")

tbl_out <- tbl_raw %>%
  as_tibble() %>%
  rename_at(all_of(names(.)), ~title_list)  %>%
  # 识别并确定类别id
  mutate(
    id_str = str_extract(province, paste0(tbl_id$cat, collapse = "|")),
    id = mgsub::mgsub(id_str, tbl_id$cat, tbl_id$id)
    ) %>%
  fill(id, .direction = "down") %>%
  mutate(id = as.numeric(id)) %>%
  filter(is.na(id_str)) %>%
  # extract the province 
  mutate(province = str_extract(province, pattern_list)) %>%
  mutate(county = str_squish(county), # 去掉空格
         county = map(county, .f = function(county){unlist(str_split(county, "�?))})) %>%
  unnest(county) %>%
  group_by(id, province) %>%
  mutate(index = row_number()) %>%
  ungroup() %>%
  add_column(year=Year, .before = "index") %>%
  add_column(batch ="第一�?, .before = "index") %>%
  select(year, batch, id, index, province, county)

# files csv path
(path_out <- here(glue("topic/public-site/moa-machine-county/xlsx/list-year-{Year}.xlsx")))
write.xlsx(tbl_out, path_out)

## 拷贝xlsx到包`techme`----

dir_from <- here("topic/public-site/moa-machine-county/")
dir_to <- "D:/github/techme/data-raw/data-tidy/public-site/moa-machine-county/"

### 第一次拷�?---
### 需要拷贝整个文件夹
isFirst <- TRUE
if (isFirst){
  fs::dir_create(path = dir_to)
  fs::dir_copy(
    path = paste0(dir_from, "/xlsx"), 
    new_path = paste0(dir_to, "xlsx"), #不需要斜�?
    overwrite = TRUE
  )  
}
### 后续更新拷贝----
### 只需要拷贝特定xlsx文件

## 导出为分析数�?---
### 读取并处理成分析数据�?

dir_path <- here::here("data-raw","public-site","moa-machine-county","xlsx")

files_xlsx <- list.files(dir_path)

files_target <- files_xlsx[which(str_detect(files_xlsx, "list")) ]

url_xlsx <- paste0(dir_path, "/", files_target)

years_target <- str_extract_all(files_target, "(\\d{4})") %>%
  unlist() %>%
  as.numeric(.)

tbl_out <- NULL

i <- 1
for (i in 1: length(files_target)) {
  
  tbl_tem <- read.xlsx(url_xlsx[i]) %>%
    mutate(index = as.numeric(index))
  
  tbl_out <- bind_rows(tbl_out, tbl_tem)
}


file_out <- paste0("data-update/wide-list-upto-year-",
                   max(years_target), 
                   ".xlsx")
(path_out <- paste0(dir_tar, file_out))

write.xlsx(tbl_out , path_out)
