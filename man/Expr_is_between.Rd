% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_is_between}
\alias{Expr_is_between}
\title{is in between}
\usage{
Expr_is_between(start, end, include_bounds = FALSE)
}
\arguments{
\item{start}{Lower bound as primitive or datetime}

\item{end}{Lower bound as primitive or datetime}

\item{include_bounds}{bool vector or scalar:
FALSE:           Exclude both start and end (default).
TRUE:            Include both start and end.
c(FALSE, FALSE):  Exclude start and exclude end.
c(TRUE, TRUE):    Include start and include end.
c(FALSE, TRUE):   Exclude start and include end.
c(TRUE, FALSE):   Include start and exclude end.}
}
\value{
Expr
}
\description{
Check if this expression is between start and end.
}
\details{
alias the column to 'in_between'
This function is equivalent to a combination of < <= >= and the &-and operator.
}
\examples{
df = pl$DataFrame(list(num = 1:5))
df$select(pl$col("num")$is_between(2, 4))
df$select(pl$col("num")$is_between(2, 4, TRUE))
df$select(pl$col("num")$is_between(2, 4, c(FALSE, TRUE)))
# start end can be a vector/expr with same length as column
df$select(pl$col("num")$is_between(c(0, 2, 3, 3, 3), 6))
}
\keyword{Expr}
