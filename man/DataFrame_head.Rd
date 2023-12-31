% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataframe__frame.R
\name{DataFrame_head}
\alias{DataFrame_head}
\title{Head of a DataFrame}
\usage{
DataFrame_head(n)
}
\arguments{
\item{n}{positive numeric or integer number not larger than 2^32}
}
\value{
DataFrame
}
\description{
Get the first n rows of the query.
}
\details{
any number will converted to u32. Negative raises error
}
\keyword{DataFrame}
