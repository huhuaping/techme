test_that("get_vars returns character vector for valid block", {
  data(varsList, envir = environment())

  block_sel <- list(
    block1 = "v7",
    block2 = "sctj",
    block3 = "nyjx",
    block4 = "zdl"
  )

  result <- get_vars(df = varsList, block = block_sel, what = "variables")

  expect_type(result, "character")
  expect_true(length(result) > 0)
})

test_that("get_vars filters by eng block levels", {
  data(varsList, envir = environment())

  block_sel <- list(block1 = "v04")
  result <- get_vars(df = varsList, lang = "eng", block = block_sel, what = "variables")

  expect_type(result, "character")
  expect_true(all(grepl("^v04", result)))
})

test_that("get_vars returns short labels", {
  data(varsList, envir = environment())

  block_sel <- list(
    block1 = "v7",
    block2 = "sctj",
    block3 = "nyjx",
    block4 = "zdl"
  )

  result <- get_vars(df = varsList, block = block_sel, what = "short_chn")

  expect_type(result, "character")
  expect_true(nchar(result[1]) > 0)
})
