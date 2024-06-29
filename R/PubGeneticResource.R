#' Details of Approved List of National Genetic Resource Base
#'
#' A data set containing Approved List of National Genetic Resource Base
#'   year by year from the "moa-genetic-resource" project
#'   which public at \url{https://www.moa.gov.cn},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer, the official approved year }
#'   \item{batch}{character, the batch NO.}
#'   \item{type}{character, type of the base  }
#'   \item{index}{integer, the ordered index of list}
#'   \item{name}{character, name of the base }
#'   \item{institution}{character, name of the on duty institution}
#'   \item{province}{character, province of approved county in reduced chinese}
#' }
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubGeneticResource"
