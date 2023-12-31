% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_sum}
\alias{Expr_sum}
\title{sum}
\usage{
Expr_sum
}
\value{
Expr
}
\description{
Get sum value
}
\details{
Dtypes in {Int8, UInt8, Int16, UInt16} are cast to
Int64 before summing to prevent overflow issues.
}
\examples{
pl$DataFrame(list(x = c(1L, NA, 2L)))$select(pl$col("x")$sum()) # is i32 3 (Int32 not casted)
}
\keyword{Expr}
