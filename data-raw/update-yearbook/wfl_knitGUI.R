
# ==== prepare ====
## load pacakge

require(devtools)
load_all()

source("data-raw/set-global.R")

## collection of directory for data base
tbl_dir <- tribble(
  ~case, ~media, ~final,
  "agri_prod",
    "data-raw/rural-yearbook/part03-agri-produce/",
    c("01-machine", "02-fertilizer","03-plastic", "04-pesticide"),
  "budget",
    "data-raw/nation-yearbook/part07-finance/",
    c("01-public-income", "02-public-budget"),
  "RD_nbs", # national bureau statistics
    "data-raw/public-site/nbs-RD-bulletin/",
    c("02-xls/"),
  "RD_over",
    "data-raw/tech-yearbook/part01-over/",
    c("01-labor-hour", "02-spend-intense","03-spend-inner", "05-public-professionals"),
  "RD_inner",
    "data-raw/tech-yearbook/part01-over/03-spend-inner/",
    c("01-activity", "02-source","03-purpose"),
  "RD_firm",
    "data-raw/tech-yearbook/part02-firm/",
    c("00-firms", "01-employee","03-spend-inner",
      "04-spend-outer", "05-RD-projects","06-RD-institution",
      "07-new-product","08-patent","09-tech-renew"),
  "RD_industry",
    "data-raw/tech-yearbook/part05-industry/",
    c("01-operation", "02-RD","03-trade"),
  "RD_output",
    "data-raw/tech-yearbook/part08-output/",
    c("01-patent", "02-enrollmark",
      "03-teckmarket-pull", "04-teckmarket-push"),
  "livestock",
    "data-raw/livestock-yearbook/",
    c("02-breeding")
)


# =====step 1: get files and path=====
#source("data-raw/update-yearbook/wfl_files.R")

## --construct file system and dir path--
dir_case <- "RD_industry"
dir_media <- tbl_dir %>% filter(case ==dir_case) %>%
  pull(media)
dir_final <- tbl_dir %>% filter(case ==dir_case) %>%
  pull(final) %>% unlist()

file_dir <- glue::glue("{dir_media}{dir_final}")

## specify which final directory ?
i_sel <- 1   # change here
dir_sel <- file_dir[i_sel]

## patterns to target which file(s)?
first_year <- 2019
last_year <- 2020
files_pattern <- list(
  year_one = glue("^raw-{last_year}.xls$"),
  year_two = glue("^raw-{first_year}-{last_year}.xls$"),
  year_onex = glue("^raw-{last_year}.xlsx$"),
  year_twox = glue("^raw-{first_year}-{last_year}.xlsx$"),
  edited_one = glue("^raw-{last_year}-edited.xlsx$"),
  edited_two = glue("^raw-{first_year}-{last_year}-edited.xlsx$")
)

pattern_sel <- files_pattern$edited_one # change here when neccesary

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
source("data-raw/update-yearbook/wfl_unlock.R")
unlock_xlsx(tar_dir = dir_sel,tar_xls = file_sel)

# =====step 4: rename download xls files =====
## ignore following steps if unneccesary
source("data-raw/update-yearbook/wfl_rename.R")
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

# =====step 6.1: loop unpivot=====
## use helper functions
source("data-raw/update-yearbook/wfl_unpivot_new.R", encoding = "UTF-8")

## target file and its path
### choose your type
#myfile <- str_replace(file_xls,("\\.xls"), "-edited\\.xlsx")
myfile <- file_xls
mypath <- glue::glue("{dir_sel}/{myfile}")

## header mode options
header_mode <- c("vars", "vars-vars","vars-year",
                 "vars-h3","vars-h4","vars-h5")

df_unpivot <- loop_unpivot(
  tar_file = mypath,
  hd_mode = "vars", # change here!
  vars_add = NULL, cols_drop = NULL)

## check result
(check <- df_unpivot %>%
  filter(is.na(vars)))


# =====step 7: tidy data =====
source("data-raw/update-yearbook/wfl_tidy.R", encoding = "UTF-8")

df_tidy <- getTidy(dt = df_unpivot) %>%
  select(province, year,
         vars, value, units)

