#' Add success footer information item to item for the figure or table
#'
#' This function should be in the code chunk (always follow the code of plot or kable)
#'   and without setting "result= 'asis'".
#'
#' @param text character, information text.
#' @param type character, is one of c('note', 'source') and default 'note'
#'
#' @return invisible
#' @export add_footer_pure
#'
#' @examples
#' cap_note <- "This is a note, ba la ba la"
#' cap_source <- "source from yearbook 2021"
#' \dontrun{
#'  add_footer_pure(cap_note)
#'  cat("\n")
#'  add_footer_pure(cap_source, type = "source")
#' }
#'
add_footer_pure <- function(text, type = "note") {
  if (type == "note" & !is.null(text)) cat(paste0("**", "\u6ce8", "**\uff1a", text), sep = "")
  if (type == "note" & is.null(text)) stop("You should set the 'source' at least!")
  if (type == "source") cat(paste0("**", "\u8d44\u6599\u6765\u6e90", "**\uff1a", text), sep = "")
  if (type == "source" & is.null(text)) stop("You should set the 'source' at least!")
}

#' Add success footer information as whole part for the figure or table
#'
#' This function should be in the dependent code chunk (outside the code chunk of plot or kable)
#'   and must set the chunk options "result= 'asis'".
#'
#' @param note character, note text for figure or table.
#' @param source character, source text for figure or table.
#' @param pre_note character, prefix for note with default value.
#'
#' @importFrom stringr str_c
#'
#' @return invisible
#' @export add_footer_asis
#'
#' @examples
#'
#' cap_note <- "This is a note, ba la ba la"
#' cap_source <- "source from yearbook 2021"
#' \dontrun{
#'  add_footer_asis(cap_note, cap_source)
#' }
#'
add_footer_asis <- function(note, source, pre_note = "\u6ce8") {
  out <- stringr::str_c(
    if (!is.null(note)) stringr::str_c("**", pre_note, "**\uff1a", note),
    if (!is.null(note)) stringr::str_c("\n\n"),
    if (!is.null(note)) stringr::str_c("\\newline"),
    if (!is.null(note)) stringr::str_c("\n\n"),
    if (!is.null(source)) stringr::str_c("**\u8d44\u6599\u6765\u6e90**\uff1a", source)
  )

  cat(out, sep = "\n")
}