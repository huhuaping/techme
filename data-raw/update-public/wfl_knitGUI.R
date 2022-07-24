
# ==== prepare ====
## load pacakge

require(devtools)
load_all()

source("data-raw/set-global.R")

## collection of directory for data base
tbl_dir <- tribble(
  ~case, ~media, ~final,
  "observe_station",
    "data-raw/public-site/observe-station/",
    c("xlsx/")
)


# =====step 1: get files and path=====
#source("data-raw/Rscript-update/wfl_files.R")

## --construct file system and dir path--
dir_case <- "observe_station"
dir_media <- tbl_dir %>% filter(case ==dir_case) %>%
  pull(media)
dir_final <- tbl_dir %>% filter(case ==dir_case) %>%
  pull(final) %>% unlist()

file_dir <- glue::glue("{dir_media}{dir_final}")

## specify which final directory ?
i_sel <- 1   # change here
dir_sel <- file_dir[i_sel]

## patterns to target which file(s)?
officer <- "most"
first_year <- 2019
last_year <- 2021
files_pattern <- list(
  year_one = glue("{officer}-year-{last_year}.xlsx$")
  )


pattern_sel <- files_pattern$year_one # change here when neccesary

## match and position files
files_all <- list.files(dir_sel)
file_xls <- files_all[which(str_detect(files_all, pattern_sel))]
path_xls <- glue::glue("{dir_sel}/{file_xls}")

file_sel <- file_xls
print(glue::glue(" You have selected  totally {length(path_xls)} file(s) and the path(s) are : {path_xls}"))


# =====step 2: generate dirs=====
## here ignore this step
source("data-raw/wfl_genDirs.R")


# =====step 3: unlock xlsx files =====
## you should 'save as' to '.xlsx' by hand!!
source("data-raw/Rscript-update/wfl_unlock.R")
unlock_xlsx(tar_dir = dir_sel,tar_xls = file_sel)

# =====step 4: rename download xls files =====
## ignore following steps if unneccesary
source("data-raw/Rscript-update/wfl_rename.R")
rename_xls_files(dir = dir_sel,
                 ptn_target_file ="2020-unlocked\\.xlsx$",
                 ptn = "(unlocked)",
                 rpl ="edited")

# =====step 5: edit xlsx files manually =====
## no need here
source("data-raw/wfl_editXls.R")
Sys.sleep(1)
print("OK! Edit the xlsx file finished!")

# ==== step 6.0 prepare vars====
## use this only if `head.mode ="year"`
data("varsList")
vars_spc <- techme::get_vars(df = varsList, lang = "eng",
                     block = list(block1 = "v7",block2 = "sctj",
                                  block3 = c("nyhf")
                                  #,block4 = "ht"
                     ),
                     what = "chn_block4")

# =====step 6.1: read data =====

## target file and its path
### choose your type
#myfile <- str_replace(file_xls,("\\.xls"), "-edited\\.xlsx")
myfile <- file_xls
mypath <- glue::glue("{dir_sel}/{myfile}")

df_read <- readxl::read_excel(mypath)

# =====step 6.2: match institution with province =====

source("data-raw/update-public/wfl_matchProvince.R")
myptn <- "、"
df_province <- match_province(df = df_read,
                              ptn_inst = myptn)

# =====step 6.3: pivot long =====
source("data-raw/update-public/wfl_pivot.R")
df_long <- pivot_long(df = df_province)

## check result
(check <- df_long %>%
  filter(is.na(block4)))


# ======step 7: match and check variables names to the varsList====
## target list collection
tar_list <- list(
  v99_obstation = list(block1 = "v99",
                       block2 = "obstation",
                       block3 = c("list"))
  )

## now match and check the names
tar_name <- "v99_obstation"
mytar <- tar_list[[tar_name]]
source("data-raw/update-public/wfl_matchVars.R", encoding = "UTF-8")
(df_vars_matched <- matchVars(dt = df_long,
                              block_target = mytar))

# ==== step 8.1: check and replace English name of vars ====
## may be not used !
## target search
data("varsList")
get_vars(varsList,lang = "eng", block = mytar, what = "chn_block4" )

## replacement pattern by collection
tbl_pattern <- tribble(
  ~case, ~ptn, ~rpl,
  "machine", c("谷物联合收割机"), c("联合收获机")#,
)

## get my pattern
mycase <- "machine"
ptn <- tbl_pattern %>% filter(case ==mycase) %>%
  pull(ptn) %>% unlist()
rpl <- tbl_pattern %>% filter(case ==mycase) %>%
  pull(rpl) %>% unlist()

## now get clear matched names
df_long <- df_long %>%
  mutate(vars= mgsub::mgsub(vars, ptn, rpl)) # %>%
  # for special case such as budget
  # filter(vars %in% rpl )

# ==== step 8.2: matched english names of vars####
## rerun the matched table
df_vars_matched <- matchVars(
  dt = df_long,
  block_target = mytar)%>%
  filter(asis==TRUE)
## write out for check
#openxlsx::write.xlsx(df_vars_matched, "data-raw/df-vars-matched.xlsx")


# =====step 9: left join to varsList and export data =====
source("data-raw/update-public/wfl_matchData.R", encoding = "UTF-8")
df_matched <- matchData(dt_left = df_long,
                        dt_right = df_vars_matched)
# check it
unique(df_matched$variables)
sum(is.na(df_matched$variables))


# ==== step 10: write out ====
## generte directory
dir_sub1 <- "data-raw/data-tidy/"
dir_sub2 <- gsub("data-raw/", "",dir_sel)
dir_tidy <- paste0(dir_sub1, dir_sub2)
#gen_dirs_vec(media = dir_sub1, final = dir_sub2)

## specify file name
id_list <- sort(unique(df_matched$id))
vec_tab <- 9
prefix <- "ammount"
mytidy <- list(
  mod_year = glue::glue("{id_list}.xlsx" ),
  mod_year_tbl = glue::glue("{id_list}-{vec_tab}.xlsx" ),
  mod_prefix_year = glue::glue("{prefix}-{id_list}.xlsx" )
)

## file path
files_tidy <- mytidy$mod_year
(tidy_path <-paste0(dir_sub1, dir_sub2,"/",files_tidy))

## loop to export xlsx
tar_year <- c(2021)

for (id_year in tar_year) {
  n_year <- which(str_detect(tidy_path, as.character(id_year)))
  df_matched %>%
    filter(year == id_year) %>%
    openxlsx::write.xlsx(., tidy_path[n_year])

  print(glue("Export file of year {id_year} successed! \n path to: {tidy_path[n_year]} "))
  Sys.sleep(0.1)
}


# ==== step 11: use_data ====
## source R script firstly
source("data-raw/update-public/wfl_useData.R", encoding = "UTF-8")

## 11.1 loop read all tidy xlsx files
dir_media_tar <- str_replace(dir_media,
                             "data-raw",
                             "data-raw/data-tidy")
(dir_final_tar <- dir_final[i_sel]) # i_sel before


df_use <- loop_read(dir.media = dir_media_tar,
                    dir.fina = dir_final_tar,
                    file.pattern = "\\d{4}")

## 11.3 now use_data()  here

use_list <- c(
  "PubObsStationX" # df_units
)

name_dt <- use_list[1]
which_dt <- "df_use"

use_mydata(name.dt = name_dt,
           which.dt = which_dt)


# ====step 12: write document=====
require(devtools)
load_all()
use_r("Pub-ObsStationX.R")
# use my custom function  to help writing document
do.call("techme::document_dt", list(as.name(name_dt)))
document()
