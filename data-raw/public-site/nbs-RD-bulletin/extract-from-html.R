#=====load pkgs=====
library("xml2")
require("rvest")
require("stringr")
require("tidyverse")
require("tidyselect")

# ====files html path====
dir_media <- "data-raw/public-site/nbs-RD-bulletin/"
dir_final <- "01-html/"
files_dir <- paste0(dir_media, dir_final)
files_html <- list.files(files_dir)
page_url <- str_c(files_dir, files_html, sep = "/")

# ====specify the year====
year<- 2018
indx<- str_detect(files_html,paste0(year))
page<- page_url[indx]
i_len <- length(page)

i<-1
#==== obtain raw table====
xpath_tbl <- "//div/table"
# the html source file declares gb2312
tbl_raw <- read_html(x = page[i],encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tbl) %>%
  html_table(., fill=T, trim=T,header = T) %>%
  .[[4]] %>%
  as_tibble()

#==== tidy table ====
list_chn <- c("地区", "RD经费", "RD强度")
tbl_tidy <- tbl_raw %>%
  rename_all(., ~list_chn) %>%
  #.[row_range,] %>%
  # double-byte space (Unicode \u3000)
  mutate(`地区` = gsub("\u3000", "", `地区` , perl = T))  %>%
  type_convert(cols(`地区` = col_character(),
                    `RD经费`  = col_double(),
                    `RD强度`  = col_double())) %>%
  rename_all(., ~all_of(list_chn)) %>%
  #add_column("年份"=year, .before = "省份") %>%
  filter(!is.na(`地区`))

# ==== write out the xlsx files====

# files path
dir_tar <- "02-xls/"
dir_files <- paste0(dir_media, dir_tar)
name_files <- paste0("raw-",year,".xlsx")
path_files <- paste0(dir_files, name_files)

write.xlsx(tbl_tidy, path_files)


