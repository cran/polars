% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lazyframe__lazy.R
\name{LazyFrame_sum}
\alias{LazyFrame_sum}
\title{Sum}
\usage{
LazyFrame_sum
}
\value{
LazyFrame
}
\description{
Aggregate the columns of this DataFrame to their sum values.
}
\examples{
pl$DataFrame(mtcars)$lazy()$sum()$collect()
}
\keyword{LazyFrame}
