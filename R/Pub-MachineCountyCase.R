#' Details of Typical Cases of Full Mechanization for Specialty Crops
#'
#' A data set containing typical cases of full-process mechanization for
#'   specialty economic crops (vegetables, fruits, tea, and Chinese medicinal
#'   herbs), compiled year by year from public notices of the Ministry of
#'   Agriculture and Rural Affairs
#'   \url{https://www.moa.gov.cn}.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer. Data year aligned with the source yaml filename.}
#'   \item{batch}{integer. Official batch number (1 = first batch).}
#'   \item{category}{character. Crop group: 蔬菜, 林果, 茶叶, or 中药材.}
#'   \item{index}{integer. Sequence number within the year/batch.}
#'   \item{order}{integer. Sequence number within the category.}
#'   \item{title}{character. Original case title in the public notice.}
#'   \item{province}{character. Province name in reduced Chinese; `NA` if absent.}
#'   \item{place}{character. City, county, or region parsed from the title; `NA` if absent.}
#'   \item{crop}{character. Crop or variety parsed from the title; `NA` if absent.}
#' }
#'
#' @examples
#' # load data set
#' techme::PubMachineCountyCase
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubMachineCountyCase"
