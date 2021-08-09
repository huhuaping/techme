## code to prepare `wfl_knitGUI` dataset goes here

require(devtools)
load_all()

#dir_final <- c("01-machine", "02-fertilizer","03-plastic", "04-pesticide")
#dir_media <- "data-raw/rural-yearbook/part03-agri-produce/"

#dir_final <- c("01-public-income", "02-public-budget")
#dir_media <- "data-raw/nation-yearbook/part07-finance/"

dir_final <- c("01-labor-hour", "02-spend-intense","03-spend-inner", "05-public-professionals")
dir_media <- "data-raw/tech-yearbook/part01-over/"

dir_final <- c("01-activity", "02-source","03-purpose")
dir_media <- "data-raw/tech-yearbook/part01-over/03-spend-inner/"

dir_final <- c("00-firms", "01-employee","03-spend-inner", "04-spend-outer",
               "05-RD-projects","06-RD-institution","07-new-product",
               "08-patent","09-tech-renew")
dir_media <- "data-raw/tech-yearbook/part02-firm/"

dir_final <- c("01-operation", "02-RD","03-trade")
dir_media <- "data-raw/tech-yearbook/part05-industry/"

#dir_final <- c("01-patent", "02-enrollmark","03-teckmarket-pull", "04-teckmarket-push")
#dir_media <- "data-raw/tech-yearbook/part08-output/"


# default the first directory
i_sel <- 1
#file_sel <- "raw-type-amount-2019.xls"
file_sel <- "raw-2018.xls"
#file_sel <- "raw-2018-2019.xls"
#file_sel <- "raw-2018-2019-edited.xlsx"

# step 1: filesystem------
source("data-raw/wfl_files.R")

# step 2: generate dirs------
source("data-raw/wfl_genDirs.R")

# step 3: rename download xls files -----
## ignore following steps if unneccesary
# source("data-raw/wfl_rename.R")

# step 4: unlock xlsx files ------
source("data-raw/wfl_unlock.R")

# step 5: edit xlsx files manually ------
source("data-raw/wfl_editXls.R")

# step 6: begin unpivot
## whether drop columns and specify the header mode.
cols_drop <- c(2)
#cols_drop <- NULL
header_mode <- c("vars")
#header_mode <- c("vars","vars-vars")

## following value only for header.mode=="year"
## and you should specify it manuualy
vars_spc <- get_vars(df = varsList, lang = "eng",
                      block = list(block1 = "v4",block2 = "cy",
                                   block3 = c("my")
                                   #,block4 = "ht"
                                   ),
                      what = "chn_block4")

source("data-raw/wfl_unpivot_new.R", encoding = "UTF-8")


# step 7: tidy data -----
source("data-raw/wfl_tidy.R", encoding = "UTF-8")

# step 8: match and check variables names to the varsList ----
## check if warnings
## target search
#target <- list(block1 = "v6",block2 = "cz",block3 = "yszc")
#target <- list(block1 = "v7",block2 = "sctj",block3 = "nyjx")
#target <- list(block1 = "v4",block2 = "qy",block3 = "qysl")
#target <- list(block1 = "v4",block2 = "cg",block3 = "jssc")
target <- list(block1 = "v4",block2 = "cy",
               block3 = "my")


source("data-raw/wfl_matchVars.R", encoding = "UTF-8")
df_vars_matched

## target search
get_vars(varsList,lang = "eng", block = target, what = "chn_block4" )
## replace characters
#ptn <- c("谷物联合收割机")
#rpl <- c("联合收获机")
#ptn <- c("有研发机构的企业数", "有R&D活动的企业数")
#rpl <- c("有研发机构", "有RD活动")
#ptn <- c("地方一般公共预算支出","教育支出","科学技术支出","农林水支出")
#rpl <- c("合计","教育","科学技术","农林水")
#ptn <- c("项目数","新产品开发项目数","新产品开发经费支出","新产品销售收入","有效发明专利数")
#rpl <- c("项目数量","开发项目数","开发经费支出","销售收入","有效专利数")
#ptn <- c("营业收入")
#rpl <- c("主营业务收入")
ptn <- c("进出口贸易总额")
rpl <- c("贸易总额")

df_tidy <- df_tidy %>%
  mutate(vars= mgsub::mgsub(vars, ptn, rpl))
## rerun the function
df_vars_matched <- matchVars(dt = df_tidy, block_target = target)%>%
  filter(asis==TRUE)
openxlsx::write.xlsx(df_vars_matched, "data-raw/df-vars-matched.xlsx")


# step 9: left join to varsList and export data -----
#yearbook <- "rural-yearbook"
#yearbook <- "tech-yearbook"
#noDir <- FALSE
source("data-raw/wfl_matchData.R", encoding = "UTF-8")

tidy_path # see the files' path
# loop to export xlsx

for (id_year in vec_year) {
  n_year <- which(str_detect(tidy_path, id_year))
  df_matched %>%
    filter(year == id_year) %>%
    openxlsx::write.xlsx(., tidy_path[n_year])
  print(glue("eport year {id_year} successed!"))
  Sys.sleep(0.1)
}


#usethis::use_data(wfl_knitAll, overwrite = TRUE)


# -----try console interact------

# svDialogs pkg to control interaction
# see url:https://github.com/SciViews/svDialogs
#install.packages("svDialogs")
require(svDialogs)

if (T) {
  # Ask something...
  user <- dlg_input("Who are you?", Sys.info()["user"])$res
  if (!length(user)) {# The user clicked the 'cancel' button
    cat("OK, you prefer to stay anonymous!\n")
  } else {
    cat("Hello", user, "\n")
  }
}


if (T) {
  # Select one or several months
  res <- dlg_list(month.name, multiple = TRUE)$res
  if (!length(res)) {
    cat("You cancelled the choice\n")
  } else {
    cat("You selected:\n")
    print(res)
  }
}

if (T) {
  # A quick default directory changer
  setwd(dlg_dir(default = getwd())$res)
}

if (T) {
  # A simple information box
  dlg_message("Hello world!")$res

  # Ask to continue
  dlg_message(c("This is a long task!", "Continue?"), "okcancel")$res

  # Ask a question
  dlg_message("Do you like apples?", "yesno")$res

  # Idem, but one can interrupt too
  res <- dlg_message("Do you like oranges?", "yesnocancel")$res
  if (res == "cancel")
    cat("Ah, ah! You refuse to answer!\n")

  # Simpler version with msgBox and okCancelBox
  msg_box("Information message") # Use this to interrupt script and inform user
  if (ok_cancel_box("Continue?")) cat("we continue\n") else cat("stop it!\n")
}


