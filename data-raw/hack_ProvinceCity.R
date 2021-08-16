## code to prepare `hack_Province_city` dataset goes here

require("jsonlite")
require("tidyjson")
require("tidyverse")

# you should use json object file!!
url_city <-  "https://raw.githubusercontent.com/wecatch/china_regions/master/json/city_object.json"

city <- fromJSON(url_city,simplifyVector = F)


dt_city <-   tidyjson::spread_all(city) %>%
  as_tibble() %>%
  rename(city = "name",
         index = "document.id")


ProvinceCity <- dt_city

usethis::use_data(ProvinceCity, overwrite = TRUE)
