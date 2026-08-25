#' Livestock Standardized Demonstration Farms (畜禽养殖标准化示范场)
#'
#' Official lists of livestock standardized demonstration farms designated by
#' the Ministry of Agriculture and Rural Affairs (MOA). Each row is one named
#' farm in a given notice year. Only designation lists are included;
#' re-inspection (复验) lists are not.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{character. Business year of the notice (not the gazette year).}
#'   \item{index}{character. Sequence number within the annual designation table.}
#'   \item{area_name}{character. Province name as printed (short form, e.g.
#'     天津, 内蒙古). 新疆生产建设兵团 is recoded to 新疆.}
#'   \item{prod_name}{character. Livestock type as printed; not rewritten to
#'     historical aliases.}
#'   \item{com_name}{character. Farm or enterprise name as printed.}
#' }
#'
#' @details
#' Coverage starts in 2010. There is no 2012 gazette in the source files.
#' Years 2010–2020 were tidied from HTML/Word/Excel notices; years 2021–2023
#' are expanded from YAML intermediates
#' (`data-raw/public-site/moa-xmj-standard/yaml/`) by
#' `code-scrape-standard.R`. Package data are written by
#' `wfl-PubXmjStandard.R`. This is the current dataset. The 2010–2020
#' snapshot [PubStandardXmj] is deprecated and will be removed later.
#'
#' @source Ministry of Agriculture and Rural Affairs of China, Animal Husbandry
#'   and Veterinary Bureau notices,
#'   \url{https://www.moa.gov.cn}.
#'
#' @examples
#' str(PubXmjStandard)
#'
"PubXmjStandard"
