#' Details of National Key R&D Plans(NKRDP)
#'
#' A data set containing NKRDP from the public
#'   site \url{https://www.sciping.com/keyproject.html#},
#'   with wide data format.
#'
#' @format A data frame:
#' \describe{
#'   \item{year}{year marked in the file name}
#'   \item{date}{date of the data deadline which the web page declaimed }
#'   \item{NO}{the Number of the NKRDP }
#'   \item{index}{index in the table of web page}
#'   \item{title}{title of the NKRDP}
#'   \item{institution}{executive agency of the NKRDP}
#'   \item{chairman}{chairman of the NKRDP}
#'   \item{funds}{offered funds to the NKRDP}
#'   \item{type}{type of the NKRDP}
#'   \item{duration}{years duration of the NKRDP}
#'   \item{NO_head}{decomposed Number of the NKRDP,
#'        'head part', usually "NA" }
#'   \item{NO_year}{decomposed Number of the NKRDP, 'year' part}
#'   \item{NO_mark}{decomposed Number of the NKRDP, 'mark' part with format 'YFD' ect.}
#'   \item{NO_num}{decomposed Number of the NKRDP, 'num' part with digits 7 or 8}
#'   \item{NO_num_p1}{decomposed Number of the NKRDP, 'num_p1' part with digits 2}
#'   \item{NO_num_p2}{decomposed Number of the NKRDP, 'num_p2' part with digits 5 or 6}
#'   \item{NO_tail}{decomposed Number of the NKRDP, 'tail' part which usually "NA" or '*'}
#' }
#'
#' @source \url{https://www.huhuaping.com/}
#'

"PubNKRDP"
