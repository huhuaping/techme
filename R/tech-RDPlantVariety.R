#' Plant Variety Rights by Region
#'
#' This dataset contains statistics on agricultural plant variety rights
#' applications and grants by region. The data is extracted from the China
#' Statistical Yearbook on Science and Technology, covering all provinces and
#' regions in China.
#'
#' @format A data frame:
#' \describe{
#'   \item{province}{character. Province name, including national total.}
#'   \item{year}{character. Year of the statistics.}
#'   \item{chn_block4}{character. Type of plant variety right in Chinese
#'     (e.g., "Application", "Grant").}
#'   \item{value}{numeric. Number of plant variety rights.}
#'   \item{units}{character. Units of measurement (pieces/cases).}
#'   \item{variables}{character. Variable name in coded format.}
#' }
#'
#' @details
#' - The dataset covers agricultural plant variety rights applications and
#'   grants by region from 2010 to the latest available year.
#' - Plant variety rights include both applications and granted rights for
#'   new agricultural plant varieties.
#' - Data is in long format for easy analysis and visualization.
#' - Values represent the number of plant variety rights applications or grants.
#' - Year 2019 is not available due to the data missing in the Year Book.
#'
#' @source China Statistical Yearbook on Science and Technology,
#'   National Bureau of Statistics of China
#'
#' @examples
#' # View the structure of the dataset
#' str(RDPlantVariety)
#' # Filter data for applications in 2023
#' RDPlantVariety[RDPlantVariety$year == "2023" &
#'     RDPlantVariety$chn_block4 == "Application", ]
#'
"RDPlantVariety"
