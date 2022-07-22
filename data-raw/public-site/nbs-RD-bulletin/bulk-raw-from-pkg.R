# ===== bulk to output raw
# no use here,
# this chunk should be run once at the first plce
data("RDIntense")

year_out <- sort(unique(RDIntense$year))[1:6]

dir_media <- "data-raw/public-site/nbs-RD-bulletin/"
dir_tar <- "02-xls/"
dir_files <- paste0(dir_media, dir_tar)

i <- "2017"
for (i in year_out) {
  name_files <- paste0("raw-",i,".xlsx")
  path_files <- paste0(dir_files, name_files)

  dt_out <- RDIntense %>%
    filter(year == i) %>%
    select(province, chn_block4, value) %>%
    pivot_wider(names_from = chn_block4,
                values_from = value) %>%
    rename("地区"="province") %>%
    write.xlsx(., path_files)
}

# ====bulk to output tidy====

data("RDIntense")

year_out <- sort(unique(RDIntense$year))

dir_media <- "data-raw/data-tidy/public-site/nbs-RD-bulletin/"
dir_tar <- "02-xls/"
dir_files <- paste0(dir_media, dir_tar)

i <- "2017"
for (i in year_out) {
  name_files <- paste0(i,".xlsx")
  path_files <- paste0(dir_files, name_files)

  dt_out <- RDIntense %>%
    filter(year == i) %>%
    write.xlsx(., path_files)
}
