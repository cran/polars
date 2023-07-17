## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)

## -----------------------------------------------------------------------------
library(polars)

## ---- include = FALSE---------------------------------------------------------
df = pl$read_csv("https://j.mp/iriscsv")

## -----------------------------------------------------------------------------
df$filter(pl$col("sepal_length") > 5)$
  groupby("species", maintain_order = TRUE)$
  agg(pl$all()$sum())

df$
  lazy()$
  filter(pl$col("sepal_length") > 5)$
  groupby("species", maintain_order = TRUE)$
  agg(pl$all()$sum())$
  collect()

## -----------------------------------------------------------------------------
series = pl$Series(c(1, 2, 3, 4, 5))
series

df = pl$DataFrame(
  "integer" = c(1, 2, 3),
  "date" = as.Date(c("2022-1-1", "2022-1-2", "2022-1-3")),
  "float" = c(4.0, 5.0, 6.0))
df

# df$write_csv('output.csv')
# df_csv_with_dates = pl$read_csv("output.csv", parse_dates=True)
# print(df_csv_with_dates)

# dataframe$write_json('output.json')
# df_json = pl$read_json("output.json")
# print(df_json)

# dataframe$write_parquet('output.parquet')
# df_parquet = pl$read_parquet("output.parquet")
# print(df_parquet)

df = pl$DataFrame(
  "a" = as.numeric(0:7),
  "b" = runif(8),
  "c" = as.Date(sprintf("2022-12-%s", 1:8)),
  "d" = c(1, 2.0, NaN, NaN, 0, -5, -42, NA)
)
df$head(5)

df$tail(5)

## not implemented yet
# df$sample(3)

## not implemented yet
# df$describe()

df$select(pl$col("*"))

df$select(pl$col(c("a", "b")))

df$select(pl$col(c("a", "b")))

df$select(pl$col("a"), pl$col("b"))$limit(3)

df$select(pl$all()$exclude("a"))

df$filter(
    pl$col("c")$is_between(as.Date("2022-12-2"), as.Date("2022-12-8"))
)

df$filter((pl$col("a") <= 3) & (pl$col("d")$is_not_nan()))

df$with_columns(pl$col("b")$sum()$alias("e"), (pl$col("b") + 42)$alias("b+42"))

df$with_columns((pl$col("a") * pl$col("b"))$alias("a * b"))$select(pl$all()$exclude(c("c", "d")))

df = pl$DataFrame("x" = 0:7, "y" = c("A", "A", "A", "B", "B", "C", "X", "X"))

df$
  groupby("y", maintain_order = FALSE)$
  agg(
    pl$col("*")$count()$alias("count"),
    pl$col("*")$sum()$alias("sum")
  )

df1 = pl$DataFrame(
  "a" = 0:7,
  "b" = runif(8),
  "c" = as.Date(sprintf("2022-12-%s", 1:8)),
  "d" = c(1, 2.0, NaN, NaN, 0, -5, -42, NA)
)
df2 = pl$DataFrame("x" = 0:7, "y" = c("A", "A", "A", "B", "B", "C", "X", "X"))

pl$concat(c(df1, df2), how = "horizontal")

## -----------------------------------------------------------------------------
df = pl$DataFrame(
  "nrs" = c(1, 2, 3, NA, 5),
  "names" = c("foo", "ham", "spam", "egg", NA),
  "random" = runif(5),
  "groups" = c("A", "A", "B", "C", "B")
)
df

df$select(
  pl$col("names")$n_unique()$alias("unique_names_1"),
  pl$col("names")$unique()$count()$alias("unique_names_2")
)

df$select(
  pl$sum("random")$alias("sum"),
  pl$min("random")$alias("min"),
  pl$max("random")$alias("max"),
  pl$col("random")$max()$alias("other_max"),
  pl$std("random")$alias("std dev"),
  pl$var("random")$alias("variance")
)

df$select(
  pl$col("names")$filter(pl$col("names")$str$contains("am$"))$count()
)

df$select(
  pl$when(pl$col("random") > 0.5)$then(0)$otherwise(pl$col("random")) * pl$sum("nrs")
)

df$select(
  pl$when(pl$col("groups") == "A")$then(1)$when(pl$col("random") > 0.5)$then(0)$otherwise(pl$col("random"))
)

