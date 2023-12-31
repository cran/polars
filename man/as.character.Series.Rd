% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/s3_methods.R
\name{as.character.Series}
\alias{as.character.Series}
\title{as.character for polars Series}
\usage{
\method{as.character}{Series}(x, ..., str_length = NULL)
}
\arguments{
\item{x}{Series}

\item{...}{Additional arguments are ignored.}

\item{str_length}{an integer. If specified,
utf8 or categorical type Series will be formatted to a string of this length.}
}
\value{
character vector
}
\description{
as.character for polars Series
}
\examples{
s = pl$Series(c("foo", "barbaz"))
as.character(s)
as.character(s, str_length = 3)
}
