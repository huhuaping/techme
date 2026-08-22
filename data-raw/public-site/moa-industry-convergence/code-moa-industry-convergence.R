## R包准备----
require(openxlsx)
#require("xml2")
source("data-raw/deps/load-core.R")
source("data-raw/deps/load-scrape.R")
require("here")
library(glue)


## techme维护数据集----

### 准备基本参数----

dir_path <- "data-raw/public-site/moa-industry-convergence/xlsx/"
files_xlsx <- list.files(here(dir_path))
k <- 3 # 选择

### 循环读取----
data_names <- c(
  "park-setup","cluster-setup", "town-setup",
  "park-affirm"  # 产业园认定
)
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

use_list <- c(
  "PubConvergencePark",
  "PubConvergenceCluster",
  "PubConvergenceTown",
  "PubConvergenceAffirm"  # 产业园认定
)
dir_path <- "D:/github/techme/data-raw/public-site/"
(data_path <- glue("{dir_path}{use_list[k]}.rda"))

save(tbl_out, file = data_path)

### 在techme包项目中更新----
#### "D:/github/techme/data-raw/wfl_useData_universe.R"
# use_data()
# use_r()
# document()

## 农业产业融合发展项目----

### 1.2026年农业产业融合发展项目html转yaml----
### html文件路径：data-raw/public-site/moa-industry-convergence/html/project-setup-year-2026.html
### yaml文件路径：data-raw/public-site/moa-industry-convergence/yaml/project-setup-year-2026.yaml
###
### yaml 对照公示 html 手工整理（本脚本不解析 html），作为 2026 年起的权威中间层。
### 规范对齐 moa-machine-county 的公示 yaml，并保证能落到往年 xlsx 列：
### - 顶层标量：year / title / source / url / pub_date
### - 三类名单分键：park / cluster / town
### - park/cluster 条目：index, name_raw, name, province, province_raw, place
###     name 与往年 xlsx 对齐（park 补全「现代农业产业园」后缀）
###     province 用 BasicProvince 简称；兵团/农垦按往年规则归并
### - town 条目：index, province, province_raw, towns（序列）, n_town
###     导出 xlsx 时按 province 合并，town 拼成顿号串（与往年 town-setup 一致）
### - 导出 xlsx 列：park/cluster = year,index,name,province；town = year,index,province,town,n
###
### 以后改名单：先改 yaml，再从下面「yaml转xlsx」重跑。

### 2.2026年农业产业融合发展项目yaml转xlsx----
### 分类别转xlsx，包括
### a.现代农业产业园项目xlsx,文件名：/xlsx/project-setup-year-2026-park.xlsx
### b.优势特色产业集群项目xlsx,文件名：/xlsx/project-setup-year-2026-cluster.xlsx
### c.农业产业强镇项目xlsx,文件名：/xlsx/project-setup-year-2026-town.xlsx
### 同时另存为往年循环读取用的 {type}-setup-year-2026.xlsx，列与 2025 完全一致

Year <- 2026
require("yaml")
dir_case <- here("data-raw/public-site/moa-industry-convergence")
file_yaml <- here(dir_case, glue("yaml/project-setup-year-{Year}.yaml"))
dir_xlsx <- here(dir_case, "xlsx")
dir.create(dir_xlsx, recursive = TRUE, showWarnings = FALSE)
if (!file.exists(file_yaml)) {
  stop("未找到 2026 年公示 yaml：", file_yaml)
} else {
  message(glue("已找到 2026 年公示 yaml：{file_yaml}"))
}

# yaml::read_yaml() 会把 null 收成 NULL，先转成 NA 再逐条拼行
yaml_chr <- function(x) {
  if (is.null(x) || length(x) == 0L) NA_character_ else as.character(x)
}
yaml_int <- function(x) {
  if (is.null(x) || length(x) == 0L) NA_integer_ else as.integer(x)
}

yml_read <- yaml::read_yaml(file_yaml)
if (is.null(yml_read$park) || is.null(yml_read$cluster) || is.null(yml_read$town)) {
  stop("YAML 缺少 park/cluster/town 列表：", file_yaml)
}

