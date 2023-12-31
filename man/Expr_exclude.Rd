% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_exclude}
\alias{Expr_exclude}
\alias{exclude}
\title{Exclude certain columns from a wildcard/regex selection.}
\usage{
Expr_exclude(columns)
}
\arguments{
\item{columns}{given param type:
\itemize{
\item string: exclude name of column or exclude regex starting with ^and ending with$
\item character vector: exclude all these column names, no regex allowed
\item DataType: Exclude any of this DataType
\item List(DataType): Exclude any of these DataType(s)
}}
}
\value{
Expr
}
\description{
You may also use regexes in the exclude list. They must start with \code{^} and end with \code{$}.
}
\examples{

# make DataFrame
df = pl$DataFrame(iris)

# by name(s)
df$select(pl$all()$exclude("Species"))

# by type
df$select(pl$all()$exclude(pl$Categorical))
df$select(pl$all()$exclude(list(pl$Categorical, pl$Float64)))

# by regex
df$select(pl$all()$exclude("^Sepal.*$"))

}
\keyword{Expr}
