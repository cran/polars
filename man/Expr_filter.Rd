% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_filter}
\alias{Expr_filter}
\alias{Expr_where}
\alias{where}
\title{Filter a single column.}
\usage{
Expr_filter(predicate)

Expr_where(predicate)
}
\arguments{
\item{predicate}{Expr or something \verb{Into<Expr>}. Should be a boolean expression.}
}
\value{
Expr
}
\description{
Mostly useful in an aggregation context. If you want to filter on a DataFrame
level, use \code{LazyFrame.filter}.

where() is an alias for pl$filter
}
\examples{
df = pl$DataFrame(list(
  group_col = c("g1", "g1", "g2"),
  b = c(1, 2, 3)
))

df$groupby("group_col")$agg(
  pl$col("b")$filter(pl$col("b") < 2)$sum()$alias("lt"),
  pl$col("b")$filter(pl$col("b") >= 2)$sum()$alias("gte")
)
}
\keyword{Expr}
