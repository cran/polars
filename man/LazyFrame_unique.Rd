% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lazyframe__lazy.R
\name{LazyFrame_unique}
\alias{LazyFrame_unique}
\title{Lazy_unique}
\usage{
LazyFrame_unique(subset = NULL, keep = "first", maintain_order = FALSE)
}
\arguments{
\item{subset}{string or vector of strings. Column name(s) to consider when
identifying duplicates. If set to NULL (default), use all columns.}

\item{keep}{string. Which of the duplicate rows to keep:
\itemize{
\item "first": Keep first unique row.
\item "last": Keep last unique row.
\item "none": Don’t keep duplicate rows.
}}

\item{maintain_order}{Keep the same order as the original \code{LazyFrame.} This
is more expensive to compute. Settings this to \code{TRUE} blocks the possibility
to run on the streaming engine.}
}
\value{
LazyFrame
}
\description{
Drop duplicate rows from this dataframe.
}
\examples{
df = pl$DataFrame(
  x = c(1L, 1:3, 3L),
  y = c(1L, 1:3, 3L),
  z = c(1L, 1:3, 4L)
)
df$lazy()$unique()$collect()$height
df$lazy()$unique(subset = c("x", "y"), keep = "last", maintain_order = TRUE)$collect()
}
\keyword{LazyFrame}
