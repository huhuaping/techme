## code to prepare `wfl_useData_NKRDP` dataset goes here

# source pkgs

source("data-raw/set-global.R")

#==== create dir =====

dir_media <- "data-raw/data-tidy/public-site/agri-park/"
dir_fina <- "xlsx/"
gen_dirs_vec(dir_media, dir_fina)

out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)

#===== part 1 approved list  ======

# file path
files_id <- which(str_detect(files_all,"list-batch"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# batch read xlsx files
tbl_read <- tibble(url = files_path) %>%
  mutate(table = map(url, ~openxlsx::read.xlsx(.x))) %>%
  select(-url) %>%
  unnest(table)

# just for check
index_dup <- which(duplicated(tbl_read$name))
tbl_check <-  tbl_read %>%
  .[index_dup,]

tbl_out <- tbl_read %>%
  .[-index_dup,]

# write out
PubAgriParkList <- tbl_out
usethis::use_data(PubAgriParkList, overwrite = TRUE)

# write document
use_r("Pub-AgriParkList")
document_dt(PubAgriParkList)
document()

#===== part 2 evaluation result ======

# file path
files_id <- which(str_detect(files_all,"eval-year"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# batch read xlsx files
tbl_read <- tibble(url = files_path) %>%
  mutate(table = map(url, ~openxlsx::read.xlsx(.x))) %>%
  select(-url) %>%
  unnest(table)

# just for check
index_dup <- which(duplicated(tbl_read$name))
tbl_check <-  tbl_read %>%
  .[index_dup,]

# write out
PubAgriParkEval <- tbl_read
usethis::use_data(PubAgriParkEval, overwrite = TRUE)

# write document
use_r("Pub-AgriParkEval")
document_dt(PubAgriParkEval)
document()
