% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_var}
\alias{Expr_var}
\title{Get Variance}
\usage{
Expr_var(ddof = 1)
}
\arguments{
\item{ddof}{integer in range \verb{[0;255]} degrees of freedom}
}
\value{
Expr (f64 scalar)
}
\description{
Get Variance
}
\examples{
pl$select(pl$lit(1:5)$var())
}
\keyword{Expr}
