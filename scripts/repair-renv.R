# Repair a broken or bloated renv library on Windows.
# Usage: Rscript scripts/repair-renv.R

if (!file.exists("renv/activate.R")) {
  stop("Run from the techme project root.", call. = FALSE)
}

source("renv/activate.R")

options(
  repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"),
  renv.config.install.compile = FALSE
)

recommended <- c(
  "base", "boot", "class", "cluster", "codetools", "compiler", "datasets",
  "foreign", "grDevices", "graphics", "grid", "KernSmooth", "lattice",
  "MASS", "Matrix", "methods", "mgcv", "nlme", "nnet", "parallel",
  "rpart", "spatial", "splines", "stats", "stats4", "survival", "tcltk",
  "tools", "translations", "utils"
)
renv::settings$ignored.packages(recommended)
renv::settings$snapshot.type("explicit")

project_packages <- function() {
  deps <- renv::dependencies(path = "DESCRIPTION", progress = FALSE)
  pkgs <- unique(deps$Package)
  pkgs[!pkgs %in% c("R", recommended)]
}

lib <- renv::paths$library()
if (dir.exists(lib)) {
  cat("Removing project library:\n  ", lib, "\n", sep = "")
  unlink(lib, recursive = TRUE, force = TRUE)
}
dir.create(lib, recursive = TRUE, showWarnings = FALSE)
renv::load()

if (!identical(normalizePath(.libPaths()[1L], winslash = "/"), normalizePath(lib, winslash = "/"))) {
  stop("Project library is not active: ", .libPaths()[1L], call. = FALSE)
}

pkgs <- project_packages()
remotes_line <- read.dcf("DESCRIPTION", all = TRUE)[1, "Remotes"]
remotes <- if (is.na(remotes_line)) character() else trimws(strsplit(remotes_line, ",", fixed = TRUE)[[1]])
cran_pkgs <- setdiff(pkgs, basename(remotes))
dep_types <- c("Depends", "Imports", "LinkingTo")

if (length(remotes)) {
  cat("Installing remotes first:", paste(remotes, collapse = ", "), "\n")
  renv::install(remotes, library = lib, dependencies = dep_types)
}

cat("Installing", length(cran_pkgs), "declared CRAN packages into project library ...\n")
renv::install(cran_pkgs, library = lib, dependencies = dep_types)

cat("Ensuring tinytex satisfies knitr ...\n")
renv::install("tinytex", library = lib)

cat("Snapshotting renv.lock ...\n")
renv::install("renv", dependencies = FALSE)
renv::snapshot(prompt = FALSE, force = TRUE)

cat("\n=== status ===\n")
status <- renv::status()
cat("synchronized:", status$synchronized, "\n")

if (!isTRUE(status$synchronized)) {
  cat("\nAttempting final restore ...\n")
  renv::restore(prompt = FALSE)
  status <- renv::status()
  cat("synchronized:", status$synchronized, "\n")
}

if (!isTRUE(status$synchronized)) {
  stop("renv library is still not synchronized.", call. = FALSE)
}

cat("\nDone.\n")
cat("Verify with: Rscript scripts/verify-env.R\n")
