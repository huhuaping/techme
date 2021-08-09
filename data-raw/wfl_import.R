## code to prepare `wfl_import` dataset goes here

# read file from history files
#url_xlsx <- "d://github/tech-report/data-extract/part01-01-machine-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-01-machine-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-02-fertilizer-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-03-plastic-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-04-pesticide-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-extract/part01-04-pesticide-2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-analysis/part01-07-finance-public-budget2010t2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-analysis/part01-RD-update.xlsx"
#url_xlsx <- "d://github/tech-report/data-proc/update-part01-RD-year2019.xlsx"
#url_xlsx <- "d://github/tech-report/data-analysis/part01-inner-activity-upto-2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-raw/tech-yearbook/part08-output/03-teckmarket-pull/data-update/gather-pull-amount-funds-upto-2018.xlsx"
#url_xlsx <- "d://github/tech-report/data-raw/tech-yearbook/part08-output/04-teckmarket-push/data-update/gather-push-amount-funds-upto-2018.xlsx"
#url_xlsx <- "D:/github/tech-report/data-raw/public-site/torch-innocom/csv/tbl-smry-upto-2020.xlsx"
url_xlsx <- "D:/github/tech-report/data-raw/tech-yearbook/part05-industry/data-update"

# use dirs if lots files need to ipmport
dir_xlsx <- "D:/github/tech-report/data-raw/tech-yearbook/part05-industry/data-update"
files_xlsx <-  list.files(dir_xlsx)
tbl_sel <- tibble(files = files_xlsx) %>%
  mutate(year = as.numeric(str_extract(files, "(\\d{4})")),
         table = str_extract(files, "(t\\d{2})")) %>%
  group_by(table) %>%
  top_n(.,n = 1, wt =  year)
url_xlsx <- paste0(dir_xlsx,"/", tbl_sel$files)



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
## tech market
vars_table <- get_vars(varsList, block = list(block1= "v4",
                                              block2 = "cg",
                                              block3 = "jssr"),
                       what = c("variables","chn_block4", "units"))

## industry
vars_table <- get_vars(varsList, block = list(block1= "v4",
                                              block2 = "cy",
                                              block3 = c("scjy","RDhd","xcp","qyzl","jsgz","cytz","my")),
                       what = c("variables","chn_block4", "units"))

vars_order <- c('province','year','chn_block4','value','units','variables')
i <- 5

df_import <- NULL
for (i in 1:length(url_xlsx)){
  df_tem <- openxlsx::read.xlsx(url_xlsx[i]) %>%
    mutate(value = as.numeric(value))
  #filter(variables == "v4_cg_jssr_ht")
  df_import <- bind_rows(df_import, df_tem)
  print(glue("{url_xlsx[i]} has proceeded!"))
}

unique(df_import$variables)

df_reface <- df_import %>%
  mutate(year = as.character(year)) %>%
  #gather(key = "variables", value = "value", -province, -year) %>%
  left_join(., vars_table, by = "variables") %>%
  mutate(year = as.character(year)) %>%
  select(all_of(vars_order)) %>%
  arrange(variables, desc(year)) #%>%
#arrange(province,variables,desc(year))

# dir and path

# extract year
vec_year <- sort(unique(df_reface$year)) %>%
  .[which(.<2018)]
files_tidy <- glue::glue("{vec_year}.xlsx" )

dir_tidy <- "data-raw/data-tidy/tech-yearbook/part05-industry/03-trade/"

# file path
tidy_path <- paste0(dir_tidy,files_tidy)


# use this if need to generate dirs
#tidy_path <- paste0(dir_sub1, dir_sub2,"/",files_tidy)
gen_dirs_vec(media = "data-raw/data-tidy/tech-yearbook/part05-industry/",
             final = "03-trade/")

tidy_path # see the files' path


# loop to export xlsx

for (id_year in vec_year) {
  n_year <- which(stringr::str_detect(tidy_path, as.character(id_year)))
  df_reface %>%
    filter(year %in% id_year) %>%
    #mutate(index = 1:nrow(.)) %>%
    openxlsx::write.xlsx(., tidy_path[n_year])
  print(glue::glue("Export Year {id_year} has finished!"))
  Sys.sleep(0.1)
}


#usethis::use_data(wfl_import, overwrite = TRUE)
