% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__datetime.R
\name{ExprDT_nanoseconds}
\alias{ExprDT_nanoseconds}
\alias{(Expr)$dt$nanoseconds}
\title{nanoseconds}
\format{
function
}
\value{
Expr of i64
}
\description{
Extract the nanoseconds from a Duration type.
}
\examples{
df = pl$DataFrame(date = pl$date_range(
  low = as.POSIXct("2020-1-1", tz = "GMT"),
  high = as.POSIXct("2020-1-1 00:00:01", tz = "GMT"),
  interval = "1ms",
  lazy = FALSE
))
df$select(
  pl$col("date"),
  pl$col("date")$diff()$dt$nanoseconds()$alias("seconds_diff")
)
}
\keyword{ExprDT}
