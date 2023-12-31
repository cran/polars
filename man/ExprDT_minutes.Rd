% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__datetime.R
\name{ExprDT_minutes}
\alias{ExprDT_minutes}
\alias{(Expr)$dt$minutes}
\title{Minutes}
\format{
function
}
\value{
Expr of i64
}
\description{
Extract the minutes from a Duration type.
}
\examples{
df = pl$DataFrame(
  date = pl$date_range(
    low = as.Date("2020-1-1"),
    high = as.Date("2020-1-4"),
    interval = "1d",
    lazy = FALSE
  )
)
df$select(
  pl$col("date"),
  pl$col("date")$diff()$dt$minutes()$alias("minutes_diff")
)
}
\keyword{ExprDT}
