## code to prepare `hack_Province_city` dataset goes here

require("jsonlite")
require("tidyjson")
source("data-raw/deps/load-core.R")
require(httr2)
library(here)

# you should use json object file!!
url_city <-  "https://raw.githubusercontent.com/wecatch/china_regions/master/json/city_object.json"
path_to <- here("data-raw/xlsx/province-city.json")
#download.file(url = url_city, destfile = path_to)
city <- fromJSON(path_to,simplifyVector = F)

# 省份regex模式
ptn <- c("维吾�?,"回族","壮族","自治�?,"�?,"�?)
rpl <- rep("", length(ptn))
# 地市regrex模式
path_from <- here("data-raw/xlsx/chinese-minorities.txt")
tbl_minorities <- read_lines(path_from) %>%
  as_tibble() %>%
  rename(race="value")
ptn_city <- tbl_minorities$race
rpl_city <- rep("", length(ptn_city))

dt_city <-   tidyjson::spread_all(city) %>%
  as_tibble() %>%
  rename(city = "name",
         index = "document.id") %>%
  mutate(province_clean = mgsub::mgsub(province, ptn, rpl) ) %>%
  mutate(city_clean = str_extract(city, "(.*)(?=市|自治州|地区|�?")) %>%
  mutate(city_clean = ifelse(is.na(city_clean)|city_clean=="",
                             "uncheck",
                             city_clean)) %>%
  # 去掉少数名族
  mutate(
    city_clean = mgsub::mgsub(city_clean, ptn_city, rpl_city)
  ) %>%
  # 去掉少数名族，不含“族”字
  mutate(
    city_clean = mgsub::mgsub(
      city_clean,
      c("蒙古", "哈萨�?),
      rep("", 2)
      )
  )
  # handle 'non-ASCII characters' warning
  #mutate(city_clean = iconv(city_clean, from="UTF-8", to="UTF-8"))

tbl_check <- dt_city %>%
  filter(city_clean =="uncheck")

#unique(dt_city$province_clean)

ProvinceCity <- dt_city

usethis::use_data(ProvinceCity, overwrite = TRUE)
