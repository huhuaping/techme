#' Details Data Frame of China Agricultural Research System (CARS)
#'
#' A data set containing detail informations of China Agricultural Research System (CARS)
#' from the public site MOA \url{http://www.moa.gov.cn},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{character, year marked in the file name}
#'   \item{index}{character,  ordered index number }
#'   \item{area_num_eng}{character, encoding of Agri-product  industry with digits 2  }
#'   \item{area_name}{character,   name of Agri-product industry}
#'   \item{chairman_industry}{character, chairman of the industry  }
#'   \item{institution_industry}{character, institution of the chairman for certain industry  }
#'   \item{func_num}{character, encoding of functional research area with digits 2 }
#'   \item{func_name}{character,  name of functional research area}
#'   \item{func_inst}{character, institution of the director in  functional research area }
#'   \item{func_director}{character, name of director in  functional research area  }
#'   \item{researcher_area}{character, detail research direction witin functional research area }
#'   \item{researcher_name}{character,  name of researcher}
#'   \item{researcher_inst}{character, institution of the researcher}
#'   \item{province_industry}{character, matched province of the industry chairman institution}
#'   \item{province_func}{character, matched province of the functional-area director institution}
#'   \item{province_researcher}{character, matched province of the researcher institution}
#' }
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubCars"
