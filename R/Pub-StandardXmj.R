#' Details of Officer Livestock Standard List from MOA (Xmj)
#'
#' **Deprecated.** Use [PubXmjStandard] instead. This 2010–2020 snapshot
#' will be removed in a future release.
#'
#' A data set containing detail information of Officer Livestock Standard List
#' from the public site MOA (Xmj) \url{http://www.moa.gov.cn},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{integer, year marked in the file name}
#'   \item{index}{character,  ordered index number }
#'   \item{province}{ character, province of origin institution  }
#'   \item{prod_name}{character, livestock type }
#'   \item{com_name}{ name of the company }
#'   }
#'
#' @details
#' Superseded by [PubXmjStandard], which covers 2010 onward (no 2012 gazette)
#' and keeps `area_name` as printed. Do not use this object in new code.
#'
#' @source \url{https://www.huhuaping.com/}
#'
"PubStandardXmj"
