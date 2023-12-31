% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_nan_min}
\alias{Expr_nan_min}
\title{min propagate NaN}
\usage{
Expr_nan_min
}
\value{
Expr
}
\description{
Get minimum value, but propagate/poison encountered \code{NaN} values.
}
\details{
See Inf,NaN,NULL,Null/NA translations here \code{\link[polars]{docs_translations}}
}
\examples{
pl$DataFrame(list(x = c(1, NaN, -Inf, 3)))$select(pl$col("x")$nan_min()$is_nan()) # is true
}
\keyword{Expr}
