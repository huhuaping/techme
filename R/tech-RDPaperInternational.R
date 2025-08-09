#' International Scientific Papers by Region
#'
#' This dataset contains statistics on Chinese scientific papers indexed by
#' major international databases (such as SCI) by region. The data is extracted
#' from the China Statistical Yearbook on Science and Technology, covering all
#' provinces and regions in China.
#'
#' @format A data frame:
#' \describe{
#'   \item{province}{character. Province name, including national total.}
#'   \item{year}{character. Year of the statistics.}
#'   \item{chn_block4}{character. Type of international index in Chinese
#'     (e.g., "SCI Papers").}
#'   \item{value}{numeric. Number of papers indexed.}
#'   \item{units}{character. Units of measurement (papers/articles).}
#'   \item{variables}{character. Variable name in coded format.}
#' }
#'
#' @details
#' - The dataset covers Chinese scientific papers indexed by major international
#'   databases by region from 2010 to the latest available year.
#' - Main international databases include SCI (Science Citation Index) and
#'   other major indexing tools.
#' - Data is in long format for easy analysis and visualization.
#' - Values represent the number of papers indexed by international databases.
#'
#' @source China Statistical Yearbook on Science and Technology,
#'   National Bureau of Statistics of China
#'
#' @examples
#' # View the structure of the dataset
#' str(RDPaperInternational)
#' # Filter data for SCI papers in 2022
#' RDPaperInternational[RDPaperInternational$year == "2022" & 
#'                      grepl("SCI", RDPaperInternational$chn_block4), ]
#'
"RDPaperInternational"
