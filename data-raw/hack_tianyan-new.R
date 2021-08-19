## code to prepare `hack_tianyan` dataset goes here
source("data-raw/set-global.R")

# ===== your list =======
## it should  be unique and exclusive from 'queryTianyan'
## and xlsx file in directory 'ship/xx.xlsx'

url_xlsx <- "data-raw/data-tidy/hack-tianyan/ship/ship-tot286-2021-08-19.xlsx"
list_ins <- openxlsx::read.xlsx(url_xlsx) %>%
  unlist() %>%
  unname()


# ===== Rselenium set =====
##  load R pkgs
library("RSelenium")
library("xml2")
require("rvest")
require("stringr")
require("tidyverse")
require("tidyselect")

driver <- rsDriver(browser=c("firefox"), port = 4446L)
remDr <- driver[["client"]]
## open the connect
remDr$open()

# ===== loop to query ====

url <- NULL
name <- NULL
tel <- NULL
address <- NULL

url_list <- "https://www.tianyancha.com/"

# helper function to switch explorer window
myswitch <- function (remDr, windowId) {
  qpath <- sprintf("%s/session/%s/window", remDr$serverURL,
                   remDr$sessionInfo[["id"]])
  remDr$queryRD(qpath, "POST", qdata = list(handle = windowId))
}

# loop to scrape info
i <- 95

for (i in 237:length(list_ins)) {
  # navigate the url
  if (i==1) {
    remDr$navigate(url_list)
    Sys.sleep(1)
    # full window
    remDr$maxWindowSize(winHand = "current")
    Sys.sleep(0.5)
    print("here: 1 nav")
  }

  # send key to search input
  xpath_search <- "//*[@id='home-main-search']"
  remDr$findElement("xpath", xpath_search)$sendKeysToElement(
    list(list_ins[i]))

  # submit search
  css_submit <-"#web-content > div > div.tyc-home-top.bgtyc > div.container > div > div > div.tab-main > div:nth-child(2) > div.input-group.home-group > div"
  remDr$findElement(using = "css", value = css_submit)$clickElement()
  print("here: 2 submit")
  # wait seconds
  Sys.sleep(1)

  # check the search result is not empty!
  xpath_sel <- "//div[contains(@class, 'no-result-title')]"
  #xpath_sel <- "/html/body/div[2]/div[2]/div[1]/div[2]/div[1]/div[2]/div/div[1]/div[1]"
  #length(remDr$findElement("xpath",xpath_sel))
  ## helper function to tryCatch
  try_xpath <- function(xpath){remDr$findElement("xpath",xpath)}
  an.error.occured <- TRUE
  tryCatch( { result <- try_xpath(xpath_sel)},
            error = function(e) {an.error.occured <<- FALSE})
  print(glue::glue("没有找到相关企业{i} is {an.error.occured}：{list_ins[i]}"))


  if (an.error.occured) {
    name[i] <- list_ins[i]
    url[i] <- ""
    address[i] <- ""
    tel[i] <- ""
  } else {
    # get the href
    xpath_p1 <- "//div[contains(@class, 'result-list') ]/div[1]/div[1]//div[contains(@class,'content')]"

    xpath_p2 <- "//a[contains(@class, 'name') ]"
    xpath_sel <- paste0(xpath_p1, xpath_p2)
    isExist <- as.logical(length(remDr$findElement("xpath",xpath_sel)))
    if (!isExist) stop("xpath 'address' failed, please check!")
    url[i] <- remDr$findElement("xpath",
                                xpath_sel)$getElementAttribute("href") %>%
      unlist()
    print("here: 3-1 url ")

    # get the searched name
    xpath_p2 <- "//div[contains(@class, 'header') ]//a[contains(@class, 'name') ]"
    xpath_sel <- paste0(xpath_p1, xpath_p2)

    isExist <- as.logical(length(remDr$findElement("xpath",xpath_sel)))
    if (!isExist) stop("xpath 'address' failed, please check!")
    name[i] <- remDr$findElement("xpath",
                                 xpath_sel)$getElementText() %>%
      unlist() %>%
      paste0(., collapse = "")

    print("here: 3-2 name ")

    # get the address
    xpath_p2 <- "//span[contains(@class, 'label') and text() = '地址：']/following-sibling::span[1]"
    xpath_sel <- paste0(xpath_p1, xpath_p2)

    an.error.occured <- FALSE
    tryCatch( { result <- try_xpath(xpath_sel)},
              error = function(e) {an.error.occured <<- TRUE})
    print(glue::glue("暂无地址：{an.error.occured}"))

    if (!an.error.occured) {
      address[i] <- remDr$findElement("xpath",
                                      xpath_sel)$getElementText() %>%
        unlist()
    } else {
      address[i] <- "暂无信息"
    }

    print("here: 3-3 address ")

    tel[i] <- "暂无信息"
  }

  # close the opened new tab
  #remDr$closeWindow()

  # switch to the main tab
  #myswitch(remDr, windows_handles[[1]])

  print(paste0(i, list_ins[i],"finished"))

  #windHand <- remDr$getCurrentWindowHandle()
  #remDr$open()
  #remDr$switchToWindow(windHand[[1]])
  remDr$goBack()

}

