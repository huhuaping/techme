# Techme dependency setup
#
# renv stores package binaries in a user-level cache, not under renv/ in git.
# After clone, run once:
#   Rscript scripts/setup-deps.R
#
# Optional profiles:
#   Rscript scripts/setup-deps.R dev
#   Rscript scripts/setup-deps.R data-raw
#   Rscript scripts/setup-deps.R website
#   Rscript scripts/setup-deps.R all

args <- commandArgs(trailingOnly = TRUE)
profile <- if (length(args)) tolower(args[[1L]]) else "all"

if (!file.exists("renv/activate.R")) {
  stop("Run this script from the techme project root.", call. = FALSE)
}

source("renv/activate.R")

options(
  repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"),
  renv.config.install.compile = FALSE
)

needs_for <- function(profile) {
  desc <- desc::desc(file = "DESCRIPTION")
  switch(
    profile,
    dev = desc$get_deps("Config/Needs/dev")$package,
    `data-raw` = desc$get_deps("Config/Needs/data-raw")$package,
    website = desc$get_deps("Config/Needs/website")$package,
    all = unique(c(
      desc$get_deps("Imports")$package,
      desc$get_deps("Depends")$package,
      desc$get_deps("Suggests")$package,
      desc$get_deps("Config/Needs/dev")$package,
      desc$get_deps("Config/Needs/data-raw")$package,
      desc$get_deps("Config/Needs/website")$package
    )),
    stop("Unknown profile: ", profile, call. = FALSE)
  )
}

cat("Project library:\n  ", .libPaths()[[1L]], "\n\n", sep = "")

if (!requireNamespace("desc", quietly = TRUE)) {
  renv::install("desc")
}

pkgs <- needs_for(profile)
cat("Profile:", profile, "\n")
cat("Packages to ensure:", length(pkgs), "\n\n")

if (profile == "all") {
  cat("Restoring lockfile ...\n")
  renv::restore(prompt = FALSE)
} else {
  cat("Installing profile packages ...\n")
  renv::install(pkgs)
}

cat("\nStatus:\n")
print(renv::status())

cat("\nDone.\n")
cat("For package development use pkgload::load_all(), not devtools::load_all().\n")
