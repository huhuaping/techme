#' RD Expenditure by Funding Source by Region
#'
#' This dataset contains statistics on Research and Development (RD) internal
#' expenditure by funding source and region. The data is extracted from the
#' China Statistical Yearbook on Science and Technology, covering all provinces
#' and regions in China.
#'
#' @format A data frame:
#' \describe{
#'   \item{province}{character. Province name, including national total.}
#'   \item{year}{integer. Year of the statistics, starting from 2010.}
#'   \item{chn_block4}{character. Variable name in Chinese (e.g., "Total",
#'     "Government Funds", "Enterprise Funds", "Foreign Funds", "Other Funds").}
#'   \item{value}{numeric. The statistical value in 10,000 yuan.}
#'   \item{units}{character. Units of measurement (10,000 yuan).}
#'   \item{variables}{character. Variable name in coded format.}
#' }
#'
#' @details
#' - The dataset covers RD internal expenditure by funding source from 2010 to
#'   the latest available year.
#' - Funding sources include government funds, enterprise funds, foreign funds,
#'   and other funds.
#' - Data is in long format for easy analysis and visualization.
#' - Values are measured in 10,000 yuan (wan yuan).
#'
#' @source China Statistical Yearbook on Science and Technology,
#'   National Bureau of Statistics of China
#'
#' @examples
#' # View the structure of the dataset
#' str(RDSource)
#' # Filter data for government funds in 2023
#' RDSource[RDSource$year == 2023 & RDSource$chn_block4 == "Government Funds", ]
#'
"RDSource"
