## code to prepare `hack_tianyan` dataset goes here
source("data-raw/set-global.R")
require(devtools)
load_all()

# ===== your list =======
## it should  be unique and exclusive from 'queryTianyan'
## and xlsx file in directory 'ship/xx.xlsx'

url_xlsx <- "data-raw/data-tidy/hack-tianyan/ship/ship-tot7-2022-08-17.xlsx"
list_ins <- openxlsx::read.xlsx(url_xlsx) %>%
  unlist() %>%
  unname()


# ===== docker & Rselenium set =====
##  load R pkgs
library("RSelenium")
library("xml2")
require("rvest")
require("stringr")
require("tidyverse")
require("tidyselect")


#-------part 01 start docker + RSelenium-------
# 1. run docker service and container
#### you should run and start docker desktop first.
#### then run code in 'window power shell':
#### docker run --name chrome -v /dev/shm:/dev/shm -d -p 4445:4444 -p 5901:5900 selenium/standalone-chrome-debug:latest

# 2. create the remote driver
### 'window power shell': ipconfig
remDr <- remoteDriver(remoteServerAddr = "10.129.158.130",
                      port = 4445L, browserName = "chrome")

# local without docker
driver <- rsDriver(browser=c("firefox"),
                   port = 4567L)
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
i <-9

for (i in 1:length(list_ins)) {
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
  xpath_search <- "*//div[contains(@class,'home-suggest-input')]//input"
  remDr$findElement("xpath", xpath_search)$sendKeysToElement(
    list(list_ins[i]))

  # submit search
  xpath_submit <- "*//button[contains(@class,'home-suggest-button')]//span"
  remDr$findElement(using = "xpath", value = xpath_submit)$clickElement()
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
    xpath_p0 <- "//div[contains(@class, 'index_search-item-center') ]"

    # div header
    xpath_p1 <- "/div[contains(@class, 'index_header')]/div[contains(@class,'index_name')]"
    xpath_p2 <- "//a[contains(@class, 'index_alink') ]"
    xpath_p3 <- "//span"

    xpath_sel <- paste0(xpath_p0, xpath_p1,
                        xpath_p2) # href
    isExist <- as.logical(length(remDr$findElement("xpath",xpath_sel)))
    if (!isExist) stop("xpath 'address' failed, please check!")
    url[i] <- remDr$findElement("xpath",
                                xpath_sel)$getElementAttribute("href") %>%
      unlist()
    print("here: 3-1 url ")

    # get the searched name
    xpath_sel <- paste0(xpath_p0,xpath_p1,
                        xpath_p2, xpath_p3) # name

    isExist <- as.logical(length(remDr$findElement("xpath",xpath_sel)))
    if (!isExist) stop("xpath 'address' failed, please check!")
    name[i] <- remDr$findElement("xpath",
                                 xpath_sel)$getElementText() %>%
      unlist() %>%
      paste0(., collapse = "")

    print("here: 3-2 name ")

    # get the address
    ## div contact col
    xpath_p41 <- "//div[contains(@class, 'index_contact-row')]//div[contains(@class, 'index_contact-col') ]"
    xpath_p42 <- "/span[text() = '地址：']/following-sibling::span[1]"

    xpath_sel <- paste0(xpath_p0, xpath_p41, xpath_p42)

    isExist <- as.logical(length(remDr$findElement("xpath",xpath_sel)))
    if (!isExist) stop("xpath 'address' failed, please check!")

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
dt_city <- ProvinceCity %>%
  select(city_clean, province_clean)

ptn_city<- paste0(unique(ProvinceCity$city_clean), collapse = "|")
ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse = "|")

tbl_province <- tbl_out %>%
  # get obvious province
  mutate(province = str_extract(address, ptn_province)) %>%
  # get obvinous city
  mutate(city_origin = str_extract(name_origin, ptn_city)) %>%
  # match city database
  mutate(city_clean = str_extract(address, ptn_city)) %>%
  mutate(city_clean = ifelse(is.na(city_clean),
                             city_origin, city_clean)) %>%
  left_join(., dt_city, by = "city_clean") %>%
  mutate(province = ifelse(is.na(province),
                           province_clean,
                           province)) %>%
  select(-city_origin)
# only for check
## edited if needed
check <- sum(is.na(tbl_province$province))
if(check > 0) stop("please check the name of institution!")

# =====write out xlsx======
dir_xlsx <- "data-raw/data-tidy/hack-tianyan/hub/"
path_xlsx <- paste0(dir_xlsx,
                    glue::glue("match-tianyan-tot{nrow(tbl_province)}-{Sys.Date()}.xlsx"))

openxlsx::write.xlsx(tbl_province, path_xlsx)


# check and edited by hand

id_notEqual<- which(tbl_province$name_search!= tbl_province$name_origin)
tbl_province %>%
  select(name_origin, name_search, province) %>%
  .[id_notEqual,]

# ===== combine all query =====

dir_xlsx <- "data-raw/data-tidy/hack-tianyan/hub/"
files_xlsx <- list.files(dir_xlsx)
url_xlsx <- paste0(dir_xlsx, files_xlsx)

dt_hub<- tibble(files = url_xlsx ) %>%
  mutate(tbl = map(.x = files,
                   .f = openxlsx::read.xlsx)) %>%
  select(-files) %>%
  unnest(tbl) %>%
  select(-city_clean, -province_clean)

#unique(dt_hub$province)
check <- dt_hub %>%
  janitor::get_dupes(name_origin)

if (nrow(check) >0) warning( "there exist duplicate name_origin")

queryTianyan <- dt_hub

usethis::use_data(queryTianyan, overwrite = TRUE)
