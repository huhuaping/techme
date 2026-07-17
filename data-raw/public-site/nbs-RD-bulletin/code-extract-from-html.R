## =====load pkgs=====
library("xml2")
source("data-raw/deps/load-core.R")
source("data-raw/deps/load-scrape.R")
library(here)
library(openxlsx)
library(fs)

## ====files html path====
dir_media <- "data-raw/data-tidy/public-site/nbs-RD-bulletin/"
dir_final <- "01-html"
files_dir <- paste0(dir_media, dir_final)
files_html <- list.files((files_dir))
page_url <- str_c(files_dir, files_html, sep = "/")

## ====specify the year====
year <- 2023
indx <- str_detect(files_html, paste0(year))
page <- page_url[indx]
i_len <- length(page)

i <- 1
## ==== obtain raw table====
xpath_tbl <- "//div/table"
# the html source file declares gb2312
tbl_raw <- read_html(x = page[i], encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tbl) %>%
  html_table(., fill = T, trim = T, header = T) %>%
  .[[3]] %>%
  as_tibble()

## ==== tidy table ====
list_chn <- c("地区", "RD经费", "RD强度")
tbl_tidy <- tbl_raw %>%
  rename_all(., ~list_chn) %>%
  # .[row_range,] %>%
  # double-byte space (Unicode \u3000)
  mutate(`地区` = gsub("\u3000", "", `地区`, perl = T)) %>%
  type_convert(cols(
    `地区` = col_character(),
    `RD经费` = col_double(),
    `RD强度` = col_double()
  )) %>%
  rename_all(., ~ all_of(list_chn)) %>%
  # add_column("年份"=year, .before = "省份") %>%
  filter(!is.na(`地区`))

## ==== write out the xlsx files====

# files path
dir_tar <- "02-xls/"
dir_files <- paste0(dir_media, dir_tar)
name_files <- paste0("raw-", year, ".xlsx")
path_files <- paste0(dir_files, name_files)

write.xlsx(tbl_tidy, here(path_files))


## 拷贝xlsx到包`techme`----

dir_from <- here("topic/public-site/nbs-RD-bulletin/")
dir_to <- "D:/github/techme/data-raw/public-site/nbs-RD-bulletin/"

### 第一次拷�?---
### 需要拷贝整个文件夹
isFirst <- FALSE
if (isFirst) {
  fs::dir_create(path = dir_to)
  fs::dir_copy(
    path = paste0(dir_from, "/02-xls"),
    new_path = paste0(dir_to, "02-xls"), # 不需要斜�?
    overwrite = TRUE
  )
}
### 后续更新拷贝----
### 只需要拷贝特定xlsx文件
fs::file_copy(
  path = here(path_files),
  new_path = paste0(dir_to, "02-xls/", name_files), # 不需要斜�?
  overwrite = TRUE
)
