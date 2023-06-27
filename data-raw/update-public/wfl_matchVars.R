## code to prepare `wfl_matchvars` dataset goes here

library(purrr)
library(magrittr)
#install.packages("stringdist")
require(stringdist)

#' Helper function to get the best matched of specified character vectors.
#'
#' @param word
#' @param charvec
#'
#' @return list
#' @export get_best_match
#'
#' @examples

get_best_match <- function(word, charvec ){
  max_index <- which.max(stringdist::stringsim(word, charvec,
                                               method = "jw"))
  return(charvec[max_index])
}



#' Match 'vars' to target variables list in chenese.
#'
#' @param dt data.frame
#' @param block_target list. Names of the list should be part or all of : block1, block2, block3,block4.
#' @param block_lang character. Specify which language to use, either 'eng'(default) or 'chn'
#'
#' @return data.frame
#' @export matchVars
#'
#' @examples
#' #target <- list(block1 ="农村统计年鉴", block2="生产条件",block3 ="农业机械")
#' target <- list(block1 ="v7", block2="sctj",block3 ="nyjx")
#'
#' df_vars_matched <- matchVars(dt = df_long, block_target = target)
#' openxlsx::write.xlsx(df_vars_matched, "data-raw/df-vars-matched.xlsx")
#'
matchVars <- function(dt, block_target = target, block_lang="eng"){
  input <- unique(dt$block4)
  require(techme)
  data("varsList")
  vars_tbl <- get_vars(varsList,lang = block_lang,
                       block = block_target,
                       what = c("variables","block3",
                                "block4","chn_block4"))
  vec <- vars_tbl$block4
  vector_results <- map_chr(input, ~ get_best_match(.x, charvec = vec))
  #vector_results <- sapply(input, function(word) get_best_match(word, charvec = vec))

  vars_matched <- tibble(input = input,target = vector_results) %>%
    mutate(asis = ifelse(input==target, T, F)) %>%
    rename( block4 = "target") %>%
    left_join(., vars_tbl, by = "block4")
  msg_warning <- glue::glue("Varible(s) are not the same. please check variables in rows: \n
             {paste0(vars_matched$input[which(!vars_matched$asis)], collapse ='; ')}")
  if (any(!vars_matched$asis)) warning(msg_warning)
  if (any(is.na(vars_matched$chn_block4))) stop("error: raw variables not contained in target variable table.")

  return(vars_matched)

}


#usethis::use_data(vars_matched, overwrite = TRUE, internal = T)
