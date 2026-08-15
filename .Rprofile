# renv activates a project library backed by a user-level cache (not files under renv/).
# Set TECHME_USE_RENV=FALSE to skip activation for faster startup when using a global library.
#
# vscode-R languageserver sources this file in a callr worker (user_profile = TRUE).
# renv activate is too slow here and the worker times out, so Cursor Outline stays empty.
# Skip renv for those background sessions; interactive R / Rscript still activate as usual.
# See vignettes/articles/faq-cursor-r-outline.Rmd.
is_vsc_background <- nzchar(Sys.getenv("VSCR_LSP_PORT")) ||
  nzchar(Sys.getenv("VSCR_LIB_PATHS")) ||
  nzchar(Sys.getenv("VSCR_LIM"))
is_callr <- identical(tolower(Sys.getenv("CALLR")), "true") ||
  identical(tolower(Sys.getenv("CALLR_IS_RUNNING")), "true")
use_renv <- !identical(Sys.getenv("TECHME_USE_RENV", unset = "TRUE"), "FALSE") &&
  !is_vsc_background &&
  !is_callr
if (use_renv) {
  source("renv/activate.R")
}

options(usethis.full_name = "Hu Huaping")
options(renv.config.install.transactional = FALSE)
