% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__meta.R
\name{ExprMeta_is_regex_projection}
\alias{ExprMeta_is_regex_projection}
\alias{expr_is_regex_projection}
\title{Is regex projection.}
\value{
Bool
}
\description{
Whether this expression expands to columns that match a regex pattern.
}
\examples{
pl$col("^Sepal.*$")$meta$is_regex_projection()
pl$col("Sepal.Length")$meta$is_regex_projection()
}
\keyword{ExprMeta}
