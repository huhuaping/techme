#' Data Set of Hi-tech Firms Numbers on Public Site
#'
#' A data set Hi-tech Firms Numbers scraped from Public Site \url{http://www.innocom.gov.cn/},
#'   with wide data format. The origin scraping script file in
#'   "tech-report/data-raw/public-site/torch-innocom/scrap-innocom.Rmd".
#'
#' @format A data frame:
#' \describe{
#'   \item{index}{index, sorting ID}
#'   \item{year}{year, begin with year 2018}
#'   \item{province}{provinces, in chinese}
#'   \item{num}{numbers of firms}
#' }
#'
#' @source \url{https://www.huhuaping.com/}
#'

"HitechFirmsPub"
