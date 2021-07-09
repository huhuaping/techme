## code to prepare `unpivot_xls` dataset goes here
require(unpivotr)
library(XLConnect)
library(tidyverse)
library(readxl)

path_xls <- "data-raw/MyFile.xls"
wb <- loadWorkbook(path_xls, create = TRUE)
# get the numbers of sheets. It should minus one to drop the last sheet contains only copyright informal .
sheetnum <- length(getSheets(wb))-1

#i <- 1
df_out <- NULL
for (i in 1: sheetnum){
  dt <- readWorksheet(wb, sheet = i,header = F)
  pivot_range <- getRange(dt)
  len <- nrow(pivot_range)
  #j <-1
  for (j in 1:len){
    pivot_rows <- pivot_range$start[j]:pivot_range$end[j]
    df_tem <- unpivot(dt, rows = pivot_rows)
    df_out <- bind_rows(df_out, df_tem)
  } # end loop j
} # end loop i

#------function to get range of pivot table----
getRange <- function(dt, reg_start="^地.*区", reg_end ="^新.*疆"){
  pivot_start <- which(str_detect(dt$Col1, reg_start))
  pivot_end <- which(str_detect(dt$Col1, reg_end ))

  # check length
  if (length(pivot_start)!=length(pivot_end)) stop("起止行长度不同。请检查识别字符是否正确！")
  if (all(pivot_start > pivot_end)) stop("start rows large then end rows. please check the identifier of rows!")

  pivot_range <- tibble(start = pivot_start,
                      end = pivot_end)
  return(pivot_range)
}


# ------function to unpivot table-----

unpivot <- function(dt, rows){
  dt_cell <- dt[rows,]  %>%
    as_cells() %>%
    arrange( col,row ) %>%
    behead("up-left", variables) %>%
    behead("up", year) %>%
    behead("left", province) %>%
    rename(value = chr) %>%
    select(-data_type, -row, -col)

  dt_tidy <- dt_cell %>%
    mutate(value = as.numeric(value),
           year = str_extract(year, "\\d{4}"),
           province = str_replace(province," ", "")) %>%
    separate(variables, into = c("variables", "unit"), sep = "\\(") %>%
    mutate(unit = str_extract(unit, "(.+)(?=\\))")) %>%
    select(province, year, variables, value, unit)
  return(dt_tidy)
}


#usethis::use_data(unpivot_xls, overwrite = TRUE)
