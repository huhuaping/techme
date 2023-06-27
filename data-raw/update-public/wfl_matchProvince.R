#' Match institution with its province with hack tianyan database
#'
#' @param df data.frame. must contain column named 'institution'
#' @param ptn_inst character. regexp pattern of column 'institution' which specify the splitting rules.
#'
#' @return data.frame
#' @export match_province
#'
#' @examples
#' check <- match_province(df = df_read, ptn_inst = '、')

match_province <- function(df, ptn_inst){
  require(techme)
  data("queryTianyan")
  dt_tianyan <- queryTianyan %>%
    select(name_origin, province) %>%
    rename(institution = "name_origin") %>%
    unique()

  data("ProvinceCity")
  dt_city <- ProvinceCity %>%
    select( city_clean, province_clean)

  ptn_province <- paste0(unique(ProvinceCity$province_clean),
                         collapse =  "|")
  ptn_city <- paste0(unique(ProvinceCity$city_clean),
                     collapse =  "|")

  dt_first <- df %>%
    #use only the first institution
    mutate(institution_first = map_chr(
      .x = institution,
      .f = function(x) as.character(
        unlist(str_split(x, pattern=ptn_inst))[[1]]) )
    )

  dt_out <- dt_first %>%
    left_join(., dt_tianyan,
              by= c("institution_first"="institution"),  ) %>%
    # filter obvious province info
    mutate(province_raw = str_extract(institution,
                                      ptn_province)) %>%
    mutate(province = ifelse(is.na(province),
                             province_raw, province)) %>%
    # match city
    mutate(city_clean = str_extract(institution, ptn_city)) %>%
    left_join(., dt_city, by= "city_clean" ) %>%
    mutate(province = ifelse(is.na(province),
                             province_clean,
                             province)) %>%
    select(-all_of(contains("_")))


  num_na <- sum(is.na(dt_out$province))

  if (num_na >0) {cat(
    paste0("warning! there are ",
           num_na,
           " institutions not matched! ",
           "\nplease querry them by hack tianyan firstly!")
    )}

  if (num_na ==0) {cat(
    paste0("congratulations! ",
           "\n",
           "All institutions are matched! ")
  )}

  if (nrow(df) !=nrow(dt_out)) {cat(
    paste0("warning! ",
           "\n before ", nrow(df)," and after ", nrow(dt_out),
           ",\n thus length of institutions matched not equal the same! ")
  )}

  return(dt_out)
}