df$select(
  pl$col("*"),  # select all
  pl$col("random")$sum()$over("groups")$alias("sumc(random)/groups"),
  pl$col("random")$implode()$over("names")$alias("random/name")
)

## -----------------------------------------------------------------------------
df$select(
  pl$sum("nrs"),
  pl$col("names")$sort(),
  pl$col("names")$first()$alias("first name"),
  (pl$mean("nrs") * 10)$alias("10xnrs")
)

df$with_columns(
  pl$sum("nrs")$alias("nrs_sum"),
  pl$col("random")$count()$alias("count")
)

df$groupby("groups")$agg(
  pl$sum("nrs"),  # sum nrs by groups
  pl$col("random")$count()$alias("count"),  # count group members
  # sum random where name != null
  pl$col("random")$filter(pl$col("names")$is_not_null())$sum()$suffix("_sum"),
  pl$col("names")$reverse()$alias(("reversed names"))
)

## -----------------------------------------------------------------------------
url = "https://theunitedstates.io/congress-legislators/legislators-historical.csv"

dtypes = list(
    "first_name" = pl$Categorical,
    "gender" = pl$Categorical,
    "type" = pl$Categorical,
    "state" = pl$Categorical,
    "party" = pl$Categorical
)

# dtypes argument
dataset = pl$read_csv(url)$with_columns(pl$col("birthday")$str$strptime(pl$Date, "%Y-%m-%d"))

dataset$
  lazy()$
  groupby("first_name")$
  agg(
    pl$count(),
    pl$col("gender"),
    pl$first("last_name"))$
  sort("count", descending = TRUE)$
  limit(5)$
  collect()

dataset$lazy()$
  groupby("state")$
  agg(
    (pl$col("party") == "Anti-Administration")$sum()$alias("anti"),
    (pl$col("party") == "Pro-Administration")$sum()$alias("pro"))$
  sort("pro", descending = TRUE)$
  limit(5)$
  collect()

dataset$
  lazy()$
  groupby(c("state", "party"))$
  agg(pl$count("party")$alias("count"))$
  filter((pl$col("party") == "Anti-Administration") | (pl$col("party") == "Pro-Administration"))$
  sort("count", descending = TRUE)$
  head(5)$
  collect()

## ---- include = FALSE---------------------------------------------------------
df = pl$read_csv(
  "https://gist.githubusercontent.com/ritchie46/cac6b337ea52281aa23c049250a4ff03/raw/89a957ff3919d90e6ef2d34235e6bf22304f3366/pokemon.csv"
)

## -----------------------------------------------------------------------------
filtered = df$
  filter(pl$col("Type 2") == "Psychic")$
  select(c("Name", "Type 1", "Speed"))
filtered

filtered$with_columns(
  pl$col(c("Name", "Speed"))$sort()$over("Type 1")
)

# aggregate and broadcast within a group
# output type: -> Int32
pl$sum("foo")$over("groups")

# sum within a group and multiply with group elements
# output type: -> Int32
(pl$col("x")$sum() * pl$col("y"))$over("groups")

# sum within a group and multiply with group elements 
# and aggregate/implode the group to a list
# output type: -> List(Int32)
(pl$col("x")$sum() * pl$col("y"))$implode()$over("groups")

# note that it will require an explicit `implode()` call
# sum within a group and multiply with group elements 
# and aggregate/implode the group to a list
# the explode call unpack the list and combine inner elements to one column

# This is the fastest method to do things over groups when the groups are sorted
(pl$col("x")$sum() * pl$col("y"))$implode()$over("groups")$explode()

df$sort("Type 1")$select(
  pl$col("Type 1")$head(3)$implode()$over("Type 1")$explode(),
  pl$col("Name")$sort_by(pl$col("Speed"))$head(3)$implode()$over("Type 1")$explode()$alias("fastest/group"),
  pl$col("Name")$sort_by(pl$col("Attack"))$head(3)$implode()$over("Type 1")$explode()$alias("strongest/group"),
  pl$col("Name")$sort()$head(3)$implode()$over("Type 1")$explode()$alias("sorted_by_alphabet")
)

