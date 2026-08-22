#' Typical Cases of Full Mechanization for Specialty Economic Crops
#'
#' A data set containing typical cases of full-process mechanization for
#'   specialty economic crops (vegetables, fruit trees, tea, and medicinal
#'   herbs), compiled year by year from public notices of the Ministry of
#'   Agriculture and Rural Affairs
#'   \url{https://www.moa.gov.cn},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{ integer, the data year aligned with the source file }
#'   \item{batch}{ integer, the official batch number }
#'   \item{category}{ character, the crop group (vegetables, fruit trees, tea,
#'     or medicinal herbs) }
#'   \item{index}{ integer, the sequence number within the year and batch }
#'   \item{order}{ integer, the sequence number within the crop group }
#'   \item{title}{ character, the original case title in the public notice }
#'   \item{province}{ character, province names in reduced chinese }
#'   \item{place}{ character, city, county, or region parsed from the title }
#'   \item{crop}{ character, crop or variety parsed from the title }
#' }
#'
#' @examples
#' # load data set
#' techme::PubMachineCountyCase
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubMachineCountyCase"
