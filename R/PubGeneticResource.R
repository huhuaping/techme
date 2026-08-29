#' National Genetic Resource Bases (国家级种质资源库)
#'
#' Official batch lists of national crop / agricultural-microbe germplasm
#' banks and national livestock genetic-resource conservation units,
#' compiled from public notices of the Ministry of Agriculture and Rural
#' Affairs (MOA). Each row is one named unit in a given notice year and
#' batch. The two source families share the same columns and are
#' distinguished by `type`.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer. Official notice / designation year.}
#'   \item{batch}{character. Two-digit batch number within that source
#'     family (crop batches and livestock batches are numbered separately).}
#'   \item{type}{character. Controlled vocabulary combining both source
#'     families. Crop / microbe: 农作物, 农业微生物. Livestock: 畜禽保种场,
#'     畜禽基因库, 畜禽保护区, 畜禽变更.}
#'   \item{index}{integer. Sequence number within the source table.}
#'   \item{name}{character. Unit name as printed.}
#'   \item{institution}{character. Supporting / construction institution;
#'     for 畜禽变更, the new institution.}
#'   \item{province}{character. Province name in reduced Chinese.}
#' }
#'
#' @details
#' Two statistical calibers share this object:
#'
#' * Crop and agricultural-microbe banks (from 2022): `type` is 农作物 or
#'   农业微生物. Tidied from year-batch notices by
#'   `code-moa-genetic-resource.R`.
#' * Livestock conservation units (from 2021; earlier seven batches
#'   repealed): `type` is 畜禽保种场, 畜禽基因库, 畜禽保护区, or 畜禽变更.
#'   Years 2021–2023 are expanded from YAML
#'   (`data-raw/public-site/moa-genetic-resource/yaml/`) by
#'   `code-moa-genetic-resource-yaml.R`; from 2024 the livestock annexes
#'   are published with the crop notices.
#'
#' Package data are written by `wfl-PubGeneticResource.R`. The full
#' crop-bank snapshot [PubGeneticResourceCrop] is a different caliber
#' (platform list, not year-batch notices).
#'
#' @source Ministry of Agriculture and Rural Affairs of China notices,
#'   \url{https://www.moa.gov.cn}; crop-bank downloads also appear at
#'   \url{https://ncgrip.cgris.net}.
#'
#' @examples
#' str(PubGeneticResource)
#' table(PubGeneticResource$type)
#'
"PubGeneticResource"
