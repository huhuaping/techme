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
#'   \item{researcher_inst}{character, institution of the esearcher}
#'   \item{province_industry}{ matched province of the chairman for certain industry }
#'   \item{province_func}{ matched province of the director for certain functional research area }
#'   \item{province_researcher}{ matched province of the researcher}
#' }
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubCars"
