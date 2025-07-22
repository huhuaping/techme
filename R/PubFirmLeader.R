#' National Key Leading Enterprises in Agricultural Industrialization
#'
#' A unified dataset containing the official lists of National Key Leading
#' Enterprises in Agricultural Industrialization, as published by the Ministry
#' of Agriculture and Rural Affairs of China. The dataset covers all batches,
#' annual updates, and monitoring-qualified enterprises, with standardized
#' enterprise names and province information for cross-year and cross-batch
#' analysis.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer. The year of official announcement or approval.}
#'   \item{batch}{integer. The batch number or monitoring round. `99` means the
#'     full listing from the yearly update webpage. other numbers means the
#'     batch number.}
#'   \item{index}{integer. The ordered index within the list.}
#'   \item{name}{character. The name of the enterprise.}
#'   \item{province}{character. The province where the enterprise is located
#'     (in simplified Chinese.}
#' }
#'
#' @details
#' - The dataset includes all available batches and annual updates of the
#'   National Key Leading Enterprises in Agricultural Industrialization from
#'   2000 to present.
#' - Enterprise names and province information have been standardized for
#'   consistency.
#' - Data collection and processing details can be found in the package
#'   vignette and data-raw scripts.
#'
#' @source Ministry of Agriculture and Rural Affairs of China, Department of
#'   Rural Industry Development (http://www.xccys.moa.gov.cn/) and official
#'   public notices.
#'
#' @examples
#' # View the structure of the dataset
#' str(PubFirmLeader)
#' # Count the number of enterprises by province
#' table(PubFirmLeader$province)
#'
"PubFirmLeader"
