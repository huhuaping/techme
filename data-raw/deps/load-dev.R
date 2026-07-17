if (!requireNamespace("pkgload", quietly = TRUE)) {
  stop(
    "Package 'pkgload' is required. Run `Rscript scripts/setup-deps.R dev` first.",
    call. = FALSE
  )
}

pkgload::load_all()
