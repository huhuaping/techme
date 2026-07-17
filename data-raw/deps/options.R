options(
  htmltools.dir.version = FALSE,
  formatR.indent = 2,
  width = 55,
  digits = 2,
  scipen = 999,
  tinytex.verbose = TRUE,
  knitr.kable.NA = "",
  echo = FALSE,
  warning = FALSE,
  message = FALSE,
  comment = ""
)

knitr::opts_chunk$set(
  fig.align = "center",
  echo = FALSE,
  message = FALSE,
  warning = FALSE,
  comment = "",
  fig.width = 11,
  fig.height = 6
)

inline_hook <- function(x) {
  if (is.numeric(x)) {
    format(x, digits = 2, big.mark = " ")
  } else {
    x
  }
}
knitr::knit_hooks$set(inline = inline_hook)

options(
  DT.options = list(
    dom = "t",
    columnDefs = list(
      list(className = "dt-center", targets = "_all"),
      list(visible = FALSE, targets = 0)
    )
  )
)

options(
  servr.interval = 0.5,
  servr.daemon = TRUE
)
