% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataframe__frame.R
\name{DataFrame_pivot}
\alias{DataFrame_pivot}
\title{Create a spreadsheet-style pivot table as a DataFrame.}
\usage{
DataFrame_pivot(
  values,
  index,
  columns,
  aggregate_function = NULL,
  maintain_order = TRUE,
  sort_columns = FALSE,
  separator = "_"
)
}
\arguments{
\item{values}{Column values to aggregate. Can be multiple columns if the \code{columns}
arguments contains multiple columns as well.}

\item{index}{One or multiple keys to group by.}

\item{columns}{Name of the column(s) whose values will be used as the header of the output
DataFrame.}

\item{aggregate_function}{String naming Expr to aggregate with, or an Expr e.g. \code{pl$element()$sum()},
examples of strings:'first', 'sum', 'max', 'min', 'mean', 'median', 'last', 'count'}

\item{maintain_order}{Sort the grouped keys so that the output order is predictable.}

\item{sort_columns}{Sort the transposed columns by name. Default is by order of discovery.}

\item{separator}{Used as separator/delimiter in generated column names.}
}
\value{
DataFrame
}
\description{
Create a spreadsheet-style pivot table as a DataFrame.
}
\examples{
df = pl$DataFrame(
  foo = c("one", "one", "one", "two", "two", "two"),
  bar = c("A", "B", "C", "A", "B", "C"),
  baz = c(1, 2, 3, 4, 5, 6)
)
df$pivot(
  values = "baz", index = "foo", columns = "bar", aggregate_function = "first"
)


# Run an expression as aggregation function
df = pl$DataFrame(
  col1 = c("a", "a", "a", "b", "b", "b"),
  col2 = c("x", "x", "x", "x", "y", "y"),
  col3 = c(6, 7, 3, 2, 5, 7)
)
df$pivot(
  index = "col1",
  columns = "col2",
  values = "col3",
  aggregate_function = pl$element()$tanh()$mean()
)
}
\keyword{DataFrame}
