## code to prepare `hack_Province_city` dataset goes here

require("jsonlite")
require("tidyjson")
require("tidyverse")

# you should use json object file!!
url_city <-  "https://raw.githubusercontent.com/wecatch/china_regions/master/json/city_object.json"

city <- fromJSON(url_city,simplifyVector = F)

ptn <- c("维吾尔","回族","壮族","自治区","省","市")
rpl <- rep("", length(ptn))


dt_city <-   tidyjson::spread_all(city) %>%
  as_tibble() %>%
  rename(city = "name",
         index = "document.id") %>%
  mutate(province_clean = mgsub::mgsub(province, ptn, rpl) ) %>%
  mutate(city_clean = str_extract(city, "(.*)(?=市)")) %>%
  mutate(city_clean = ifelse(is.na(city_clean)|city_clean=="",
                             "未列出",
                             city_clean))



ProvinceCity <- dt_city

usethis::use_data(ProvinceCity, overwrite = TRUE)
