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
  has_txt <- function(x) {
    !is.null(x) && length(x) >= 1L &&
      nzchar(trimws(paste(as.character(x), collapse = "")))
  }
  if (type == "note" & has_txt(text)) cat(paste0("**", "\u6ce8", "**\uff1a", text), sep = "")
  if (type == "note" & !has_txt(text)) stop("You should set the 'source' at least!")
  if (type == "source" & has_txt(text)) cat(paste0("**", "\u8d44\u6599\u6765\u6e90", "**\uff1a", text), sep = "")
  if (type == "source" & !has_txt(text)) stop("You should set the 'source' at least!")
}

#' Add success footer information as whole part for the figure or table
#'
#' This function should be in the dependent code chunk (outside the code chunk of plot or kable)
#'   and must set the chunk options "result= 'asis'".
#'
#' @param note character, note text for figure or table.
#' @param source character, source text for figure or table.
#'   Empty string or `NULL` omits the source line.
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
  has_txt <- function(x) {
    !is.null(x) && length(x) >= 1L &&
      nzchar(trimws(paste(as.character(x), collapse = "")))
  }
  out <- stringr::str_c(
    if (has_txt(note)) stringr::str_c("**", pre_note, "**\uff1a", note),
    if (has_txt(note)) stringr::str_c("\n\n"),
    if (has_txt(note)) stringr::str_c("\\newline"),
    if (has_txt(note)) stringr::str_c("\n\n"),
    if (has_txt(source)) stringr::str_c("**\u8d44\u6599\u6765\u6e90**\uff1a", source)
  )
  if (!is.null(out) && length(out) == 1L && !is.na(out) && nzchar(out)) {
    cat(out, sep = "\n")
  }
}
