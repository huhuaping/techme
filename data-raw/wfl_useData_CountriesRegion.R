## code to prepare `CountriesRegion` dataset goes here

source("data-raw/set-global.R")

# ====read data iso-3166 from github====
## raw url "https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/blob/master/all/all.csv"
file_path_iso <- "data-raw/public-site/ISO-country/csv/iso-country-all.csv"

iso_country <- read_delim(file_path_iso,
                          delim = ",") %>%
  as_tibble() %>%
  janitor::clean_names(., "lower_camel")

# ====read data UNSD-m49=====
## raw url "https://unstats.un.org/unsd/methodology/m49/overview/"

file_path_unsd <- "data-raw/public-site/UN-m49/xlsx/UNSD-M49-chn.xlsx"
un_m49 <- openxlsx::read.xlsx(file_path_unsd,
                              sheet = 1,
                              check.names = T)

## clear column names
col_list <- c("region_name","sub_region_name",
              "intermediate_region_name","country_or_area",
              "m49_code","iso_alpha2_code", "iso_alpha3_code",
              "least_developed_countries_ldc",
              "land_locked_developing_countries_lldc",
              "small_island_developing_states_sids",
              "developed_developing_countries")

un_m49_tidy <- un_m49  %>%
  as_tibble() %>%
  janitor::clean_names() %>%
  # padding m4p_code
  mutate(
    m49_code = str_pad(m49_code,
                       side = "left",
                       pad = "0",
                       width = 3)
  ) %>%
  select(all_of(col_list))

#====中英文国别信息对应====

country_region <- left_join(
  iso_country, un_m49_tidy,
  by = c("countryCode" = "m49_code")
)

out_path <- "data-raw/public-site/ISO-country/xlsx/country-region.xlsx"
write.xlsx(country_region, file = out_path)


# ====add the alias for countries====

## check and add the alias for countries by hand
## then read the xlsx files

xlsx_path <- "data-raw/public-site/ISO-country/xlsx/country-region-check-byhand.xlsx"

tbl_byhand <- read.xlsx(xlsx_path, sheet = 1)


# ====write out====
BasicCountriesRegion <- tbl_byhand
usethis::use_data(BasicCountriesRegion, overwrite = TRUE)

# write document
require(devtools)
load_all()
use_r("BasicCountriesRegion")
document_dt(BasicCountriesRegion)
document()


