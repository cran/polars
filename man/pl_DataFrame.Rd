% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataframe__frame.R
\name{pl_DataFrame}
\alias{pl_DataFrame}
\title{Create new DataFrame}
\arguments{
\item{...}{One of the following:
\itemize{
\item a data.frame or something that inherits data.frame or DataFrame
\item a list of mixed vectors and Series of equal length
\item mixed vectors and/or Series of equal length
}

Columns will be named as of named arguments or alternatively by names of Series or given a
placeholder name.}

\item{make_names_unique}{default TRUE, any duplicated names will be prefixed a running number}

\item{parallel}{bool default FALSE, experimental multithreaded interpretation of R vectors
into a polars DataFrame. This is experimental as multiple threads read from R mem simultaneously.
So far no issues parallel read from R has been found.}
}
\value{
DataFrame
}
\description{
Create new DataFrame
}
\examples{
pl$DataFrame(
  a = list(c(1, 2, 3, 4, 5)), # NB if first column should be a list, wrap it in a Series
  b = 1:5,
  c = letters[1:5],
  d = list(1:1, 1:2, 1:3, 1:4, 1:5)
) # directly from vectors

# from a list of vectors or data.frame
pl$DataFrame(list(
  a = c(1, 2, 3, 4, 5),
  b = 1:5,
  c = letters[1:5],
  d = list(1L, 1:2, 1:3, 1:4, 1:5)
))

}
\keyword{DataFrame_new}
