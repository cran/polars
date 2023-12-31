% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__expr.R
\name{Expr_cast}
\alias{Expr_cast}
\alias{cast}
\title{Cast between DataType(s)}
\usage{
Expr_cast(dtype, strict = TRUE)
}
\arguments{
\item{dtype}{DataType to cast to.}

\item{strict}{bool if true an error will be thrown if cast failed at resolve time.}
}
\value{
Expr
}
\description{
Cast between DataType(s)
}
\examples{
df = pl$DataFrame(a = 1:3, b = c(1, 2, 3))
df$print()$with_columns(
  pl$col("a")$cast(pl$dtypes$Float64),
  pl$col("b")$cast(pl$dtypes$Int32)
)

# strict FALSE, inserts null for any cast failure
pl$lit(c(100, 200, 300))$cast(pl$dtypes$UInt8, strict = FALSE)$lit_to_s()


# strict TRUE, raise any failure as an error when query is executed.
tryCatch(
  {
    pl$lit("a")$cast(pl$dtypes$Float64, strict = TRUE)$lit_to_s()
  },
  error = as.character
)
}
\keyword{Expr}
