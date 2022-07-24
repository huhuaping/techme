# not use! run only once!
# ==== prepare ====
## load pacakge

require(devtools)
load_all()

source("data-raw/set-global.R")

#require(techme)
data("AgriMachine")
data("PubObsStation")
data("varsList")
df_out <- PubObsStation

dir_raw <- "data-raw/public-site/observe-station/xlsx/"
dir_tidy <- str_replace(dir_raw, "data-raw","data-raw/data-tidy")

cols_id <- c( "year","officer","index")
df_pivot <- df_out %>%
  pivot_longer(names_to = "block4", values_to = "value",
               -all_of(cols_id))

vars_spc <- techme::get_vars(df = varsList, lang = "eng",
                             block = list(block1 = "v99",block2 = "obstation",
                                          block3 = c("list")
                                          #,block4 = "ht"
                             ),
                             what = c("variables","block3","block4","chn_block4"))

cols_sort <- c("id","year", "officer","index",
               "block3","block4", "chn_block4",
               "value", "variables")
df_matched <- df_pivot %>%
  left_join(., vars_spc, by="block4") %>%
  mutate(id = str_c(block3,
                    str_to_lower(officer),
                    year, sep="-")) %>%
  select(all_of(cols_sort))

# ==== write out for tidy ====
id_list <- sort(unique(df_matched$id))
i <- 1

for (i in 1:length(id_list)){
  names_file <- paste0(id_list[i],".xlsx" )
  path_file <- paste0(dir_tidy,names_file)

  df_matched %>%
    filter(id %in% id_list) %>%
    write.xlsx(., path_file)
  print(glue("write out file success: {names_file}"))

}

#====check for pivot wider ====
check <- df_matched %>%
  select(-id,  -block3, -chn_block4, -variables) %>%
  group_by(officer,year, index) %>%
  pivot_wider(names_from = block4, values_from = value
                  )
