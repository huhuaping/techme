#' Data Set of Institution Query from Tianyan Site
#'
#' A data set containing basic info of institution including address, telephone,
#'  url,
#'   repository 'wecatch/china_regions'\url{https://github.com/wecatch/china_regions},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{index}{ ordered index }
#'   \item{name_origin}{ origin name of institution }
#'   \item{name_search}{ searched name of institution  }
#'   \item{address}{ searched address of institution  }
#'   \item{tel}{ searched telephone of institution  }
#'   \item{url}{ searched website url of institution  }
#'   \item{city}{ matched city of institution  }
#'   \item{province_raw}{ matched province of institution }
#'   \item{province}{ final province of institution }
#' }
#'
#' @source \url{https://www.huhuaping.com/}
#'

"queryTianyan"