unique(df_tidy$vars)
unique(df_tidy$province)

# ======step 8.1: match and check variables names to the varsList====

## target list collection
tar_list<- list(
  v7_machine = list(block1 = "v7",block2 = "sctj",
                    block3 = "nyjx"),
  v7_fertilizer = list(block1 = "v7",block2 = "sctj",
                    block3 = c("nyhf")),
  v7_plastic = list(block1 = "v7",block2 = "sctj",
                    block3 = c("nybm")),
  v7_pesticide = list(block1 = "v7",block2 = "sctj",
                    block3 = c("cyny")),
  v6_budget =  list(block1 = "v6",block2 = "cz",
                    block3 = "yszc"),
  v4_RDnbs =  list(block1 = "v4",block2 = "ztr",
                    block3 = c("jf","qd")),
  v4_RDinner =  list(block1 = "v4",block2 = "zh",
                    block3 = "nbzc"),
  v4_RDfirm =  list(block1 = "v4",block2 = "qy",
                    block3 = "qysl"),
  v4_RDpush =  list(block1 = "v4",block2 = "cg",
                    block3 = "jssc"),
  v4_operation =  list(block1 = "v4",block2 = "cy",
                    block3 = "scjy"),
  v4_RDtrade = list(block1 = "v4",block2 = "cy",
                    block3 = "my"),
  v8_livestock_t1 = list(block1 = "v8",block2 = "t1",
                         block3 = c("zcqc")),
  v8_livestock_t2 = list(block1 = "v8",block2 = "t2",
                         block3 = c("zcqc")),
  v8_livestock_t3 = list(block1 = "v8",block2 = "t3",
                         block3 = c("zcqc","nmcl")),
  v8_livestock_t4 = list(block1 = "v8",block2 = "t4",
                         block3 = c("zcqc","nmcl")),
  v8_livestock_t5 = list(block1 = "v8",block2 = c("t5"),
                         block3 = c("zcqc","nmcl")),
  v8_livestock_t6 = list(block1 = "v8",block2 = c("t6"),
                         block3 = c("nfmccl")),
  v8_livestock_t7 = list(block1 = "v8",block2 = c("t7"),
                         block3 = c("nfmccl","cczcq")),
  v8_livestock_t8 = list(block1 = "v8",block2 = c("t8"),
                         block3 = c("cczcq","scpt")),
  v8_livestock_t9 = list(block1 = "v8",block2 = c("t9"),
                         block3 = c("scpt","scjy"))
)


## now match and check the names
tar_name <- "v4_operation"
mytar <- tar_list[[tar_name]]
source("data-raw/update-yearbook/wfl_matchVars.R", encoding = "UTF-8")
(df_vars_matched <- matchVars(dt = df_tidy, block_target = mytar))

# ==== step 8.2: check and replace chinese name of vars ====
## target search
data("varsList")
get_vars(varsList,lang = "eng", block = mytar, what = "chn_block4" )

## replacement pattern by collection
tbl_pattern <- tribble(
  ~case, ~ptn, ~rpl,
  "machine", c("谷物联合收割机"), c("联合收获机"),
  "fertilizer", c("农用化肥施用量"), c("化肥使用量"),
  "plastic", c("农用塑料薄膜使用量"), c("农用薄膜使用量"),
  "budget",
    c("地方一般公共预算支出","教育支出","科学技术支出","农林水支出"),
    c("合计","教育","科学技术","农林水"),
  "RDinner",
    c("经费内部支出"),
    c("合计"),
  "RD",
    c("有研发机构的企业数", "有R&D活动的企业数"),
    c("有研发机构", "有RD活动"),

  "hitech",
    c("项目数","新产品开发项目数","新产品开发经费支出","新产品销售收入","有效发明专利数"),
    c("项目数量","开发项目数","开发经费支出","销售收入","有效专利数"),
  "operation", c("营业收入"), c("主营业务收入"),
  "trade", c("进出口贸易总额"), c("贸易总额"),
  "livestock tab01", c("种畜禽场总数"),c("总数"),
  "livestock tab04",
    c("祖代及以上场","祖代蛋鸡场","父母代场"),
    c("祖代及以上蛋鸡场","祖代及以上蛋鸡场","父母代蛋鸡场"),
  "livestock tab07", c("种羊细场毛"), c("种细毛羊场"),
  "livestock tab08",
    c("祖代蛋鸡场","祖代以上肉鸡场"),
    c("祖代及以上蛋鸡场","祖代及以上肉鸡场")
)

