# R包准�?---

require(openxlsx)
source("data-raw/deps/load-core.R")
source("data-raw/deps/load-scrape.R")
require("here")


# 3.1最新完整名单list----
# 并没有区分批次，仅供参�?
# 省份信息很有规律，可以手动添�?

## 读取2025年html----
## 保存html后直接手动转换为xlsx，手动添加省份列
# files html path
Year <- 2025
files_dir <- glue::glue("html/list-full-year-{Year}.html")




## 读取2023年html----
# files html path
Year <- 2023
files_dir <- glue::glue("html/list-full-year-{Year}.html")

# xpath for data table
css_tbl <- "body > div.main > div.border > div.arc_body > div.TRS_Editor > span:nth-child(3) > span > p:nth-child(n+5)"

xpath_tar <- "/html/body/div[3]/div/div[2]/div/div"

tbl_raw <- read_html(files_dir, encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tar) %>%
  html_text() %>%
  str_split("\n") %>% # split by "\n"
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(
    value = mgsub::mgsub(
      value, c(fixed("\u00a0"), fixed("\n"), " "),
      c("", "", "")
    ),
    value = str_trim(value)
  ) %>%
  filter(value != "") # drop empty row

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index")



## obtain the province info----
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <- tbl_out %>%
  mutate(
    province_name = str_extract(name, ptn_province),
    city_clean = str_extract(name, ptn_city)
  ) %>%
  # match
  left_join(., select(ProvinceCity, city_clean, province_clean), by = "city_clean") %>%
  mutate(province = ifelse(is.na(province_name),
    province_clean,
    province_name
  )) %>%
  select(year, index, name, province) %>%
  # fill province,
  # assumed the firs firm is identified exactly
  fill(province, .direction = "down")

# check
check <- sum(is.na(tbl_info$province))
if (check > 0) warning("Povince with NA, please check!")

tbl_check <- tbl_info %>%
  group_by(province) %>%
  slice_head(n = 1) %>%
  ungroup() %>%
  arrange(index)

# files csv path
path_out <- paste0("xlsx/list-full-year-", Year, ".xlsx")
write.xlsx(tbl_info, path_out)


## 导出为分析数�?---

dir_path <- here::here("data-raw", "public-site", "moa-firm-leader", "xlsx")
files_xlsx <- list.files(dir_path)

files_target <- files_xlsx[which(str_detect(files_xlsx, "list-full"))]
url_xlsx <- paste0(dir_path, "/", files_target)

years_target <- str_extract_all(files_target, "(\\d{4})") %>%
  unlist() %>%
  as.numeric(.)

tbl_out <- NULL

i <- 1
for (i in 1:length(files_target)) {
  tbl_tem <- read.xlsx(url_xlsx[i]) %>%
    mutate(index = as.numeric(index))

  tbl_out <- bind_rows(tbl_out, tbl_tem)
}

(path_out <- paste0("data-update/list-full-upto-year-", max(years_target), ".xlsx"))

write.xlsx(tbl_out, path_out)



# 3.2批次认定名单batch----

## 目标html文件----

# this chunk should run only once

## directory
dir_path <- here::here("data-raw", "public-site", "moa-firm-leader", "html")

## target html
files_html <- list.files(dir_path)
files_target <- files_html[which(str_detect(files_html, "^batch.+?\\.html$"))]

url_html <- paste0(dir_path, "/", files_target)

years_target <- str_extract_all(files_target, "(\\d{4})") %>%
  unlist() %>%
  as.numeric(.)


## 解析html----

### batch 1: 2000 (p>span)----

# files html path, and the year
i <- 1
(Year <- years_target[i])
(files_dir <- url_html[i])
file_save <- str_replace(files_target[i], "html", "xlsx")
# parse html
css_tar <- "p>span.cctt" # for year 2000
tbl_raw <- rvest::read_html(
  files_dir,
  # encoding = "UTF-8"
) %>%
  html_elements(css = css_tar) %>%
  # keep nbsp
  html_text2(preserve_nbsp = TRUE) %>%
  # clean
  str_replace_all("。\\n", "") %>%
  str_replace_all("\n\n", "\n") %>%
  str_split("\n") %>% # split by "\n"
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(
    value = mgsub::mgsub(
      value, c(fixed("\u00a0"), fixed("\n"), " "),
      c("", "", "")
    ),
    value = str_trim(value)
  ) %>%
  filter(value != "") # drop empty row

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index") %>%
  add_column(batch = i, .before = "index")


