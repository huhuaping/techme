#' Details of Evaluation Results for Major Scientific Infrastructure and
#' Large-scale Scientific Instruments Sharing
#'
#' A data set containing the evaluation results of the openness and sharing of
#' major scientific infrastructure and large-scale scientific instruments by
#' central universities and research institutes, as published by the Ministry of
#' Science and Technology of China (MOST). The data is collected year by year
#' from official public notices and processed into a unified wide-format data
#' frame.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer, the year of the evaluation or public notice}
#'   \item{index}{integer, the ordered index of the institution in the list}
#'   \item{institution}{character, name of the evaluated institution (may contain
#'     multiple institutions separated by comma)}
#'   \item{result}{character, evaluation result, e.g., "excellent", "good",
#'     "qualified", "poor"}
#'   \item{administrator}{character, name of the administrator for the institution
#'     (may be empty for some years)}
#'   \item{province}{character, matched province of the institution in reduced
#'     Chinese}
#' }
#'
#' @source Ministry of Science and Technology of China (MOST),
#'   https://www.most.gov.cn/
#'
"PubOpenShare"
