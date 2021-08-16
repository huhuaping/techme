
#' Help Document the Variables List of Data Set for Package Development
#'
#' @param df a data frame
#'
#' @export document_dt
#'
#' @examples
#' data(ProvinceCity)
#' document_dt(ProvinceCity)
#'
#'
document_dt <- function(df){
  cat(paste0("#'   \\item{",names(df),"}{  }"), sep="\n")
}

