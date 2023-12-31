test_that("csv read iris", {
  tmpf = tempfile()
  write.csv(iris, tmpf, row.names = FALSE)
  lf = pl$scan_csv(tmpf)
  df = pl$read_csv(tmpf)

  iris_char = iris
  iris_char$Species = as.character(iris$Species)

  expect_equal(
    lf$collect()$to_data_frame(),
    iris_char
  )
  expect_equal(
    df$to_data_frame(),
    iris_char
  )

  # named dtype changed to categorical
  expect_equal(
    pl$scan_csv(tmpf, overwrite_dtype = list(Species = pl$Categorical))$collect()$to_data_frame(),
    iris
  )
})