### batch 2: 2002 (table)----


# files html path, and the year
i <- 2
(Year <- years_target[i])
(files_dir <- url_html[i])
(file_save <- str_replace(files_target[i], "html", "xlsx"))

# parse html
css_tar <- "#content > div.dynamic-detail.white > div.dynamic-detail__content > table"

tbl_raw <- rvest::read_html(
  files_dir,
  encoding = c(
    # "bg2312","UTF-8",  # not as meta "charset=gb2312"
    "GB18030", "big5"
  )
) %>%
  html_elements(css = css_tar) %>%
  html_table() %>%
  .[[1]] %>%
  as_tibble() %>%
  rename("value" = "X1") %>%
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"), fixed("\n"), " "),
      c("", "", "")
    ),
    value = str_trim(value)
  ) %>%
  filter(value != "") # drop empty row

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index") %>%
  add_column(batch = i, .before = "index")



### batch 3: 2004 (p>span)----


# files html path, and the year
i <- 3
(Year <- years_target[i])
(files_dir <- url_html[i])
(file_save <- str_replace(files_target[i], "html", "xlsx"))

# parse html
css_tar <- "div >p[style*='text-indent: 28pt'] "

tbl_raw <- rvest::read_html(
  files_dir,
  encoding = c(
    # "bg2312",
    "UTF-8" # ,
    # "GB18030","big5"
  )
) %>%
  html_elements(css = css_tar) %>%
  html_text() %>%
  unlist() %>%
  as_tibble() %>%
  .[-1, ] %>% # drop the header row
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"), fixed("\n"), " "),
      c("", "", "")
    ),
    value = str_trim(value)
  ) %>%
  filter(value != "") # drop empty row

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index") %>%
  add_column(batch = i, .before = "index")



### batch 4: 2008 (p>span)----


# files html path, and the year
i <- 4
(Year <- years_target[i])
(files_dir <- url_html[i])
(file_save <- str_replace(files_target[i], "html", "xlsx"))

# parse html
css_tar <- "div >p[style*='text-indent: -28pt'] "

tbl_raw <- rvest::read_html(
  files_dir,
  encoding = c(
    # "bg2312",
    "UTF-8" # ,
    # "GB18030","big5"
  )
) %>%
  html_elements(css = css_tar) %>%
  html_text() %>%
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"), fixed("\n"), " "),
      c("", "", "")
    ),
    value = str_trim(value)
  ) %>%
  filter(value != "") # drop empty row

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index") %>%
  add_column(batch = i, .before = "index")



### batch 5: 2011 (p>span)----


# files html path, and the year
i <- 5
(Year <- years_target[i])
(files_dir <- url_html[i])
(file_save <- str_replace(files_target[i], "html", "xlsx"))

# parse html
css_tar <- "p > span:nth-child(2)[style*='font-size: 14pt']"

tbl_raw <- rvest::read_html(
  files_dir,
  encoding = c(
    # "bg2312",
    "UTF-8" # ,
    # "GB18030","big5"
  )
) %>%
  html_elements(css = css_tar) %>%
  html_text() %>%
  unlist() %>%
  as_tibble() %>%
  .[-c(1:3), ] %>% # drop three header rows
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"), fixed("\n"), " "),
      c("", "", "")
    ),
    value = str_trim(value)
  ) %>%
  filter(value != "") # drop empty row

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index") %>%
  add_column(batch = i, .before = "index")


### batch 6: 2019 (p>span)----


# files html path, and the year
i <- 6
(Year <- years_target[i])
(files_dir <- url_html[i])
(file_save <- str_replace(files_target[i], "html", "xlsx"))

# parse html
css_tar <- "div > p[style*='text-indent: 21pt']"
tbl_raw <- rvest::read_html(
  files_dir,
  encoding = c(
    # "bg2312",
    "UTF-8" # ,
    # "GB18030","big5"
  )
) %>%
  html_elements(css = css_tar) %>%
  html_text() %>%
  unlist() %>%
  as_tibble() %>%
  .[-c(1:8), ] %>% # drop header rows
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"), fixed("\n"), " "),
      c("", "", "")
    ),
    value = str_trim(value)
  ) %>%
  filter(value != "") # drop empty row

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index") %>%
  add_column(batch = i, .before = "index")



### batch 7: 2021 (p>span)----


