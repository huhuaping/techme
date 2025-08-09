#' Domestic Patent Applications Accepted by Region
#'
#' This dataset contains statistics on domestic patent applications accepted
#' by region, including three types of patents: inventions, utility models,
#' and designs. The data is extracted from the China Statistical Yearbook on
#' Science and Technology, covering all provinces and regions in China.
#'
#' @format A data frame:
#' \describe{
#'   \item{province}{character. Province name, including national total.}
#'   \item{year}{character. Year of the statistics.}
#'   \item{chn_block4}{character. Patent type in Chinese (e.g., "Total",
#'     "Invention", "Utility Model", "Design").}
#'   \item{value}{numeric. Number of patent applications accepted.}
#'   \item{units}{character. Units of measurement (pieces/cases).}
#'   \item{variables}{character. Variable name in coded format.}
#' }
#'
#' @details
#' - The dataset covers domestic patent applications accepted by region from
#'   2010 to the latest available year.
#' - Patent types include invention patents, utility model patents, and design
#'   patents.
#' - Data is in long format for easy analysis and visualization.
#' - Values represent the number of patent applications accepted.
#'
#' @source China Statistical Yearbook on Science and Technology,
#'   National Bureau of Statistics of China
#'
#' @examples
#' # View the structure of the dataset
#' str(RDPatentAccept)
#' # Filter data for invention patents in 2023
#' RDPatentAccept[RDPatentAccept$year == "2023" & 
#'                RDPatentAccept$chn_block4 == "Invention", ]
#'
"RDPatentAccept"
