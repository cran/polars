% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__datetime.R
\name{ExprDT_days}
\alias{ExprDT_days}
\alias{(Expr)$dt$days}
\title{Days}
\format{
function
}
\value{
Expr of i64
}
\description{
Extract the days from a Duration type.
}
\examples{
df = pl$DataFrame(
  date = pl$date_range(
    low = as.Date("2020-3-1"),
    high = as.Date("2020-5-1"),
    interval = "1mo",
    lazy = FALSE
  )
)
df$select(
  pl$col("date"),
  pl$col("date")$diff()$dt$days()$alias("days_diff")
)
}
\keyword{ExprDT}
