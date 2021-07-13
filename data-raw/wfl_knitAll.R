## code to prepare `wfl_knitAll` dataset goes here

require(devtools)
load_all()

# default the first directory
i_sel <- 2
file_sel <- "raw-2018.xls"
#file_sel <- "raw-2018-2019-edited.xlsx"
source("data-raw/wfl_files.R")

# ignore following steps if unneccesary
source("data-raw/wfl_genDirs.R")

source("data-raw/wfl_rename.R")

source("data-raw/wfl_unlock.R")

source("data-raw/wfl_editXls.R")

# begin
source("data-raw/wfl_unpivot.R", encoding = "UTF-8")

source("data-raw/wfl_tidy.R", encoding = "UTF-8")

# hand check if warnings
source("data-raw/wfl_matchVars.R", encoding = "UTF-8")

## target search
target_search <- list(block1 ="v7", block2="sctj",block3 ="nyjx")
get_vars(varsList,lang = "eng", block = target_search, what = "chn_block4" )
## replace characters
df_tidy <- df_tidy %>%
  mutate(vars= str_replace(vars, "农用塑料薄膜使用量", "农用薄膜使用量"))
## rerun the wfl_matchVars.R

# match varsList and export out data
source("data-raw/wfl_matchData.R", encoding = "UTF-8")

#usethis::use_data(wfl_knitAll, overwrite = TRUE)
