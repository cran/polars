% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rust_result.R
\name{or_else}
\alias{or_else}
\title{map an Err part of Result}
\usage{
or_else(x, f)
}
\arguments{
\item{x}{any R object}

\item{f}{a closure that takes the ok part as input, must return a result itself}
}
\value{
same R object wrapped in a Err-result
}
\description{
map an Err part of Result
}
\keyword{internal}
