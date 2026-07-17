load_pkg <- function(...) {
  pkgs <- c(...)
  missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing)) {
    stop(
      "Missing package(s): ", paste(missing, collapse = ", "),
      ". Run `Rscript scripts/setup-deps.R` first.",
      call. = FALSE
    )
  }
  for (pkg in pkgs) {
    suppressPackageStartupMessages(
      library(pkg, character.only = TRUE, warn.conflicts = FALSE)
    )
  }
  invisible(pkgs)
}