# files html path, and the year
i <- 7
(Year <- years_target[i])
(files_dir <- url_html[i])
(file_save <- str_replace(files_target[i], "html", "xlsx"))

# parse html
css_tar <- "div.my-target > p"
tbl_raw <- rvest::read_html(
  files_dir,
  encoding = c(
    # "bg2312",
    "UTF-8" # ,
    # "GB18030","big5"
  )
) %>%
  html_elements(css = css_tar) %>%
  html_text() %>%
  unlist() %>%
  as_tibble() %>%
  # clean
  mutate(
    value = mgsub::mgsub(
      value,
      c(fixed("\u00a0"), fixed("\n"), " "),
      c("", "", "")
    ),
    value = str_trim(value)
  ) %>%
  filter(value != "") # drop empty row

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index") %>%
  add_column(batch = i, .before = "index")


### batch 8: 2024 (txt)----
## directory
dir_path <- here::here("topic", "public-site", "moa-firm-leader", "html")
## target html
files_html <- list.files(dir_path)
files_target <- files_html[which(str_detect(files_html, "^batch.+?\\.txt$"))]
url_html <- paste0(dir_path, "/", files_target)
years_target <- str_extract_all(files_target, "(\\d{4})") %>%
  unlist() %>%
  as.numeric(.)
## my selection
i <- 1
(Year <- years_target[i])
(files_dir <- url_html[i])
(file_save <- str_replace(files_target[i], "txt", "xlsx"))

tbl_raw <- read_lines(file = files_dir) %>%
  as_tibble()

tbl_out <- tbl_raw %>%
  rename("name" = "value") %>%
  add_column(index = 1:nrow(.), .before = "name") %>%
  add_column(year = Year, .before = "index") %>%
  add_column(batch = 8, .before = "index")

## 匹配信息----

# obtain the province info
require(techme)
data("BasicProvince")
data("ProvinceCity")
ptn_province <- paste0(BasicProvince$province, collapse = "|")
ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

tbl_info <- tbl_out %>%
  mutate(
    province_name = str_extract(name, ptn_province),
    city_clean = str_extract(name, ptn_city)
  ) %>%
  # match
  left_join(., select(ProvinceCity, city_clean, province_clean), by = "city_clean") %>%
  mutate(province = ifelse(is.na(province_name),
    province_clean,
    province_name
  )) %>%
  select(year, batch, index, name, province) %>%
  # fill province,
  # assumed the firs firm is identified exactly
  fill(province, .direction = "down")

# check
check <- sum(is.na(tbl_info$province))
if (check > 0) warning("Povince with NA, please check!")

tbl_check <- tbl_info %>%
  filter(is.na(province))

tbl_check <- tbl_info %>%
  group_by(province) %>%
  slice_head(n = 1) %>%
  ungroup() %>%
  arrange(index)


## 异常处理----


# 根据公司名称，初步判明属地应该为北京的公�?

##  year 2004, batch 3, correct the last two firms
if (i == 3) {
  tbl_info$province[c(209, 210)] <- "北京"
}

# year 2011, batch 5, correct the last two firms
if (i == 5) {
  tbl_info$province[c(358, 359)] <- "北京"
}

# year 2024, batch 8,
if (i == 8) {
  tbl_info$province[c(1)] <- "北京"
}

## 导出到xlsx/文件�?---

# files csv path
dir_path <- here::here("topic", "public-site", "moa-firm-leader")

(path_out <- paste0(dir_path, "/xlsx/", file_save))
write.xlsx(tbl_info, path_out)

## 导出为分析数�?---

dir_path <- here::here("topic", "public-site", "moa-firm-leader", "xlsx")
files_xlsx <- list.files(dir_path)

(files_target <- files_xlsx[which(str_detect(files_xlsx, "batch"))])

(url_xlsx <- paste0(dir_path, "/", files_target))

years_target <- str_extract_all(files_target, "(\\d{4})") %>%
  unlist() %>%
  as.numeric(.)

tbl_out <- NULL

i <- 1
for (i in 1:length(files_target)) {
  tbl_tem <- read.xlsx(url_xlsx[i]) %>%
    mutate(index = as.numeric(index))

  tbl_out <- bind_rows(tbl_out, tbl_tem)
}

dir_path <- here::here("topic", "public-site", "moa-firm-leader")

(path_out <- paste0(dir_path, "/data-update/batch-upto-year-", max(years_target), ".xlsx"))

write.xlsx(tbl_out, path_out)
