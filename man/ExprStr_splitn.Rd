% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expr__string.R
\name{ExprStr_splitn}
\alias{ExprStr_splitn}
\alias{expr_str_splitn}
\title{splitn}
\arguments{
\item{by}{Substring to split by.}

\item{n}{Number of splits to make.}
}
\value{
Struct where each of n+1 fields is of Utf8 type
}
\description{
Split the string by a substring, restricted to returning at most \code{n} items.
If the number of possible splits is less than \code{n-1}, the remaining field
elements will be null. If the number of possible splits is \code{n-1} or greater,
the last (nth) substring will contain the remainder of the string.
}
\examples{
df = pl$DataFrame(s = c("a_1", NA, "c", "d_4"))
df$select(pl$col("s")$str$splitn(by = "_", 0))
df$select(pl$col("s")$str$splitn(by = "_", 1))
df$select(pl$col("s")$str$splitn(by = "_", 2))
}
\keyword{ExprStr}
