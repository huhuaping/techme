## code to prepare `wfl_knitAll` dataset goes here

require(devtools)
load_all()

#dir_final <- c("01-machine", "02-fertilizer","03-plastic", "04-pesticide")
#dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"

# default the first directory
i_sel <- 1
file_sel <- "raw-2018.xls"
#file_sel <- "raw-2018-2019-edited.xlsx"

tidy.Xlsx<- function(dir_final, dir_media,
         i_sel = 1, file_sel
         ){
  # step 1: filesystem------
  source("data-raw/wfl_files.R")

  # step 2: generate dirs------
  source("data-raw/wfl_genDirs.R")

  # step 3: rename download xls files -----
  ## ignore following steps if unneccesary
  source("data-raw/wfl_rename.R")

  # step 4: unlock xlsx files ------
  source("data-raw/wfl_unlock.R")

  # step 5: edit xlsx files manually ------
  source("data-raw/wfl_editXls.R")
}





# step 6: begin unpivot
## whether drop columns and specify the header mode.
cols_drop <- c(2)
header_mode <- "vars"
## following value only for header.mode=="year"
## and you should specify it manuualy
vars_spc <- get_vars(df = varsList, lang = "eng",
                      block = list(block1 = "v4",block2 = "zh",block3 = "qd",
                                   block4 = "RD"),
                      what = "chn_block4")

source("data-raw/wfl_unpivot.R", encoding = "UTF-8")


# step 7: tidy data -----
source("data-raw/wfl_tidy.R", encoding = "UTF-8")

# step 8: match and check variables names to the varsList ----
## check if warnings
## target search
#target <- list(block1 = "v4",block2 = "zh",block3 = "qd")
target <- list(block1 = "v4",block2 = "qy",block3 = "qysl")
source("data-raw/wfl_matchVars.R", encoding = "UTF-8")
df_vars_matched

## target search
get_vars(varsList,lang = "eng", block = target, what = "chn_block4" )
## replace characters
ptn <- c("有研发机构的企业数", "有R&D活动的企业数")
rpl <- c("有研发机构", "有RD活动")
df_tidy <- df_tidy %>%
  mutate(vars= mgsub::mgsub(vars, ptn, rpl))
## rerun the function
df_vars_matched <- matchVars(dt = df_tidy, block_target = target)
openxlsx::write.xlsx(df_vars_matched, "data-raw/df-vars-matched.xlsx")


# step 9: left join to varsList and export data -----
yearbook <- "tech-yearbook"
noDir <- FALSE
source("data-raw/wfl_matchData.R", encoding = "UTF-8")
tidy_path
openxlsx::write.xlsx(df_matched, tidy_path)

#usethis::use_data(wfl_knitAll, overwrite = TRUE)