tbl_park <- purrr::map_dfr(yml_read$park, function(item) {
  tibble::tibble(
    year = yaml_int(yml_read$year),
    index = yaml_int(item$index),
    name = yaml_chr(item$name),
    province = yaml_chr(item$province)
  )
})

tbl_cluster <- purrr::map_dfr(yml_read$cluster, function(item) {
  tibble::tibble(
    year = yaml_int(yml_read$year),
    index = yaml_int(item$index),
    name = yaml_chr(item$name),
    province = yaml_chr(item$province)
  )
})

# 往年 town-setup 是一省一行；兵团/农垦已归并到同一简称，这里再按省合并
tbl_town <- purrr::map_dfr(yml_read$town, function(item) {
  towns <- if (is.null(item$towns)) character() else as.character(unlist(item$towns))
  tibble::tibble(
    year = yaml_int(yml_read$year),
    province = yaml_chr(item$province),
    town = paste(towns, collapse = "、"),
    n = length(towns)
  )
}) |>
  dplyr::group_by(year, province) |>
  dplyr::summarise(
    town = paste(town, collapse = "、"),
    n = sum(n),
    .groups = "drop"
  ) |>
  dplyr::mutate(index = dplyr::row_number()) |>
  dplyr::select(year, index, province, town, n)
# 检查数据
if (interactive()) {
  View(tbl_park)
  View(tbl_cluster)
  View(tbl_town)
}

# 新工作流文件名 + 往年 {type}-setup-year-{Year}.xlsx 别名，后者给文件头循环 bind 用
## 同时写入data-raw和data-tidy文件夹下：
## - data-raw/public-site/moa-industry-convergence/xlsx/
## - data-raw/data-tidy/public-site/moa-industry-convergence/xlsx
write_type_xlsx <- function(dt, type_key) {
  dir_raw <- here("data-raw/public-site/moa-industry-convergence/xlsx/")
  dir_tidy <- here("data-raw/data-tidy/public-site/moa-industry-convergence/xlsx/")
  #dir.create(dir_raw, recursive = TRUE, showWarnings = FALSE)
  dir.create(dir_tidy, recursive = TRUE, showWarnings = FALSE)
  path_raw <- here(dir_raw, glue("{type_key}-setup-year-{Year}.xlsx"))
  path_tidy <- here(dir_tidy, glue("{type_key}-setup-year-{Year}.xlsx"))
  openxlsx::write.xlsx(dt, path_raw, overwrite = TRUE)
  openxlsx::write.xlsx(dt, path_tidy, overwrite = TRUE)
  message(glue("已写出raw xlsx：{basename(path_raw)} 与 tidy xlsx：{basename(path_tidy)}（{nrow(dt)} 行）"))
}
write_type_xlsx(tbl_park, "park")
write_type_xlsx(tbl_cluster, "cluster")
write_type_xlsx(tbl_town, "town")



### html转txt----

#### 读取公示文件txt----
# files html path
Year <- 2025
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence", # dir
  glue::glue("html/project-setup-year-{Year}.txt"))   # file


tbl_raw <- read_lines(files_dir,skip_empty_rows = TRUE) %>%
  as_tibble()

#### 清洗数据表----
tbl_tidy <- tbl_raw %>%
  mutate(
    type = case_when(
      str_detect(value,"现代农业产业园项目") ~ "park",
      str_detect(value,"优势特色产业集群项目") ~ "cluster",
      str_detect(value,"农业产业强镇项目") ~ "town"
      )
  ) %>%
  # 填充分组
  fill(type, .direction = "down") %>%
  # 去掉分组标志行
  filter(!str_detect(value, "附件")) %>%
  # 去掉空格
  mutate(value = str_trim(value, side = "both")) %>%
  # 去掉序号标志
  mutate(value = mgsub::mgsub(value, "^\\d{1,2}\\.", ""))%>%
  # 去掉空格
  mutate(value = str_trim(value, side = "both")) %>%
  # 获得名称
  mutate(
    name = ifelse(
      str_detect(value, "："),
      str_extract(value, "(?<=：)(.+)"),
      value
      )
  ) %>%
  # 补全园区名称
  mutate(
    name = ifelse(
      type == "park",
      str_c(name, "现代农业产业园"),
      name
    )
  )

