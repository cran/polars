% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_arg_max}
\alias{Expr_arg_max}
\title{Index of min value}
\usage{
Expr_arg_max
}
\value{
Expr
}
\description{
Get the index of the minimal value.
}
\details{
See Inf,NaN,NULL,Null/NA translations here \code{\link[polars]{docs_translations}}
}
\examples{
pl$DataFrame(list(
  a = c(6, 1, 0, NA, Inf, NaN)
))$select(pl$col("a")$arg_max())
}
\keyword{Expr}
