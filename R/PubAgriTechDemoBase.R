#' MOA Agricultural Sci-tech Demonstration Bases (农业科技试验示范基地)
#'
#' Official lists of agricultural sci-tech demonstration bases designated
#' by the Ministry of Agriculture and Rural Affairs (MOA). Each row is one
#' named base in a given notice year. Two statistical calibers share the
#' same columns and are distinguished by `source`.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer. Official notice year.}
#'   \item{index}{integer. Sequence number within that year's annex
#'     (2025 types are numbered from 1 within each type).}
#'   \item{source}{character. Controlled vocabulary: 现代农业科技试验示范基地,
#'     国家农业科技示范展示基地, or (reserved) 国家农业科技创新与集成示范基地.}
#'   \item{type}{character. Industry class for the current caliber:
#'     种植业, 畜牧兽医, 渔业, 农机, or 资源环境. Missing for the 2020
#'     historical list.}
#'   \item{name}{character. Base name as printed.}
#'   \item{institution}{character. Lead / operating institution
#'     (牵头单位 in 2025; 建设运营单位 in 2020).}
#'   \item{province}{character. Province name in reduced Chinese.
#'     新疆生产建设兵团 is recoded to 新疆.}
#' }
#'
#' @details
#' Coverage is the two notices currently collected:
#'
#' * 2025 current caliber (农科办〔2025〕16号): 现代农业科技试验示范基地,
#'   first batch, with `type` filled.
#' * 2020 historical caliber (农办科〔2020〕6号): 国家农业科技示范展示基地,
#'   with `type` missing. From the 2025 notice onward this title is no
#'   longer retained.
#'
#' Intermediate YAML lives in
#' `data-raw/public-site/moa-agritech-demo-base/yaml/` and is expanded by
#' `code-moa-agritech-demo-base-yaml.R`. Package data are written by
#' `wfl-PubAgriTechDemoBase.R`. Joint units (`partners`) in the 2025
#' notice are not kept in the tidy table.
#'
#' @source Ministry of Agriculture and Rural Affairs of China notices,
#'   \url{https://www.moa.gov.cn}.
#'
#' @examples
#' str(PubAgriTechDemoBase)
#' table(PubAgriTechDemoBase$year, PubAgriTechDemoBase$source)
#'
"PubAgriTechDemoBase"
