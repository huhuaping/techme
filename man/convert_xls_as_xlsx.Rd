% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xls2xlsx.R
\name{convert_xls_as_xlsx}
\alias{convert_xls_as_xlsx}
\title{Convert xls to xlsx}
\usage{
convert_xls_as_xlsx(
  input_dir,
  export_dir = tempdir(),
  office_folder = safe_office_folder(),
  dbg = TRUE
)
}
\arguments{
\item{input_dir}{input directory containing .xls files}

\item{export_dir}{export directory (default: tempdir())}

\item{office_folder}{office folder path (default: \code{safe_office_folder})}

\item{dbg}{debug (default: TRUE)}
}
\description{
Convert xls to xlsx
}
\examples{
\dontrun{convert_xls_as_xlsx(input_dir = "d:/temp/", export_dir = "d:/temp/")}
}
