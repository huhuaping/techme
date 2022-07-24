#' Details list of Observe Stations from departments( MOA/MOE/MOST)
#'
#' A data set containing list of Observe Stations of Ministry of Agriculture(MOA)
#'   and Ministry of Education (MOE)
#'   year by year from the public
#'   MOA site \url{http://www.moa.gov.cn/} and
#'   MOE site \url{http://www.moe.gov.cn/} ,
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{id}{ character, paste0 from block3/officer/year}
#'   \item{year}{ integer, year of the document from Ministry site }
#'   \item{officer}{ name of Ministry, MOA/MOE/MOST }
#'   \item{index}{ integer, the ordered index of list }
#'   \item{block3}{ character, variable name from block3 }
#'   \item{block4}{ character, variable name from block4,
#'         such as `name`,`institution`,`administrator`,`province`}
#'   \item{chn_block4}{ character, Chinese name from block4 }
#'   \item{value}{character, value obervered for variables from block4}
#'
#'   \item{variables}{ character, unique variable name coded}
#' }
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubObsStationX"
