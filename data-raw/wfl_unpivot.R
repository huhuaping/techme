## code to prepare `wfl_unpivot` dataset goes here

require(unpivotr)
library(XLConnect)
library(tidyverse)
library(readxl)
library(glue)

#------Helper function to get range of pivot table----
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

## example

wb <- loadWorkbook(path_xls, create = TRUE)
dt <- readWorksheet(wb, sheet = 1,header = F)
pivot_range <- getRange(dt)
len <- nrow(pivot_range)


# ------function to unpivot table-----

unpivot <- function(dt, rows){
  dt_cell <- dt[rows,]  %>%
    as_cells() %>%
    arrange( col,row ) %>%
    behead("up-left", vars) %>%
    behead("up", year) %>%
    behead("left", province) %>%
    rename(value = chr) %>%
    select(-data_type, -row, -col)
  return(dt_cell)
}

## example
wb <- loadWorkbook(path_xls, create = TRUE)
dt <- readWorksheet(wb, sheet = 1,header = F)
pivot_range <- getRange(dt)
pivot_rows <- pivot_range$start:pivot_range$end
tbl_raw <- unpivot(dt, pivot_rows)


#-----pivot and combine all data tables from xls file------

dir_final <- c("01-machine",
               "02-fertilizer",
               "03-plastic",
               "04-pesticide",
               "05-test")
dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"
file_dir <- glue::glue("{dir_media}{dir_final}")
#path_xls <- "data-raw/MyFile.xls"
file_xls <- "raw-2018-2019.xls"
path_xls <- glue::glue("{file_dir[1]}/{file_xls}")
wb <- loadWorkbook(path_xls, create = TRUE)

getSheets(wb)
removeSheet(wb,"CNKI")
# get the numbers of sheets. It should minus one to drop the last sheet contains only copyright informal .
sheetnum <- length(getSheets(wb))
if (sheetnum==0) {
  stop("no files founded, please check file existed")
}  else{
  print(glue::glue("totally {sheetnum} xls sheet need to unpivot."))
}


#i <- 2
df_out <- NULL
for (i in 1: sheetnum){
  print(glue::glue("begin unpivot the {i} of {sheetnum} xls sheet."))
  dt <- readWorksheet(wb, sheet = i,header = F)
  pivot_range <- getRange(dt)
  len <- nrow(pivot_range)
  print(glue::glue("totally {len} pivot table detect in this sheet."))

  #j <-1
  for (j in 1:len){
    pivot_rows <- pivot_range$start[j]:pivot_range$end[j]
    df_tem <- unpivot(dt, rows = pivot_rows)
    print(glue::glue("Successfully unpivot the {j} of {len} pivot data region."))
    df_out <- bind_rows(df_out, df_tem)
  } # end loop j
} # end loop i

# usethis::use_data(wfl_unpivot, overwrite = TRUE)
