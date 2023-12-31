% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__list.R
\name{arr_sum}
\alias{arr_sum}
\alias{arr.sum}
\title{Sum lists}
\format{
function
}
\value{
Expr
}
\description{
Sum all the lists in the array.
}
\examples{
df = pl$DataFrame(values = pl$Series(list(1L, 2:3)))
df$select(pl$col("values")$arr$sum())
}
\keyword{ExprArr}
