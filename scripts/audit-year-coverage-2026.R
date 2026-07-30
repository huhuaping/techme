# Audit techme dataset year coverage for 2026 report
suppressPackageStartupMessages({
  if (requireNamespace("devtools", quietly = TRUE)) {
    try(devtools::load_all(".", quiet = TRUE), silent = TRUE)
  }
  if (!"package:techme" %in% search()) {
    library(techme)
  }
})

core <- c(
  "AgriMachine", "AgriFertilizer", "AgriPesticide", "AgriPlastic",
  "PublicBudget", "RDIntense", "RDActivity", "RDLaborHour", "RDSource",
  "PubCars", "HitechFirmsPub", "PubSeedFirm", "PubFirmLeader",
  "MachineService", "PubOpenShare", "PubGeneticResource", "PubAgrimodernZone",
  "PubConvergence", "PubConvergenceDemo", "PubConvergenceZone",
  "PubAgriPark", "PubObsStation", "IndustryRD", "IndustryOperation"
)

avail <- data(package = "techme")$results[, "Item"]
target <- unique(c(core, avail[grepl("^(Agri|RD|Public|Pub|Machine|Hitech|Industry)", avail)]))

year_of <- function(nm) {
  e <- new.env(parent = emptyenv())
  warn <- NULL
  ok <- tryCatch({
    withCallingHandlers(
      data(list = nm, package = "techme", envir = e),
      warning = function(w) {
        warn <<- conditionMessage(w)
        invokeRestart("muffleWarning")
      }
    )
    exists(nm, envir = e, inherits = FALSE)
  }, error = function(err) FALSE)
  if (!isTRUE(ok)) {
    return(data.frame(dataset = nm, status = "missing", min_year = NA_integer_,
                      max_year = NA_integer_, n = NA_integer_))
  }
  obj <- get(nm, envir = e, inherits = FALSE)
  if (!is.data.frame(obj)) {
    return(data.frame(dataset = nm, status = "not_df", min_year = NA_integer_,
                      max_year = NA_integer_, n = NA_integer_))
  }
  yc <- intersect(names(obj), c("year", "Year", "YEAR", "yr"))
  if (!length(yc)) {
    return(data.frame(dataset = nm, status = "no_year_col", min_year = NA_integer_,
                      max_year = NA_integer_, n = nrow(obj)))
  }
  y <- suppressWarnings(as.integer(obj[[yc[[1]]]]))
  data.frame(
    dataset = nm,
    status = "ok",
    min_year = suppressWarnings(min(y, na.rm = TRUE)),
    max_year = suppressWarnings(max(y, na.rm = TRUE)),
    n = nrow(obj)
  )
}

# Only audit datasets that actually exist in the package
target <- intersect(target, avail)
res <- do.call(rbind, lapply(target, year_of))
res <- res[order(res$dataset), ]
print(res, row.names = FALSE)

cat("\n=== Gaps for 2026 report (cutoff 2025-12-31) ===\n")
cat("Target: yearbooks cover year_report=2024; public sites cover year_lead=2025\n\n")

gap24 <- subset(res, status == "ok" & !is.na(max_year) & max_year < 2024)
gap25_pub <- subset(
  res,
  status == "ok" & !is.na(max_year) & max_year < 2025 &
    grepl("^(Pub|Hitech|MachineService)", dataset)
)

cat("Datasets with max_year < 2024:\n")
print(gap24[, c("dataset", "max_year", "n")], row.names = FALSE)
cat("\nPublic-ish datasets with max_year < 2025:\n")
print(gap25_pub[, c("dataset", "max_year", "n")], row.names = FALSE)

out <- "D:/github/report-tech2026/report/data-coverage-audit-2026.csv"
utils::write.csv(res, out, row.names = FALSE)
cat("\nWrote ", out, "\n", sep = "")
