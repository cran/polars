% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions__lazy.R
\name{pl_tail}
\alias{pl_tail}
\title{Get the last \code{n} rows.}
\arguments{
\item{column}{if dtype is:
\itemize{
\item Series: Take tail value in \code{Series}
\item str or in: syntactic sugar for \verb{pl.col(..).tail()}
}}

\item{n}{Number of rows to take}
}
\value{
Expr or tail value of input Series
}
\description{
Get the last \code{n} rows.
}
\examples{
df = pl$DataFrame(
  a = c(1, 8, 3),
  b = c(4, 5, 2),
  c = c("foo", "bar", "foo")
)

expr_tail = pl$head("a")
print(expr_tail)
df$select(expr_tail)

df$select(pl$tail("a", 2))

pl$tail(df$get_column("a"), 2)
}