# ===== get out table ====
tbl_out <- tibble( index = 1:length(list_ins),
                   name_origin = list_ins,
                   name_search = name,
                   address = address,
                   tel = tel,
                   url=url)

# stop Rselenium and free ports
remDr$close()
rm(driver)
gc()
## kill the Java instance(s) inside RStudio
### see [url](https://github.com/ropensci/RSelenium/issues/228#issuecomment-632885370)
system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE)
pingr::ping_port("localhost", 4446)



# ==== match `ProvinceCity` again =====

# exclude rows exist in data base of `ProvinceCity`
data("ProvinceCity")
dt_city <- ProvinceCity

index_city <- which(str_detect(unique(dt_city$city),"市"))
list_city <- unique(dt_city$city)[index_city]
ptn_city<- paste0(list_city, collapse = "|")

list_province <- unique(dt_city$province) %>%
  str_replace(., c("回族自治区|维吾尔自治区|壮族自治区|自治区|省|市"), "")
ptn_province <- paste0(list_province, collapse = "|")

tbl_province <- tbl_out %>%
  mutate(city = str_extract(address, ptn_city),
         province_raw = str_extract(address, ptn_province)) %>%
  # match city database
  left_join(., select(dt_city, province, city), by = "city") %>%
  mutate(province = ifelse(is.na(province),
                           province_raw,
                           province)) %>%
  # simplify the name of province
  mutate(province = str_replace(province,
                                c("自治区|省|市"),
                                ""))


# =====write out xlsx======
dir_xlsx <- "data-raw/data-tidy/hack-tianyan/hub/"
path_xlsx <- paste0(dir_xlsx,
                    glue::glue("match-tianyan-tot{nrow(tbl_province)}-{Sys.Date()}.xlsx"))

openxlsx::write.xlsx(tbl_province, path_xlsx)

# =====check query=====
tbl_province <- openxlsx::read.xlsx("data-raw/data-tidy/hack-tianyan/hub/match-tianyan-tot286-2021-08-19.xlsx")
tbl_check <- tbl_province %>%
  select(index, name_origin, name_search) %>%
  mutate(check = as.logical(name_origin==name_search)) %>%
  filter(check==FALSE)

id_false <- which(tbl_check$check==FALSE)
tbl_check$index[id_false]

## just for check
sum(is.na(tbl_province$province))
tbl_province %>%
  select(index, province) %>%
  filter(is.na(province))
## edit by hand if needed


# ===== combine all query =====

dir_xlsx <- "data-raw/data-tidy/hack-tianyan/hub/"
files_xlsx <- list.files(dir_xlsx)
url_xlsx <- paste0(dir_xlsx, files_xlsx)

dt_hub<- tibble(files = url_xlsx ) %>%
  mutate(tbl = map(.x = files,
                   .f = openxlsx::read.xlsx)) %>%
  select(-files) %>%
  unnest(tbl)


queryTianyan <- dt_hub

usethis::use_data(queryTianyan, overwrite = TRUE)