#### 匹配省区信息----
# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <- tbl_tidy  %>%
  # 获得部分省份信息
  mutate(
    province_read = str_extract(value, "(.+)(?=：)")
  ) %>%
  # 获得全部省区信息
  mutate(
    province_read = ifelse(
      is.na(province_read),
      str_extract(value, ptn_province),
      province_read
      )
    ) %>%
  # 统一省区名称
  mutate(
    province_clean = str_extract(province_read, ptn_province)
  ) %>%
  # 处理异常省区关系
  mutate(
    province_clean = ifelse(
      is.na(province_clean),
      mgsub::mgsub(
        province_read,
        c("北大荒农垦集团"),
        c("黑龙江")
        ),
      province_clean
    )
  ) %>%
  select(-value)

#### 添加整理信息----
tbl_out <- tbl_info %>%
  # 添加年份信息
  mutate(year = Year) %>%
  # 添加序号信息
  group_by(type) %>%
  mutate(index = row_number(type)) %>%
  ungroup() %>%
  select(type, year, index, name, province_clean) %>%
  # 重命名
  rename(province = province_clean)

#### check province contains NA
sum(is.na(tbl_out$province)) # 0

View(tbl_out)

#### 导出park年度xlsx----
type_tar <- "park"
files_dir <- "data-raw/public-site/moa-industry-convergence/xlsx/"
(file_name <- glue("{type_tar}-setup-year-{Year}.xlsx"))
(file_path <- here(glue("{files_dir}/{file_name}")))

tbl_park <- tbl_out %>%
  filter(type == type_tar) %>%
  select(year, index, name, province)

write.xlsx(tbl_park, file_path)

#### 导出cluster年度xlsx----
type_tar <- "cluster"
files_dir <- "data-raw/public-site/moa-industry-convergence/xlsx/"
(file_name <- glue("{type_tar}-setup-year-{Year}.xlsx"))
(file_path <- here(glue("{files_dir}/{file_name}")))

tbl_cluster <- tbl_out %>%
  filter(type == type_tar) %>%
  select(year, index, name, province)

write.xlsx(tbl_cluster, file_path)


#### 导出town年度xlsx----
type_tar <- "town"
files_dir <- "data-raw/public-site/moa-industry-convergence/xlsx/"
(file_name <- glue("{type_tar}-setup-year-{Year}.xlsx"))
(file_path <- here(glue("{files_dir}/{file_name}")))

tbl_town <- tbl_out %>%
  filter(type == type_tar) %>%
  # 合并同省份的乡镇信息
  group_by(province) %>%
  mutate(
    name = str_c(name, collapse = "、")
  ) %>%
  ungroup() %>%
  distinct(year, province, name) %>%
  # 计算乡镇数量
  mutate(n = str_count(name, "、") +1) %>%
  # 重新添加序号
  mutate(index = 1:nrow(.)) %>%
  # 重命名
  rename( "town" = "name") %>%
  select(year, index, province, town, n)

View(tbl_town)
write.xlsx(tbl_town, file_path)

## 现代农业产业园认定----

