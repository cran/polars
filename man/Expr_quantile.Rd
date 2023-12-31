% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_quantile}
\alias{Expr_quantile}
\alias{quantile}
\title{Get quantile value.}
\usage{
Expr_quantile(quantile, interpolation = "nearest")
}
\arguments{
\item{quantile}{numeric/Expression 0.0 to 1.0}

\item{interpolation}{string value from choices "nearest", "higher",
"lower", "midpoint", "linear"}
}
\value{
Expr
}
\description{
Get quantile value.
}
\details{
\code{Nulls} are ignored and \code{NaNs} are ranked as the largest value.
For linear interpolation \code{NaN} poisons \code{Inf}, that poisons any other value.
}
\examples{
pl$select(pl$lit(-5:5)$quantile(.5))
}
\keyword{Expr}
