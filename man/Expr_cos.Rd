% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_cos}
\alias{Expr_cos}
\alias{cos}
\title{Cos}
\usage{
Expr_cos
}
\value{
Expr
}
\description{
Compute the element-wise value for the cosine.
}
\details{
Evaluated Series has dtype Float64
}
\examples{
pl$DataFrame(a = c(0, pi / 2, pi, NA_real_))$select(pl$col("a")$cos())
}
\keyword{Expr}
