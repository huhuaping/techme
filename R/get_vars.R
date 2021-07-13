
#' Get names from basic variables table
#'
#' @param df data frame
#' @param lang characer. Which is the language of variables selected, default "eng",
#'   other options is "chn".
#' @param block list. The list must be length 4, with its names following: "block1","block2",
#'   "block3", "block4".
#' @param what character. The options are including: "variables"(default),"short_chn",
#'   "short_eng"
#'
#' @return list
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @import dplyr
#'
#' @export get_vars
#'
#' @examples
#' options(encoding = "UTF-8")
#' block_sel <- list(block1 ="v7",
#' block2="sctj",
#' block3 ="nyjx",
#' block4= c("zdl","dztlj","xtlj",
#' "dztlj_pt","xtlj_pt",
#' "pgddj","pgcyj"))
#'
#' vars_set <-  get_vars(df = varsList, block = block_sel, what = "variables")
#'
get_vars <- function(df, lang="eng", block, what = "variables"){
  if (lang =="chn") {
    if (!is.null(block$block1)){
      df <-  df %>% filter(.data$chn_block1 %in% block$block1)
    }

    if (!is.null(block$block2)){
      df <- df %>% filter(.data$chn_block2 %in% block$block2)
    }

    if (!is.null(block$block3)){
      df <- df %>% filter(.data$chn_block3 %in% block$block3)
    }

    if (!is.null(block$block4)){
      df <- df %>% filter(.data$chn_block4 %in% block$block4)
    }

  } else if (lang =="eng"){
    if (!is.null(block$block1)){
      df <-  df %>% filter(.data$block1 %in% block$block1)
    }

    if (!is.null(block$block2)){
      df <- df %>% filter(.data$block2 %in% block$block2)
    }

    if (!is.null(block$block3)){
      df <- df %>% filter(.data$block3 %in% block$block3)
    }

    if (!is.null(block$block4)){
      df <- df %>% filter(.data$block4 %in% block$block4)
    }
  }

  vars <-  df %>%
    dplyr::select(one_of(what)) #%>%
    #unlist()
  return(vars)
}