## -----------------------------------------------------------------------------
df = pl$DataFrame(
  "A" = c(1, 2, 3, 4, 5),
  "fruits" = c("banana", "banana", "apple", "apple", "banana"),
  "B" = c(5, 4, 3, 2, 1),
  "cars" = c("beetle", "audi", "beetle", "beetle", "beetle"),
  "optional" = c(28, 300, NA, 2, -30)
)
df

# Within select, we can use the col function to refer to columns$
# If we are not applying any function to the column, we can also use the column name as a string$
df$select(
  pl$col("A"),
  "B",         # the col part is inferred
  pl$lit("B")  # the pl$lit functions tell polars we mean the literal "B"
)

# We can use a list within select (example above) or a comma-separated list of expressions (this example)$
df$select(
  pl$col("A"),
  "B",      
  pl$lit("B")
)

# We can select columns with a regex if the regex starts with '^' and ends with '$'
df$select(    
  pl$col("^A|B$")$sum()
)

# We can select multiple columns by name
df$select(
  pl$col(c("A", "B"))$sum()
)

# We select everything in normal order
# Then we select everything in reversed order
df$select(
  pl$all(),
  pl$all()$reverse()$suffix("_reverse")
)

# All expressions run in parallel
# Single valued `Series` are broadcasted to the shape of the `DataFrame`
df$select(
  pl$all(),
  pl$all()$sum()$suffix("_sum") # This is a single valued Series broadcasted to the shape of the DataFrame
)

# Filters can also be applied within an expression
df$select(
  # Sum the values of A where the fruits column starts with 'b'
  pl$col("A")$filter(pl$col("fruits")$str$contains("^b$*"))$sum()
)

# We can do arithmetic on columns
df$select(
  ((pl$col("A") / 124.0 * pl$col("B")) / pl$sum("B"))$alias("computed")
)

# We can combine columns by a predicate
# For example when the `fruits` column is 'banana' we set the value equal to the
# value in `B` column for that row, otherwise we set the value to be -1
df$select(
  "fruits",
  "B",
  pl$when(pl$col("fruits") == "banana")$then(pl$col("B"))$otherwise(-1)$alias("b")
)

# We can combine columns by a fold operation on column level$
# For example we do a horizontal sum where we:
# - start with 0
# - add the value in the `A` column
# - add the value in the `B` column
# - add the value in the `B` column squared
# df$select(
#   "A",
#   "B",
#   pl$fold(0, function(a, b) a + b, c( pl$col("A"), "B", pl$col("B")**2,))$alias("fold")
# )

df$groupby("fruits")$
  agg(
    pl$col("B")$count()$alias("B_count"),
    pl$col("B")$sum()$alias("B_sum")
  )

# We can aggregate many expressions at once
df$groupby("fruits")$
  agg(
            pl$col("B")$sum()$alias("B_sum"),# Sum of B
            # pl$first("fruits")$alias("fruits_first"),# First value of fruits
            # pl$count("A")$alias("count"),# Count of A
            pl$col("cars")$reverse() # Reverse the cars column - not an aggregation
            # so the output is a pl$List
  )

## -----------------------------------------------------------------------------
# We can also get a list of the row indices for each group with `agg_groups()`
df$
  groupby("fruits")$
  agg(pl$col("B")$agg_groups()$alias("group_row_indices"))

# We can also do filter predicates in groupby
# In this example we do not include values of B that are smaller than 1
# in the sum
df$
  groupby("fruits")$
  agg(pl$col("B")$filter(pl$col("B") > 1)$sum())


# Here we add a new column with the sum of B grouped by fruits
df$
  select(
    "fruits",
    "cars",
    "B",
    pl$col("B")$sum()$over("fruits")$alias("B_sum_by_fruits"))

# We can also use window functions to do groupby over multiple columns
df$
  select(
    "fruits",
    "cars",
    "B",
    pl$col("B")$sum()$over("fruits")$alias("B_sum_by_fruits"),
    pl$col("B")$sum()$over("cars")$alias("B_sum_by_cars"))

# Here we use a window function to lag column B within "fruits"
df$
  select(
    "fruits",
    "B",
    pl$col("B")$shift()$over("fruits")$alias("lag_B_by_fruits"))

