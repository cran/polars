% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_null_count}
\alias{Expr_null_count}
\alias{null_count}
\title{Count \code{Nulls}}
\usage{
Expr_null_count
}
\value{
Expr
}
\description{
Count \code{Nulls}
}
\examples{
pl$select(pl$lit(c(NA, "a", NA, "b"))$null_count())
}
\keyword{Expr}