### 读取html----
#### 通过notepad，事先编辑<div class="park-confirm">
Year <- 2018
files_dir <- here(
  "topic/public-site/moa-industry-convergence", # dir
  glue::glue("html/park-affirm-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.park-confirm"
tbl_raw <- read_html(files_dir) %>%
  html_nodes(css =  css_tar) %>%
  html_text() %>%
  str_split("\r\n") %>% # split by "\n"
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(value = mgsub::mgsub(value,                 c(fixed("\u00a0"),fixed("\n")," "),
                              c("", "","")),
         value = str_trim(value)) %>%
  filter(value!="") %>% # drop empty row
  mutate(value = str_extract(value, "(?<=\\.).+"))


### 匹配省区信息----
# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <- tbl_raw  %>%
 # 获得全部省区信息
  mutate(
    province_clean = str_extract(value, ptn_province)
  )  %>%
  # 处理异常识别
  mutate(
    province_clean = ifelse(
      is.na(province_clean) & str_detect(value, "北大荒"),
      "黑龙江",
      province_clean
    )
  )
# 核验省份是否齐全
tbl_check <- tbl_info %>%
  filter(is.na(province_clean))

### 添加整理信息----
tbl_out <- tbl_info %>%
  rename("name" = "value", "province"="province_clean") %>%
  # 添加年份信息
  mutate(year = Year) %>%
  # 添加序号信息
  mutate(index = row_number(year)) %>%
  select(year, index, name, province)

### 导出park-affirm年度xlsx----
type_tar <- "park"
files_dir <- "topic/public-site/moa-industry-convergence/xlsx/"
(file_name <- glue("{type_tar}-affirm-year-{Year}.xlsx"))
(file_path <- here(glue("{files_dir}/{file_name}")))

write.xlsx(tbl_out, file_path)

## 现代农业产业园创建park（备份）----

### 解析html----

#### 2017 html <div>----

# files html path
Year <- 2017
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/park-setup-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.park"

tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_text() %>%
  str_split("\r\n") %>% # split by "\n"
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(value = mgsub::mgsub(value,                 c(fixed("\u00a0"),fixed("\n")," "),
                              c("", "","")),
         value = str_trim(value)) %>%
  filter(value!="") %>% # drop empty row
  mutate(value = str_extract(value, "(?<=\\.).+"))

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index")


#### 2018 html <div>----
# files html path
Year <- 2018
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/park-setup-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.park"

tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_text() %>%
  str_split("\r\n") %>% # split by "\n"
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(value = mgsub::mgsub(value,                 c(fixed("\u00a0"),fixed("\n")," "),
                              c("", "","")),
         value = str_trim(value)) %>%
  filter(value!="") %>% # drop empty row
  mutate(value = str_extract(value, "(?<=\\.).+"))

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index")


#### 2019 html <table>----

> 说明：源url的html文档中table 嵌套了table，手动修改为并行的两个table

# files html path
Year <- 2019
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/park-setup-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"table.park"

tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_table() %>% # get two tables
  bind_rows() %>%  # combine tables
  as_tibble() %>%
  rename("value" = "X1") %>%
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

#### 2020 html <div>----
# files html path
Year <- 2020
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/park-setup-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.park"

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



#### 2021-2023 html <div>----

# files html path
Year <- 2023
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/project-setup-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))
(path_out <- str_replace_all(path_out, "project", "park")) # change

# xpath for data table
css_tar <-"div.park"
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


### 导出到xlsx/文件夹----

# files csv path
(path_out)
write.xlsx(tbl_out, path_out)


### 导出为分析数据----

#### 批量读取xlsx----

dir_path <- here::here("topic","public-site","moa-industry-convergence","xlsx")

files_xlsx <- list.files(dir_path)


files_target <- files_xlsx[which(str_detect(files_xlsx, "park-setup")) ]

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
}


#### 匹配省区信息----

# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <-  tbl_out %>%
  mutate(province_name = str_extract(name, ptn_province),
         city_clean= str_extract(name, ptn_city)) %>%
  # match
  left_join(., select(ProvinceCity, city_clean, province_clean), by = "city_clean") %>%
  mutate(province = ifelse(is.na(province_name),
                           province_clean,
                           province_name)) %>%
  select(year, index, name, province) %>%
  mutate(
    province =ifelse(
      # case NA: index 2022-50
      name=="北大荒农垦集团有限公司北安分公司现代农业产业园",
      "黑龙江",
      province)
  )
# fill province,
# assumed the firs firm is identified exactly
#fill(province, .direction = "down")

# check
check <- sum(is.na(tbl_info$province))
if (check >0) warning("Povince with NA, please check!")

