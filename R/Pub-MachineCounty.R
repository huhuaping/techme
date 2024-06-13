#' Details of Approved List of Agricultural Machinery Demonstration County
#'
#' A data set containing Approved List of Agricultural Machinery Demonstration County
#'   year by year from the public
#'   site \url{https://www.moa.gov.cn},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{ integer, the year of official document published }
#'   \item{batch}{character, the official approved batch record in chinese}
#'   \item{id}{ integer, the category ID, while <665 means "crops", 666 means "livestock", 777 means "facility planting" }
#'   \item{index}{ number, the ordered index number }
#'   \item{province}{ character, province names in reduced chinese }
#'   \item{county}{ character, county names in reduced chinese  }
#' }
#'
#' @examples
#' # load data set
#' techme::PubMachineCounty
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubMachineCounty"
