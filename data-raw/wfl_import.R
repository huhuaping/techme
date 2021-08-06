## code to prepare `wfl_import` dataset goes here

# read file from history files
url_xlsx <- "d://github/tech-report/data-extract/part01-01-machine-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-01-machine-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-02-fertilizer-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-03-plastic-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-04-pesticide-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-04-pesticide-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-analysis/part01-07-finance-public-budget2010t2018.xlsx"
url_xlsx <- "d://github/tech-report/data-analysis/part01-RD-update.xlsx"
url_xlsx <- "d://github/tech-report/data-analysis/part01-inner-activity-upto-2018.xlsx"

df_import <- openxlsx::read.xlsx(url_xlsx)

# get additional info
## merchine
vars_table <- get_vars(varsList, block = list(block1= "v7",
                                              block2 = "sctj",
                                              block3 = "nyjx"),
                       what = c("variables","chn_block4", "units"))
## fertilizer
vars_table <- get_vars(varsList, block = list(block1= "v7",
                                              block2 = "sctj",
                                              block3 = "nyhf",
                                              block4 = "hj"),
                       what = c("variables","chn_block4", "units"))
## plastics
vars_table <- get_vars(varsList, block = list(block1= "v7",
                                              block2 = "sctj",
                                              block3 = "nybm",
                                              block4 = "bmsy"),
                       what = c("variables","chn_block4", "units"))
## pesticide
vars_table <- get_vars(varsList, block = list(block1= "v7",
                                              block2 = "sctj",
                                              block3 = "cyny",
                                              block4 = "nysy"),
                       what = c("variables","chn_block4", "units"))

## public budget
vars_table <- get_vars(varsList, block = list(block1= "v6",
                                              block2 = "cz",
                                              block3 = "yszc"),
                       what = c("variables","chn_block4", "units"))

## RD intense
vars_table <- get_vars(varsList, block = list(block1= "v4",
                                              block2 = "ztr"),
                       what = c("variables","chn_block4", "units"))
## RD intense
vars_table <- get_vars(varsList, block = list(block1= "v4",
                                              block2 = "zh",
                                              block3 = "nbzc"),
                       what = c("variables","chn_block4", "units"))

vars_order <- c('province','year','chn_block4','value','units','variables')

df_reface <- df_import %>%
  #gather(key = "variables", value = "value", -province, -year) %>%
  left_join(., vars_table, by = "variables") %>%
  mutate(year = as.character(year)) %>%
  select(all_of(vars_order)) %>%
  arrange(variables, desc(year)) #%>%
  #arrange(province,variables,desc(year))

# dir and path

# extract year
vec_year <- sort(unique(df_reface$year))
files_tidy <- glue::glue("{vec_year}.xlsx" )

# file path
tidy_path <-paste0(dir_sub1, dir_sub2,"/",files_tidy)

tidy_path # see the files' path

# loop to export xlsx
for (id_year in vec_year) {
  n_year <- which(str_detect(tidy_path, id_year))
  df_reface %>%
    filter(year == id_year) %>%
    openxlsx::write.xlsx(., tidy_path[n_year])
  print(glue::glue("Export Year {id_year} has finished!"))
  Sys.sleep(0.1)
}


#usethis::use_data(wfl_import, overwrite = TRUE)
