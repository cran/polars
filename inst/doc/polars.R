## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)

## -----------------------------------------------------------------------------
library(polars)

ser = pl$Series((1:5) * 5)
ser

dat = pl$DataFrame(mtcars)
dat

## -----------------------------------------------------------------------------
pl$DataFrame(
  a = pl$Series((1:5) * 5),
  b = pl$Series(letters[1:5]),
  c = pl$Series(c(1, 2, 3, 4, 5)),
  d = c(15, 14, 13, 12, 11),
  c(5, 4, 3, 2, 1),
  1:5
)

## -----------------------------------------------------------------------------
# Series
length(ser)

max(ser)

# DataFrame
dat[c(1:3, 12), c("mpg", "hp")]

names(dat)

dim(dat)

head(dat, n = 2)

## -----------------------------------------------------------------------------
ser$to_vector()

## -----------------------------------------------------------------------------
ser$max()

dat$slice(offset = 2, length = 3)

## -----------------------------------------------------------------------------
dat$max()

## -----------------------------------------------------------------------------
dat$tail(10)$max()

## -----------------------------------------------------------------------------
dat$tail(10)$max()$to_data_frame()

## -----------------------------------------------------------------------------
dat$groupby("cyl")$mean()

## -----------------------------------------------------------------------------
dat$filter(pl$col("cyl") == 6)

dat$filter(pl$col("cyl") == 6 & pl$col("am") == 1)

dat$select(pl$col(c("mpg", "hp")))

## -----------------------------------------------------------------------------
dat$filter(
  pl$col("cyl") == 6
)$select(
  pl$col(c("mpg", "hp", "cyl"))
)

## -----------------------------------------------------------------------------
# Add the grouped sums of some selected columns.
dat$with_columns(
  pl$col("mpg")$sum()$over("cyl")$alias("sum_mpg"),
  pl$col("hp")$sum()$over("cyl")$alias("sum_hp")
)

## -----------------------------------------------------------------------------
dat$with_columns(
  pl$col(c("mpg", "hp"))$sum()$over("cyl")$prefix("sum_")
)

## -----------------------------------------------------------------------------
dat$groupby(
  "cyl",
  maintain_order = TRUE
)$agg(
  pl$col(c("mpg", "hp"))$sum()
)

## -----------------------------------------------------------------------------
dat$groupby(
  "cyl",
  pl$col("am")$cast(pl$Boolean)$alias("manual")
)$agg(
  pl$col("mpg")$mean()$alias("mean_mpg"),
  pl$col("hp")$median()$alias("med_hp")
)

## -----------------------------------------------------------------------------
(indo = pl$DataFrame(Indometh))

## -----------------------------------------------------------------------------
(indo_wide = indo$pivot(values = "conc", index = "time", columns = "Subject"))

## -----------------------------------------------------------------------------
# indo_wide$melt(id_vars = "time") # default column names are "variable" and "value"
indo_wide$melt(id_vars = "time", variable_name = "subject", value_name = "conc") 

## -----------------------------------------------------------------------------
dat$pivot(
  values = "mpg",
  index = c("am", "vs"),
  columns = "cyl",
  aggregate_fun = "median" # aggregating function
)

## -----------------------------------------------------------------------------
data("flights", "planes", package = "nycflights13")
flights = pl$DataFrame(flights)
planes = pl$DataFrame(planes)

flights$join(
  planes,
  on = "tailnum",
  how = "left"
)

## -----------------------------------------------------------------------------
ldat = dat$lazy()
ldat

## -----------------------------------------------------------------------------
subset_query = ldat$filter(
  pl$col("cyl") == 6
)$select(
  pl$col(c("mpg", "hp", "cyl"))
)

subset_query

## -----------------------------------------------------------------------------
subset_query$describe_optimized_plan()

## -----------------------------------------------------------------------------
subset_query$collect()

## -----------------------------------------------------------------------------
write.csv(airquality, "airquality.csv")

pl$read_csv("airquality.csv")

## -----------------------------------------------------------------------------
pl$scan_csv("airquality.csv")

## -----------------------------------------------------------------------------
library(arrow)

write_parquet(airquality, "airquality.parquet")

# aq = read_parquet("airquality.parquet) # eager version (okay)
aq = pl$scan_parquet("airquality.parquet") # lazy version (better)

aq$filter(
  pl$col("Month") <= 6
)$groupby(
  "Month"
)$agg(
  pl$col(c("Ozone", "Temp"))$mean()
)$collect()

## -----------------------------------------------------------------------------
dir.create("airquality-ds")
write_dataset(airquality, "airquality-ds", partitioning = "Month")

# Use pattern globbing to scan all parquet files in the folder
aq2 = pl$scan_parquet("airquality-ds/*/*.parquet")

# Just print the first two rows. But note that the Month column
# (which we used for partitioning) is missing.
aq2$limit(2)$collect()

## -----------------------------------------------------------------------------
file.remove(c("airquality.csv", "airquality.parquet"))
unlink("airquality-ds", recursive = TRUE)

## -----------------------------------------------------------------------------
pl$DataFrame(iris)$select(
  pl$col("Sepal.Length")$map(\(s) { # map with a R function
    x = s$to_vector() # convert from Polars Series to a native R vector
    x[x >= 5] = 10
    x[1:10] # if return is R vector, it will automatically be converted to Polars Series again
  })
)$to_data_frame()

## -----------------------------------------------------------------------------
pl$dtypes$Float64

