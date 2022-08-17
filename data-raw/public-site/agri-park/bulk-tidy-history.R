# not use! run only once!
# ==== prepare ====
## load pacakge

require(devtools)
load_all()

source("data-raw/set-global.R")

#require(techme)
data("PubAgriParkList")
data("PubAgriParkEval")
data("varsList")

#==== PubAgriParkList ====

df_out <- PubAgriParkList

dir_raw <- "data-raw/public-site/agri-park/xlsx/"
dir_tidy <- str_replace(dir_raw, "data-raw","data-raw/data-tidy")


# batch matched years
ptn_batch <- str_pad(1:9, 2, "left",0)
rpl_year <- c(2001, 2003, 2010,
              2011, 2013, 2015,
              2016,2018,2020)
# collapse columns
cols_id <- c( "year","officer","index")
officer_tar <- "MOST"
df_pivot <- df_out %>%
  mutate(year = mgsub::mgsub(batch,
                             ptn_batch, rpl_year),
         officer = officer_tar
         ) %>%
  pivot_longer(names_to = "block4",
               values_to = "value",
               -all_of(cols_id))

vars_spc <- techme::get_vars(df = varsList, lang = "eng",
                             block = list(block1 = "v99",block2 = "agripark",
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

# write out for tidy
id_list <- sort(unique(df_matched$id))
i <- 1

for (i in 1:length(id_list)){
  names_file <- paste0(id_list[i],".xlsx" )
  path_file <- paste0(dir_tidy,names_file)

  df_matched %>%
    filter(id %in% id_list[i]) %>%
    write.xlsx(., path_file)
  print(glue("write out file success: {names_file}"))

}


#==== PubAgriParkEval ====

df_out <- PubAgriParkEval

dir_raw <- "data-raw/public-site/agri-park/xlsx/"
dir_tidy <- str_replace(dir_raw, "data-raw","data-raw/data-tidy")


# collapse columns
cols_id <- c( "year","officer","index")
officer_tar <- "MOST"
df_pivot <- df_out %>%
  mutate(officer = officer_tar) %>%
  pivot_longer(names_to = "block4",
               values_to = "value",
               -all_of(cols_id))

vars_spc <- techme::get_vars(df = varsList, lang = "eng",
                             block = list(block1 = "v99",block2 = "agripark",
                                          block3 = c("eval")
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

# write out for tidy
id_list <- sort(unique(df_matched$id))
i <- 1

for (i in 1:length(id_list)){
  names_file <- paste0(id_list[i],".xlsx" )
  path_file <- paste0(dir_tidy,names_file)

  df_matched %>%
    filter(id %in% id_list[i]) %>%
    write.xlsx(., path_file)
  print(glue("write out file success: {names_file}"))

}

#====check for pivot wider ====
check <- df_matched %>%
  select(-id,  -block3, -chn_block4, -variables) %>%
  group_by(officer,year, index) %>%
  pivot_wider(names_from = block4, values_from = value
                  )
