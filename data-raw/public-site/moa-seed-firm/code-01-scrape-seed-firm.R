## R包准�?---
require(openxlsx)
source("data-raw/deps/load-core.R")
source("data-raw/deps/load-scrape.R")
require("here")
library("RSelenium")
library(jsonlite)
library(glue)



## 启动Rselenum----

# part 01 start docker + RSelenium
# 1. run docker service and container
#### you should run and start docker desktop first.
#### then run code in 'window power shell': docker run --name chrome -v /dev/shm:/dev/shm -d -p 4445:4444 -p 5901:5900 selenium/standalone-chrome-debug:latest

### for firefox: docker run --name firefox -v /dev/shm:/dev/shm -d -p 4445:4444 -p 5901:5900 selenium/standalone-firefox-debug:latest

# 2. create the remote driver
### 'window power shell': ipconfig
### home  ip  : 192.168.1.154
### office ip : 192.168.32.108

#### for chrome
# remDr <- remoteDriver(remoteServerAddr = "10.129.244.205", port = 4445L, browserName = "chrome")

#### for firefox
# remDr <- remoteDriver(remoteServerAddr = "192.168.32.108", port = 4445L, browserName = "firefox")

#
remDr <- RSelenium::remoteDriver(
  remoteServerAddr = "localhost",
  port = 5555L,
  browserName = "chrome"
)
remDr$open()

# driver <- rsDriver(browser=c("firefox"), port = 4445L)

# remDr <- driver[["client"]]

remDr$maxWindowSize()

# quit and release process
remDr$closeServer()
remDr$close()
rm(remDr)
rm(driver)
gc()


## 获得API参数----

# navigate to your page
url_tar <- "http://202.127.42.47:6010/XKSite/Home/Index?str="
remDr$navigate(url_tar)

### 辅助函数----
## obtain label and id
extract_inf <- function(remDr, css) {
  elems <- remDr$findElements(using = "css", value = css)
  elems <- elems[-1] # drop the first option
  n <- length(elems)
  # get label and id
  label <- unlist(
    lapply(elems, function(x) x$getElementText())
  )
  id <- unlist(
    lapply(elems, function(x) x$getElementAttribute("value"))
  )
  out <- tibble(n = n, label = label, id = id)
  return(out)
}

## obtain option elements
extract_elems <- function(remDr, css) {
  elems <- remDr$findElements(using = "css", value = css)
  elems <- unlist(elems[-1]) # drop the first option
  return(elems)
}

# province options
css_tar <- "#qyProvince > option"
elems_province <- extract_elems(remDr, css_tar)
tbl_province <- extract_inf(remDr, css_tar) %>%
  # the first row is the nation
  mutate(index_self = 1:nrow(.))


## loop province and city options,
## and extract the city information and
## the town information respectably

i <- 2
tbl_city_out <- NULL
tbl_town_out <- NULL
for (i in 6:length(elems_province)) { # start from province
  # choose and click province
  ele <- elems_province[[i]]
  ele$clickElement()
  Sys.sleep(0.5)
  # obtain city info
  css_tar <- "#qyCity > option"
  elems_city <- extract_elems(remDr, css_tar)
  Sys.sleep(0.5)
  tbl_city <- extract_inf(remDr, css_tar) %>%
    mutate(
      index = i,
      index_up = i,
      index_self = 1:nrow(.),
      type = "city"
    )
  Sys.sleep(0.5)

  j <- 1
  for (j in 1:length(elems_city)) {
    # choose and click city
    ele <- elems_city[[j]]
    ele$clickElement()
    Sys.sleep(0.5)
    # obtain town info
    css_tar <- "#qyTown > option"
    elems_town <- extract_elems(remDr, css_tar)
    Sys.sleep(0.5)
    tbl_town <- extract_inf(remDr, css_tar) %>%
      mutate(
        index = i,
        index_up = j,
        index_self = 1:nrow(.),
        type = "town"
      )
    Sys.sleep(0.5)

    tbl_town_out <- bind_rows(tbl_town_out, tbl_town)
    print(paste0("finish city: ", j))
  }

  tbl_city_out <- bind_rows(tbl_city_out, tbl_city)
  print(paste0("finish province: ", i))
}

## now combine three tables