tbl_check <- tbl_info %>%
  group_by(year) %>%
  slice_tail(n = 3) %>%
  ungroup() %>%
  arrange(year,index)

#### 导出到data-update/文件夹----
dir_path <- here::here("data-raw","public-site","moa-industry-convergence","data-update")
(path_out <- paste0(dir_path, "/park-setup-upto-year-", max(years_target), ".xlsx"))
write.xlsx(tbl_info, path_out)


## 优势特色产业集群cluster（备份）----

### 解析html----

#### 2020 html <table>----
####说明：源url的html文档中table 嵌套了table，手动修改为并行的两个table

# files html path
Year <- 2020
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/cluster-setup-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"table.cluster"

tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_table() %>% # get two tables
  bind_rows() %>%  # combine tables
  as_tibble() %>%
  rename("value" = "X2") %>%
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
  add_column(year = Year, .before = "index") %>%
  select(year, index, name)

#### 2021-2023 html <div>----
# files html path
Year <- 2023
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/project-setup-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))
(path_out <- str_replace_all(path_out, "project", "cluster")) # change
# xpath for data table
css_tar <-"div.cluster"

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


### 导出到xlsx/文件夹----
# files csv path
(path_out)
write.xlsx(tbl_out, path_out)

### 导出为分析数据----

#### 批量读取xlsx----

dir_path <- here::here("topic","public-site","moa-industry-convergence","xlsx")
files_xlsx <- list.files(dir_path)

files_target <- files_xlsx[which(str_detect(files_xlsx, "cluster-setup")) ]

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
}


#### 匹配省区信息----

# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <-  tbl_out %>%
  mutate(province_name = str_extract(name, ptn_province),
         city_clean= str_extract(name, ptn_city)) %>%
  # match
  left_join(., select(ProvinceCity, city_clean, province_clean), by = "city_clean") %>%
  mutate(province = ifelse(is.na(province_name),
                           province_clean,
                           province_name)) %>%
  select(year, index, name, province) %>%
  mutate(
    province =ifelse(
      # case NA: index 2023-39
      is.na(province) & str_detect(name, "北大荒"),
      "黑龙江",
      province)
  )
# fill province,
# assumed the firs firm is identified exactly
#fill(province, .direction = "down")

# check
check <- sum(is.na(tbl_info$province))
if (check >0) warning("Povince with NA, please check!")

tbl_check <- tbl_info %>%
  group_by(year) %>%
  slice_tail(n = 3) %>%
  ungroup() %>%
  arrange(year,index)

#### 导出到data-update/文件夹----
dir_path <- here::here("data-raw","public-site","moa-industry-convergence","data-update")
(path_out <- paste0(dir_path, "/cluster-setup-upto-year-", max(years_target), ".xlsx"))
write.xlsx(tbl_info, path_out)


## 农业产业强镇town（备份）----

### 解析html----

#### 2018 xlsx----

