#' Details of Officer Livestock Breeding List from MOA (Xmj)
#'
#' **Deprecated.** Use [PubXmjBreeding] instead. This 2010–2020 snapshot
#' will be removed in a future release.
#'
#' A data set containing detail information of Officer Livestock Breeding List
#' from the public site MOA (Xmj) \url{http://www.moa.gov.cn},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer, year marked in the file name}
#'   \item{index}{character,  ordered index number }
#'   \item{province}{ character, province of origin institution  }
#'   \item{type}{character, livestock type }
#'   \item{name_origin}{ name of the origin institution }
#'   \item{name_change}{ name of the changed institution }
#'   \item{mark}{ character, marks to distinguish doc cat, such as 'cancel', 'change', ect. al }
#' }
#'
#' @details
#' Superseded by [PubXmjBreeding], which covers 2010 onward and adds
#' 核验通过 from 2021. Do not use this object in new code.
#'
#' @source \url{https://www.huhuaping.com/}
#'
"PubBreedingXmj"
