#' MOA Designated Wholesale Markets (农业农村部定点市场)
#'
#' Official lists of wholesale markets designated by the Ministry of
#' Agriculture and Rural Affairs (MOA), and markets whose designation
#' was withdrawn. Each row is one named market in a given notice year.
#' The two annexes share the same columns and are distinguished by `type`.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer. Official notice year.}
#'   \item{type}{character. Controlled vocabulary: 认定名单 or 取消名单.}
#'   \item{province}{character. Province name in reduced Chinese.
#'     新疆生产建设兵团 is recoded to 新疆.}
#'   \item{index}{integer. Sequence number within that year's annex.}
#'   \item{name}{character. Market name as printed.}
#' }
#'
#' @details
#' Coverage is the two published review notices currently collected:
#' 2018 (农市发〔2018〕6号) and 2024 (农市发〔2024〕2号). Intermediate
#' YAML lives in `data-raw/public-site/moa-agri-market/yaml/` and is
#' expanded by `code-moa-agri-market-yaml.R`. Package data are written
#' by `wfl-PubAgriMarket.R`.
#'
#' @source Ministry of Agriculture and Rural Affairs of China notices,
#'   \url{https://www.moa.gov.cn}.
#'
#' @examples
#' str(PubAgriMarket)
#' table(PubAgriMarket$year, PubAgriMarket$type)
#'
"PubAgriMarket"