## get my pattern
mycase <- "operation"
ptn <- tbl_pattern %>% filter(case ==mycase) %>%
  pull(ptn) %>% unlist()
rpl <- tbl_pattern %>% filter(case ==mycase) %>%
  pull(rpl) %>% unlist()

## now get clear matched names
df_tidy <- df_tidy %>%
  mutate(vars= mgsub::mgsub(vars, ptn, rpl)) # %>%
  # for special case such as budget
  # filter(vars %in% rpl )

# ==== step 8.3: matched english names of vars####
## rerun the matched table
df_vars_matched <- matchVars(dt = df_tidy, block_target = mytar)%>%
  filter(asis==TRUE)
## write out for check
#openxlsx::write.xlsx(df_vars_matched, "data-raw/df-vars-matched.xlsx")


# =====step 9: left join to varsList and export data =====
#yearbook <- "rural-yearbook"
#yearbook <- "tech-yearbook"
#noDir <- FALSE
source("data-raw/update-yearbook/wfl_matchData.R", encoding = "UTF-8")

df_matched <- matchData(
  dt_left = df_tidy,
  dt_right = df_vars_matched)
# check it

unique(df_matched$variables)
sum(is.na(df_matched$variables))

#last_dir <- str_extract(path_xls, "(part.+)") %>%
#  str_replace(., "(?<=\\.)(.+)", "xlsx")
#tidy_file_name <- mgsub::mgsub(last_dir,
#                          c("raw", "/", "-edited"),
#                          c("tidy", "-", ""))

# ==== step 10: write out ====
## generte directory
dir_sub1 <- "data-raw/data-tidy/"
dir_sub2 <- gsub("data-raw/", "",dir_sel)
dir_tidy <- paste0(dir_sub1, dir_sub2)
#gen_dirs_vec(media = dir_sub1, final = dir_sub2)

## specify file name
vec_year <- sort(unique(df_matched$year))
vec_tab <- 9
prefix <- "ammount"
mytidy <- list(
  mod_year = glue::glue("{vec_year}.xlsx" ),
  mod_year_tbl = glue::glue("year-{vec_year}-{vec_tab}.xlsx" ),
  mod_prefix_year = glue::glue("{prefix}-{vec_year}.xlsx" )
)

## file path
files_tidy <- mytidy$mod_year
(tidy_path <-paste0(dir_sub1, dir_sub2,"/",files_tidy))

## loop to export xlsx
tar_year <- c(2020)

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
source("data-raw/update-yearbook/wfl_useData.R", encoding = "UTF-8")

## 11.1 loop read all tidy xlsx files
dir_media_tar <- str_replace(dir_media,
                             "data-raw",
                             "data-raw/data-tidy")
(dir_final_tar <- dir_final[i_sel]) # i_sel before

df_use <- loop_read(dir.media = dir_media_tar,
                    dir.fina = dir_final_tar,
                    file.pattern = "\\d{4}")

## 11.2 match units to base varsList,
## and this is only used when neccesary!
df_units <- match_units(df = df_use)




## 11.3 now use_data()  here
use_list <- c(
  "AgriMachine",
  "AgriFertilizer",
  "AgriPlastic",
  "AgriPesticide",
  "PublicBudget",
  "RDIntense",
  "RDActivity",
  "MarketPull",
  "MarketPush",
  "HitechFirmsPub",
  "IndustryTrade",
  "IndustryRD",
  "IndustryOperation",
  "LivestockBreeding" # df_units
)

name_dt <- use_list[13] # change here
which_dt <- "df_units"  # change here

use_mydata(name.dt = name_dt,
           which.dt = which_dt)


# ====step 12: write document=====
require(devtools)
load_all()
use_r("Livestock-Breeding.R")
# use my custom function  to help writing document
do.call("techme::document_dt", list(as.name(name_dt)))
document()
