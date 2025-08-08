#' RD Personnel Full-time Equivalent by Region
#'
#' This dataset contains statistics on Research and Development (RD) personnel
#' full-time equivalent by region, measured in person-years. The data is
#' extracted from the China Statistical Yearbook on Science and Technology,
#' covering all provinces and regions in China.
#'
#' @format A data frame:
#' \describe{
#'   \item{province}{character. Province name, including national total.}
#'   \item{year}{integer. Year of the statistics, starting from 2010.}
#'   \item{chn_block4}{character. Variable name in Chinese.}
#'   \item{value}{numeric. The statistical value.}
#'   \item{units}{character. Units of measurement (person-years).}
#'   \item{variables}{character. Variable name in coded format.}
#' }
#'
#' @details
#' - The dataset covers RD personnel full-time equivalent statistics by region
#'   from 2010 to the latest available year.
#' - Data is in long format for easy analysis and visualization.
#' - Full-time equivalent is measured in person-years, representing the
#'   equivalent of one person working full-time for one year.
#'
#' @source China Statistical Yearbook on Science and Technology,
#'   National Bureau of Statistics of China
#'
#' @examples
#' # View the structure of the dataset
#' str(RDLaborHour)
#' # Filter data for a specific year
#' RDLaborHour[RDLaborHour$year == 2020, ]
#'
"RDLaborHour"
