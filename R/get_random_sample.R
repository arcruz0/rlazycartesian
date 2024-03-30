#' Lazily get random sample from a Cartesian product  
#'
#' This function lazily retrieves a random sample from a Cartesian product
#'
#' @param l A named list with the combinations of the Cartesian product.
#' @param n_sample A number with the number of elements to be sampled. 
#' @param index_colname A string with the column name for the indices in the output
#'   data frame. By default, ".element".
#'
#' @return A data frame in which each row is an element from the Cartesian product.
#' 
#' @examples
#' l <- list(color = c("Red", "Blue", "Yellow"),
#'           shape = c("Square", "Circle"))
#'
#' get_random_sample(l, 3)
#'
#' @references 
#' Burdsall, T. (2018). `lazy-cartesian-product`: .hpp library to efficiently
#'   generate combinations using the Lazy Cartesian Product algorithm. <https://github.com/tylerburdsall/lazy-cartesian-product>
#'
#' @export
#' @md

get_random_sample <- function(l, n_sample, index_colname = ".element"){
  # sample indices
  sample_indices <- sample(seq_len(prod(lengths(l))), n_sample)
  
  # use `get_elements()` to retrieve sampled elements
  out <- get_elements(l, indices = sample_indices, index_colname = index_colname)
  
  return(out)
}