# files html path
Year <- 2018
(files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/town-setup-year-{Year}.xlsx")))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.cluster"

tbl_raw <- read.xlsx(files_dir,
                     rows = 4:37,
                     colNames = FALSE )

names_chn <- c("index", "province", "town", "n")
tbl_out <- tbl_raw %>%
  rename_all(., ~names_chn)  %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  mutate(n = as.numeric(n)) %>%
  select(year, index, province, town, n)


#### 2019 html <table>----

# files html path
Year <- 2019
(files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/town-setup-year-{Year}.html")))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"table.town"
tbl_raw <- read_html(files_dir,encoding = "UTF-8") %>%
  html_nodes(css =  css_tar) %>%
  html_table(header = T) %>% # get two tables
  bind_rows() %>%  # combine tables
  as_tibble() %>%
  filter(`序号`!="合计")

names_chn <- c("index", "province", "town", "n")
tbl_out <- tbl_raw %>%
  rename_all(., ~names_chn)  %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  mutate(n = as.numeric(n)) %>%
  select(year, index, province, town, n)

#### 2020 html <div>----

# files html path
Year <- 2020
(files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/town-setup-year-{Year}.html")))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))

# xpath for data table
css_tar <-"div.town"

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
  filter(value!="")

tbl_out <- tbl_raw %>%
  separate(value, into = c("province", "town"), sep = "：") %>%
  # count towns
  mutate(n = str_count(town, "、") +1) %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  mutate(n = as.numeric(n)) %>%
  select(year, index, province, town, n)

#### 2021-2023 html <div>----

# files html path
Year <- 2023
files_dir <- here(
  "data-raw/public-site/moa-industry-convergence/", # dir
  glue::glue("html/project-setup-year-{Year}.html"))   # file
(path_out <- str_replace_all(files_dir, "html", "xlsx"))
(path_out <- str_replace_all(path_out, "project", "town")) # change

# xpath for data table
css_tar <-"div.town"

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
  filter(value!="") #%>% # drop empty row
#mutate(value = str_extract(value, "(?<=\\.).+"))

tbl_out <- tbl_raw %>%
  separate(value, into = c("province", "town"), sep = "：") %>%
  # count towns
  mutate(n = str_count(town, "、") +1) %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  mutate(n = as.numeric(n)) %>%
  select(year, index, province, town, n)

### 导出到xlsx/文件夹----

# files csv path
(path_out)
write.xlsx(tbl_out, path_out)

### 导出为分析数据----
#### 批量读取xlsx----

dir_path <- here::here("topic","public-site","moa-industry-convergence","xlsx")
files_xlsx <- list.files(dir_path)

files_target <- files_xlsx[which(str_detect(files_xlsx, "town-setup")) ]

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
}


#### 匹配省区信息----

# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <-  tbl_out %>%
  rename("province_source" = "province") %>%
  # clean
  mutate(province_name = str_extract(province_source, ptn_province),
         city_clean= str_extract(province_source, ptn_city)) %>%
  # match
  left_join(., select(ProvinceCity, city_clean, province_clean), by = "city_clean") %>%
  mutate(province = ifelse(is.na(province_name),
                           province_clean,
                           province_name)) %>%
  # filter(is.na(province))
  # special case
  mutate(
    province =ifelse(
      # case NA: index 2023-39
      is.na(province) & str_detect(province_source, "北大荒"),
      "黑龙江",
      province)
  ) %>%
  select(year, index, province, town, n)

# check
check <- sum(is.na(tbl_info$province))
if (check >0) warning("Povince with NA, please check!")
tbl_check <- tbl_info %>%
  filter(is.na(province))
tbl_check <- tbl_info %>%
  group_by(year) %>%
  slice_tail(n = 3) %>%
  ungroup() %>%
  arrange(year,index)

#### 导出到data-update/文件夹----
dir_path <- here::here("data-raw","public-site","moa-industry-convergence","data-update")
(path_out <- paste0(dir_path, "/town-setup-upto-year-", max(years_target), ".xlsx"))
write.xlsx(tbl_info, path_out)

## 过度代码（弃用）----

tbl_export <- tbl_info %>%
  select(year, index, province, town, n)%>%
  # 合并同省份的乡镇信息
  group_by(year, province) %>%
  mutate(
    town = str_c(town, collapse = "、")
  ) %>%
  ungroup() %>%
  distinct(year, province, town) %>%
  # 计算乡镇数量
  mutate(n = str_count(town, "、") +1) %>%
  group_by(year) %>%
  # 重新添加序号
  mutate(index = row_number(year)) %>%
  ungroup() %>%
  select(year, index, province, town, n)

#### 导出town年度xlsx----

years_tar <-sort(unique(tbl_export$year))
type_tar <- "town"
files_dir <- "topic/public-site/moa-industry-convergence/xlsx/"

i <- 1
for (i in 1:length(years_tar)){
  (file_name <- glue("{type_tar}-setup-year-{years_tar[i]}.xlsx"))
  (file_path <- here(glue("{files_dir}/{file_name}")))
  tbl_export %>%
    filter(year == years_tar[i]) %>%
    write.xlsx(., file_path)
}



tbl_check <- tbl_export %>%
  group_by(province) %>%
  summarise(n = sum(n))


