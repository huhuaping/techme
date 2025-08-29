#' Agricultural Mechanization Services by Region
#'
#' This dataset contains comprehensive statistics on agricultural mechanization
#' services by region, including service organizations, personnel, investment,
#' and output. The data is extracted from the China Agricultural Machinery
#' Industry Yearbook, covering all provinces and regions in China.
#'
#' @format A data frame:
#' \describe{
#'   \item{province}{character. Province name, including national total.}
#'   \item{year}{character. Year of the statistics.}
#'   \item{chn_block4}{character. Service indicator in Chinese (e.g.,
#'     "Year-end Organizations", "Year-end Personnel", "Service Income").}
#'   \item{value}{numeric. The statistical value.}
#'   \item{units}{character. Units of measurement (e.g., "organizations",
#'     "persons", "10,000 yuan").}
#'   \item{variables}{character. Variable name in coded format.}
#' }
#'
#' @details
#' - The dataset covers agricultural mechanization services from 2010 to the
#'   latest available year.
#' - Service indicators include organization counts, personnel numbers,
#'   investment amounts, and service income.
#' - Data structure evolved over time: separate tables from 2010-2013,
#'   merged tables from 2014-2017, and fully integrated tables from 2018-2023.
#' - Data is in long format for easy analysis and visualization.
#'
#' @source China Agricultural Machinery Industry Yearbook,
#'   China Agricultural Machinery Industry Association
#'
#' @examples
#' # View the structure of the dataset
#' str(MachineService)
#' # Filter data for year-end organizations in 2023
#' MachineService[MachineService$year == "2023", ]
#'
"MachineService"
