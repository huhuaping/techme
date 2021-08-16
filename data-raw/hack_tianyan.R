## code to prepare `hack_tianyan` dataset goes here
require(purrr)
require("tidyverse")

#===== read existed xlsx files =====
## in `hub` dir

dir_xlsx <- "data-raw/data-tidy/hack-tianyan/hub/"
files_xlsx <- list.files(dir_xlsx)
url_xlsx <- paste0(dir_xlsx, files_xlsx)

dt_hub<- tibble(files = url_xlsx ) %>%
  mutate(tbl = map(.x = files,
                  .f = openxlsx::read.xlsx)) %>%
  select(-files) %>%
  unnest(tbl)

# ==== unique institution needed to query ====
## (or xlsx file in `ship` dir)

#require(techme)
data(PubNKRDP)

tbl_inst <- PubNKRDP #%>%
  #filter(NO_mark == "YFD")

# clean and check data
index_dup <- which(duplicated(tbl_inst$NO))
tbl_uniqueNO <- tbl_inst %>%
  #janitor::get_dupes(NO) %>%
  #arrange(NO)
  .[-index_dup, ]

tbl_uniqueInst <- tbl_uniqueNO %>%
  select(institution) %>%
  arrange(institution) %>%
  .[-which(duplicated(.$institution)),]  %>% # fileter duplicated rows
  add_column(index = 1:nrow(.), .before = "institution")


#======match data base of `ProvinceCity` =====
# exclude rows exist in data base of `ProvinceCity`
data("ProvinceCity")
dt_city <- ProvinceCity

index_city <- which(str_detect(unique(dt_city$city),"市"))
list_city <- unique(dt_city$city)[index_city]
ptn_city<- paste0(list_city, collapse = "|")

list_province <- unique(dt_city$province) %>%
  str_replace(., c("回族自治区|维吾尔自治区|壮族自治区|自治区|省|市"), "")
ptn_province <- paste0(list_province, collapse = "|")


tbl_uniqueInst_exclude <- tbl_uniqueInst %>%
  mutate(city = str_extract(institution, ptn_city),
         province_raw = str_extract(institution, ptn_province)) %>%
  # match city database
  left_join(., select(dt_city, province, city), by = "city") %>%
  mutate(province = ifelse(is.na(province),
                           province_raw,
                           province)) %>%
  # simplify the name of province
  mutate(province = str_replace(province,
                                c("自治区|省|市"),
                                "")) %>%

  filter(is.na(province))

# match to remove exist institution in hub
tbl_newInst <- tbl_uniqueInst_exclude %>%
  select(institution ) %>%
  rename(name_origin = "institution") %>%
  left_join(., select(dt_hub,name_origin, province ),
            by = "name_origin") %>%
  filter(is.na(province))

# get the unique institution name
list_ins <-  tbl_newInst %>%
  rename(institution = "name_origin") %>%
  .[,"institution"] %>%
  unique(.) %>%
  #head() %>%
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
i <- 1
for (i in 1:length(list_ins)) {
  # navigate the url
  remDr$navigate(url_list)
  Sys.sleep(1)
  # full window
  remDr$maxWindowSize(winHand = "current")
  Sys.sleep(0.5)
  print("here: 1 nav")

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

  # get the url ('href') and name
  ## css selector may change
  css_opt <- list("#search_company_0 > div:nth-child(1) > div:nth-child(4) > div:nth-child(1) > a:nth-child(1)",
                  "#search_company_0 > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > a:nth-child(1)")

  choice <- sapply(css_opt, function(X){
    length(remDr$findElements(using='css', X))
  })

  if (sum(choice)==1) {
    css_sel <- unlist(css_opt[which(as.logical(choice))])
    url[i] <- remDr$findElement("css",
                                css_sel)$getElementAttribute("href") %>%
      unlist()
    # get the institution name
    name[i] <- remDr$findElement("css",
                                 css_sel)$getElementText() %>%
      unlist()
  } else {
    stop("CSS selector failed, please check!")
  }

  # click to open new page
  remDr$findElement(using = "css", value = css_sel)$clickElement()
  Sys.sleep(1)
  print("here: 3 newpage")

  # get all tab Handles
  windows_handles <- remDr$getWindowHandles()
  # switch tab
  myswitch(remDr, windows_handles[[2]])

  # scraping tel
  ## css selector may change
  css_opt <- list("div.f0:nth-child(1) > div:nth-child(1) > span:nth-child(4)",
                  "span.link-hover-click")
  choice <- sapply(css_opt, function(X){
    length(remDr$findElements(using='css', X))
  })

  if (sum(choice)==1) {
    css_sel <- unlist(css_opt[which(as.logical(choice))])
    tel[i] <- remDr$findElement("css",
                                css_sel)$getElementText() %>%
      unlist()
  } else stop("CSS selector failed, please check!")

  # extract address
  ## selector may change
  css_opt <- list("div.ac:nth-child(3) > div:nth-child(1)",
                  ".address")
  choice <- sapply(css_opt, function(X){
    length(remDr$findElements(using='css', X))
  })

  if (sum(choice)==1) {
    css_sel <- unlist(css_opt[which(as.logical(choice))])
    address[i] <- remDr$findElement("css", css_sel)$getElementText() %>%
      unlist()
  } else if (sum(choice)==2) {
    css_sel <- unlist(css_opt)[1]
    address[i] <- remDr$findElement("css", css_sel)$getElementText() %>%
      unlist()
  } else{
    stop("CSS selector (address) failed, please check!")
  }

  # close the opened new tab
  remDr$closeWindow()

  # switch to the main tab
  myswitch(remDr, windows_handles[[1]])

  print(paste0(i, list_ins[i]))

  #windHand <- remDr$getCurrentWindowHandle()
  #remDr$open()
  #remDr$switchToWindow(windHand[[1]])
  #remDr$goBack()

}

# ===== get out table ====
tbl_out <- tibble( index = 1:length(list_ins),
                   name_origin = list_ins,
                   name_search = name,
                   address = address,
                   tel = tel,
                   url=url)

# ==== match `ProvinceCity` again =====

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
path_xlsx <- paste0(dir_xlsx,
                    glue::glue("match-tianyan-tot{nrow(tbl_out)}-{Sys.Date()}.xlsx"))

openxlsx::write.xlsx(tbl_province, path_xlsx)


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
