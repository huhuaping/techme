test_that("get_vars returns a one-column data.frame for valid block", {
  data(varsList, envir = environment())

  block_sel <- list(
    block1 = "v7",
    block2 = "sctj",
    block3 = "nyjx",
    block4 = "zdl"
  )

  result <- get_vars(df = varsList, block = block_sel, what = "variables")

  expect_s3_class(result, "data.frame")
  expect_named(result, "variables")
  expect_gt(nrow(result), 0)
  expect_type(result$variables, "character")
})

test_that("get_vars filters by eng block levels", {
  data(varsList, envir = environment())

  block_sel <- list(block1 = "v4")
  result <- get_vars(df = varsList, lang = "eng", block = block_sel, what = "variables")

  expect_s3_class(result, "data.frame")
  expect_gt(nrow(result), 0)
  expect_true(all(grepl("^v4", result$variables)))
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

  expect_s3_class(result, "data.frame")
  expect_named(result, "short_chn")
  expect_gt(nrow(result), 0)
})
