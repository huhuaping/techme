#' MOA Agricultural Modernization Demonstration Zones (农业现代化示范区)
#'
#' Official lists of counties (cities, districts) designated to create
#' national agricultural modernization demonstration zones, compiled from
#' public notices of the Ministry of Agriculture and Rural Affairs (MOA).
#' Each row is one named unit in a given notice year.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer. Official notice / designation year.}
#'   \item{index}{integer. Sequence number within that year's list.}
#'   \item{name}{character. County (city, district) name as printed.}
#'   \item{province}{character. Province name in reduced Chinese.}
#' }
#'
#' @details
#' Coverage currently collected:
#'
#' * 2021 first batch (农规发〔2021〕14号).
#' * 2022 second batch.
#' * 2023 (农规发〔2023〕13号).
#' * 2026 proposed list (公示拟批准创建名单). 2024 and 2025 notices have
#'   not been published.
#'
#' HTML notices are parsed by `code-moa-agrimodern-zone.R`. Package data
#' are written by `wfl-PubAgrimodernZone.R` from
#' `data-raw/data-tidy/public-site/moa-agrimodern-zone/xlsx/`.
#'
#' @source Ministry of Agriculture and Rural Affairs of China,
#'   Development Planning Department,
#'   \url{https://www.moa.gov.cn}.
#'
#' @examples
#' str(PubAgrimodernZone)
#' table(PubAgrimodernZone$year)
#'
"PubAgrimodernZone"
