% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_floor}
\alias{Expr_floor}
\title{Floor}
\usage{
Expr_floor
}
\value{
Expr
}
\description{
Rounds down to the nearest integer value.
Only works on floating point Series.
}
\examples{
pl$DataFrame(list(
  a = c(0.33, 0.5, 1.02, 1.5, NaN, NA, Inf, -Inf)
))$select(
  pl$col("a")$floor()
)
}
\keyword{Expr}
