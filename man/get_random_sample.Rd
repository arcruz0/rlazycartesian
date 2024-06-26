% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_random_sample.R
\name{get_random_sample}
\alias{get_random_sample}
\title{Lazily get random sample from a Cartesian product}
\usage{
get_random_sample(l, n_sample, index_colname = ".element")
}
\arguments{
\item{l}{A named list with the combinations of the Cartesian product.}

\item{n_sample}{A number with the number of elements to be sampled.}

\item{index_colname}{A string with the column name for the indices in the output
data frame. By default, ".element".}
}
\value{
A data frame in which each row is an element from the Cartesian product.
}
\description{
This function lazily retrieves a random sample from a Cartesian product
}
\examples{
l <- list(color = c("Red", "Blue", "Yellow"),
          shape = c("Square", "Circle"))

get_random_sample(l, 3)

}
\references{
Burdsall, T. (2018). \code{lazy-cartesian-product}: .hpp library to efficiently
generate combinations using the Lazy Cartesian Product algorithm. \url{https://github.com/tylerburdsall/lazy-cartesian-product}
}
