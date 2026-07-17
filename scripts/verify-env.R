# Verify renv environment and core data-raw dependency loaders.
source("renv/activate.R")

options(
  repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"),
  renv.config.install.compile = FALSE
)

cat("=== renv status ===\n")
status <- renv::status()
cat("synchronized:", status$synchronized, "\n")
if (!isTRUE(status$synchronized)) {
  stop("renv library is not synchronized with renv.lock", call. = FALSE)
}

cat("\n=== load core deps ===\n")
source("data-raw/deps/load-core.R")
cat("core ok:", paste(c("dplyr", "tidyr", "stringr"), collapse = ", "), "\n")

cat("\n=== load dev deps ===\n")
source("data-raw/deps/load-dev.R")
cat("techme loaded:", "package:techme" %in% search(), "\n")

cat("\nEnvironment verification passed.\n")