tbl_all <- bind_rows(
  tbl_province %>% mutate(
    type = "province",
    index_up = index_self,
    index = index_self
  ) %>%
    select(n, label, id, index, index_up, index_self, type),
  tbl_city_out,
  tbl_town_out
) %>%
  arrange(id)

### 导出到xlsx----
Year <- 2025
(path_out <- glue::glue("data-raw/public-site/moa-seed-firm/data/table-parameters-id-{Year}.xlsx"))
write.xlsx(tbl_all, here::here(path_out))


## 正式爬取json----
# 天津�?6条记录：http://202.127.42.47:6010/XKSite/Home/GetLicenseList?LicenceNoLike=&ApplyCompanyNameLike=&ProductionManageCrops=&IssuingAuthorityRegionID=120000&PublishDateStart=&PublishDateEnd=&VarietyName=&_search=false&rows=20&page=1&sidx=&sord=desc&InitialPublishDateStart=&InitialPublishDateEnd=&isValid=
# 天津市市辖区，没有数据：http://202.127.42.47:6010/XKSite/Home/GetLicenseList?LicenceNoLike=&ApplyCompanyNameLike=&ProductionManageCrops=&IssuingAuthorityRegionID=120100&PublishDateStart=&PublishDateEnd=&VarietyName=&_search=false&rows=20&page=1&sidx=&sord=desc&InitialPublishDateStart=&InitialPublishDateEnd=&isValid=
# 获取数据集基本信息（行数rows）：`rows=0`表示没有数据�?
# "152201" 乌兰浩特�?

### 辅助函数----
## get the datasets
get_dataset <- function(url) {
  # parse html and convert to json
  docs <- url %>%
    httr::GET(., httr::timeout(60)) %>%
    read_html() %>%
    html_text()
  ## wait seconds
  # Sys.sleep(0.1)
  ## to json
  tbl_tem <- jsonlite::fromJSON(docs)
  n_total <- as.numeric(tbl_tem$records)
  if (n_total > 0) {
    tbl_out <- tbl_tem$rows %>%
      as_tibble()
  } else {
    tbl_out <- NULL
  }
  return(tbl_out)
}


### 构造查询参�?---
url_part1 <- "http://202.127.42.47:6010/XKSite/Home/GetLicenseList?LicenceNoLike=&ApplyCompanyNameLike=&ProductionManageCrops=&IssuingAuthorityRegionID="
# query 2000 rows
url_part2 <- "&PublishDateStart=&PublishDateEnd=&VarietyName=&_search=false&rows=2000&page=1&sidx=&sord=desc&InitialPublishDateStart=&InitialPublishDateEnd=&isValid="

### 读取基本信息----
path_out <- here(glue("proj/moa-seed-firm/data/table-parameters-id-{Year}.xlsx"))
tbl_pars <- read.xlsx(path_out) %>%
  mutate(
    url = str_c(url_part1, id, url_part2),
    order = 1:nrow(.)
  )

### 循环爬取json ----
k <- nrow(tbl_pars)
tbl_json <- NULL
i <- 1
for (i in 1:k) {
  tbl_tem <- tbl_pars[i, ] %>%
    mutate(dt = map(url, get_dataset))
  # show process
  info <- tbl_tem %>%
    unite("info", c(order, id, label), sep = ";") %>%
    pull("info")
  print(info)
  # bind data
  tbl_json <- bind_rows(tbl_json, tbl_tem)
}

# for check
tbl_check <- tbl_json %>%
  unnest(dt)


### 导出到xlsx/文件�?---
(path_out <- here(glue("data-raw/public-site/moa-seed-firm/data/table-json-{Year}.rds"))) # change here
saveRDS(tbl_json, path_out)


### 拷贝到报告文件夹�?---
# 爬取好后，将数据集拷贝到《旱区技术发展报告》Rstudio项目的文件夹目录�?D:/github/tech-report/data-raw/public-site/moa-seed-firm/xlsx/tbl-json-2023.rds"

# (path_from <- path_out)
# (path_to <- glue("D:/github/tech-report/data-raw/public-site/moa-seed-firm/xlsx/tbl-json-{Year}.rds"))
# (path_to <- glue("D:/github/report-tech/topic/public-site/moa-seed-firm/xlsx/tbl-json-{Year}.rds"))

# file.copy(from = path_from, to = path_to)
