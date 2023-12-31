% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_tanh}
\alias{Expr_tanh}
\alias{tanh}
\title{Tanh}
\usage{
Expr_tanh
}
\value{
Expr
}
\description{
Compute the element-wise value for the hyperbolic tangent.
}
\details{
Evaluated Series has dtype Float64
}
\examples{
pl$DataFrame(a = c(-1, atanh(0.5), 0, 1, NA_real_))$select(pl$col("a")$tanh())
}
\keyword{Expr}
