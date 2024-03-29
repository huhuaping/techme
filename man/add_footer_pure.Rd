% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fun-add-footer.R
\name{add_footer_pure}
\alias{add_footer_pure}
\title{Add success footer information item to item for the figure or table}
\usage{
add_footer_pure(text, type = "note")
}
\arguments{
\item{text}{character, information text.}

\item{type}{character, is one of c('note', 'source') and default 'note'}
}
\value{
invisible
}
\description{
This function should be in the code chunk (always follow the code of plot or kable)
and without setting "result= 'asis'".
}
\examples{
cap_note <- "This is a note, ba la ba la"
cap_source <- "source from yearbook 2021"
\dontrun{
 add_footer_pure(cap_note)
 cat("\n")
 add_footer_pure(cap_source, type = "source")
}


}
