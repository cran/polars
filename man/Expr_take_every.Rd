% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_take_every}
\alias{Expr_take_every}
\alias{take_every}
\title{Take every n'th element}
\usage{
Expr_take_every(n)
}
\arguments{
\item{n}{positive integerish value}
}
\value{
Expr
}
\description{
Take every nth value in the Series and return as a new Series.
}
\examples{
pl$DataFrame(list(a = 0:24))$select(pl$col("a")$take_every(6))
}
\keyword{Expr}
