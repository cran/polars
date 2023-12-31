test_that("lazyframe join examples", {
  df = pl$DataFrame(list(
    foo = 1:3,
    bar = c(6, 7, 8),
    ham = c("a", "b", "c")
  ))$lazy()

  other_df = pl$DataFrame(list(
    apple = c("x", "y", "z"),
    ham = c("a", "b", "d")
  ))$lazy()

  # inner default join
  df_inner = df$join(other_df, on = "ham")$collect()
  expect_identical(
    df_inner$to_data_frame(),
    data.frame(foo = 1:2, bar = c(6, 7), ham = c("a", "b"), apple = c("x", "y"))
  )

  # outer
  df_outer = df$join(other_df, on = "ham", how = "outer")$collect()
  expect_identical(
    df_outer$to_data_frame(),
    data.frame(
      foo = c(1L, 2L, NA, 3L),
      bar = c(6, 7, NA, 8),
      ham = c("a", "b", "d", "c"),
      apple = c("x", "y", "z", NA)
    )
  )
})


test_that("test_semi_anti_join", {
  # 1
  df_a = pl$DataFrame(list(key = 1:3, payload = c("f", "i", NA)))
  df_b = pl$DataFrame(list(key = c(3L, 4L, 5L, NA)))

  # eager1
  expect_identical(
    df_a$join(df_b, on = "key", how = "anti")$to_data_frame(),
    data.frame(key = 1:2, payload = c("f", "i"))
  )
  expect_identical(
    df_a$join(df_b, on = "key", how = "semi")$to_data_frame(),
    data.frame(key = 3L, payload = NA_character_)
  )

  # lazy1
  expect_identical(
    df_a$lazy()$join(df_b$lazy(), on = "key", how = "anti")$collect()$to_data_frame(),
    data.frame(key = 1:2, payload = c("f", "i"))
  )
  expect_identical(
    df_a$lazy()$join(df_b$lazy(), on = "key", how = "semi")$collect()$to_data_frame(),
    data.frame(key = 3L, payload = NA_character_)
  )

  # 2
  df_a = pl$DataFrame(list(a = c(1:3, 1L), b = c("a", "b", "c", "a"), payload = c(10L, 20L, 30L, 40L)))
  df_b = pl$DataFrame(list(a = c(3L, 3L, 4L, 5L), b = c("c", "c", "d", "e")))

  # eager2
  expect_identical(
    df_a$join(df_b, on = c("a", "b"), how = "anti")$to_data_frame(),
    data.frame(a = c(1:2, 1L), b = c("a", "b", "a"), payload = c(10L, 20L, 40L))
  )
  expect_identical(
    df_a$join(df_b, on = c("a", "b"), how = "semi")$to_data_frame(),
    data.frame(a = 3L, b = "c", payload = 30L)
  )

  # lazy2
  expect_identical(
    df_a$lazy()$join(df_b$lazy(), on = c("a", "b"), how = "anti")$collect()$to_data_frame(),
    data.frame(a = c(1:2, 1L), b = c("a", "b", "a"), payload = c(10L, 20L, 40L))
  )
  expect_identical(
    df_a$lazy()$join(df_b$lazy(), on = c("a", "b"), how = "semi")$collect()$to_data_frame(),
    data.frame(a = 3L, b = "c", payload = 30L)
  )
})


test_that("cross join, DataFrame", {
  dat = pl$DataFrame(
    x = letters[1:3]
  )
  dat2 = pl$DataFrame(
    y = 1:4
  )

  expect_identical(
    dat$join(dat2, how = "cross")$to_data_frame(),
    data.frame(
      x = rep(letters[1:3], each = 4),
      y = rep(1:4, 3)
    )
  )

  # one empty dataframe
  dat_empty = pl$DataFrame(y = character())
  expect_identical(
    dat$join(dat_empty, how = "cross")$to_data_frame(),
    data.frame(x = character(), y = character())
  )
  expect_identical(
    dat_empty$join(dat, how = "cross")$to_data_frame(),
    data.frame(y = character(), x = character())
  )

  # suffix works
  expect_identical(
    dat$join(dat, how = "cross")$to_data_frame(),
    data.frame(
      x = rep(letters[1:3], each = 3),
      x_right = rep(letters[1:3], 3)
    )
  )
})
