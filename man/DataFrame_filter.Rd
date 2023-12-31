% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataframe__frame.R
\name{DataFrame_filter}
\alias{DataFrame_filter}
\title{filter DataFrame}
\usage{
DataFrame_filter(bool_expr)
}
\arguments{
\item{bool_expr}{Polars expression which will evaluate to a bool pl$Series}
}
\value{
filtered DataFrame
}
\description{
DataFrame$filter(bool_expr)
}
\examples{
pl$DataFrame(iris)$lazy()$filter(pl$col("Sepal.Length") > 5)$collect()
}
\keyword{DataFrame}
