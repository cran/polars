% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lazyframe__lazy.R
\name{LazyFrame_max}
\alias{LazyFrame_max}
\title{Max}
\usage{
LazyFrame_max
}
\value{
A new \code{LazyFrame} object with applied aggregation.
}
\description{
Aggregate the columns in the DataFrame to their maximum value.
}
\examples{
pl$DataFrame(mtcars)$lazy()$max()$collect()
}
\keyword{LazyFrame}
