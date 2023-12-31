% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkg-nanoarrow.R
\name{nanoarrow}
\alias{nanoarrow}
\alias{as_nanoarrow_array_stream.DataFrame}
\alias{array_stream}
\alias{arrow}
\alias{record_batch_reader}
\alias{arrow_table}
\alias{read}
\alias{more}
\alias{at}
\alias{\url{https://github.com/apache/arrow-nanoarrow/r}}
\alias{infer_nanoarrow_schema.DataFrame}
\alias{as_arrow_table.DataFrame}
\alias{as_record_batch_reader.DataFrame}
\title{polars to nanoarrow and arrow}
\usage{
\method{as_nanoarrow_array_stream}{DataFrame}(x, ..., schema = NULL)

\method{infer_nanoarrow_schema}{DataFrame}(x, ...)

\method{as_arrow_table}{DataFrame}(x, ...)

\method{as_record_batch_reader}{DataFrame}(x, ..., schema = NULL)
}
\arguments{
\item{x}{a polars DataFrame}

\item{...}{not used right now}

\item{schema}{must stay at default value NULL}
}
\value{
\itemize{
\item a nanoarrow array stream
}

\itemize{
\item a nanoarrow array schema
}

\itemize{
\item an arrow table
}

\itemize{
\item an arrow record batch reader
}
}
\description{
Conversion via native apache arrow array stream (fast), THIS REQUIRES ´nanoarrow´
}
\details{
The following functions enable conversion to \code{nanoarrow} and \code{arrow}.
Conversion kindly provided by "paleolimbot / Dewey Dunnington" Author of \code{nanoarrow}.
Currently these conversions are the fastest way to convert from polars to R.
}
\examples{
library(nanoarrow)
df = pl$DataFrame(mtcars)
nanoarrow_array_stream = as_nanoarrow_array_stream(df)
rdf = as.data.frame(nanoarrow_array_stream)
print(head(rdf))
nanoarrow_array_schema = infer_nanoarrow_schema(df)
print(nanoarrow_array_schema)
library(arrow)
arrow_table = as_arrow_table(df)
print(arrow_table)
arrow_record_batch_reader = as_record_batch_reader(df) # requires arrow
print(arrow_record_batch_reader)
}
\keyword{nanoarrow_interface}
