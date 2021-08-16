## code to prepare `wfl_useData_NKRDP` dataset goes here

# source pkgs

source("data-raw/set-global.R")

# create dir

dir_media <- "data-raw/data-tidy/public-site/tech-plan/"
dir_fina <- "03-NKRDP/xlsx/"
gen_dirs_vec(dir_media, dir_fina)

# file path
out_dir <- paste0(dir_media, dir_fina)
files_all <- list.files(out_dir)
files_id <- which(str_detect(files_all,"projects-long"))
files_sel <- files_all[files_id]
files_path <- paste0(out_dir, files_sel)

# batch read xlsx files
tbl_read <- tibble(url = files_path) %>%
  mutate(table = map(url, ~openxlsx::read.xlsx(.x))) %>%
  select(-url) %>%
  unnest(table) %>%
  # filter projects without NO
  filter(NO!="") %>%
  unite(col = "id", year, date, NO, sep = "-")

# just for check
index_dup <- which(duplicated(tbl_read))
tbl_check <-  tbl_read %>%
  .[index_dup,]

tbl_wide <- tbl_read %>%
  pivot_wider(id_cols = id,
              names_from = variables,
              values_from = value) %>%
  separate(id, into = c("year", "date", "NO"), sep = "-")

#  tidy wide data frame
tbl_tidy <-  tbl_wide %>%
  mutate(NO_head = str_extract(NO, ".*(?=\\d{4}YF)"),
         NO_year = str_extract(NO, "(\\d{4})(?=YF)"),
         NO_mark = str_extract(NO, "(YF[[A-Z]]{1})"),
         NO_num = str_replace(NO, ".*YF.(\\d+)","\\1"),
         NO_num_p1 = str_extract(NO_num,"(^\\d{2})"),
         NO_num_p2 = str_replace(NO_num,"^\\d{2}(\\d+).*", "\\1"),
         NO_tail = str_extract(NO, "\\*$")
  ) %>%
  mutate(institution = str_trim(institution),
         institution = str_replace(institution, " ", ""))

# just for check
sum(duplicated(unique(tbl_tidy$type)))
tbl_check <- tbl_tidy %>%
  #filter(is.na(NO_head))
  filter(NO_tail=="*")


#===== write out ======

PubNKRDP <- tbl_tidy

usethis::use_data(PubNKRDP, overwrite = TRUE)
