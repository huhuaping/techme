#' Details of Checking result of National Agricultural Sci-tech Park
#'
#' A data set containing cheking result of National Agricultural Sci-tech Park
#'   year by year from the public
#'   site \url{https://www.most.gov.cn},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{ integer, year of document }
#'   \item{index}{ integer, the ordered index of list }
#'   \item{name}{ character, name of the agri park }
#'   \item{result}{ character, evaluation result marked in c('good','ok','fail') }
#'   \item{province}{character, province of agri park in reduced chinese}
#'   \item{doc_num}{ character,  officer document number }
#' }
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubAgriParkCheck"
