#' Lazily get random sample from a Cartesian product  
#'
#' This function lazily retrieves a random sample from a Cartesian product, 
#'   respecting restrictions.
#'
#' @param lc A `lazy_cartesian` object, created with `rlazycartesian::lazy_cartesian()`.
#' @param n_sample An integer with the number of elements to be sampled. 
#' @param index_colname A string with the column name for the indices in the output
#'   data frame. By default, ".element".
#'
#' @return A data frame in which each row is an element from the 
#'   (potentially restricted) Cartesian product. Indices are in the first 
#'   column and correspond to the unrestricted Cartesian product (i.e., they
#'   go from 1 to n_ur).
#' 
#' @examples
#' l <- list(color = c("Red", "Blue", "Yellow"),
#'           shape = c("Square", "Circle"))
#'
#' get_random_sample(l, 3L)
#'
#' @references 
#' Burdsall, T. (2018). `lazy-cartesian-product`: .hpp library to efficiently
#'   generate combinations using the Lazy Cartesian Product algorithm. <https://github.com/tylerburdsall/lazy-cartesian-product>
#'
#' @export
#' @md

get_random_sample <- function(lc, n_sample, index_colname = ".element"){
  # define candidate elements
  candidates <- seq_len(lc$n_ur)
  
  if (!is.null(lc$restrictions)){
    candidates <- candidates[!lc$restricted]
  }
  
  # sample indices
  sample_indices <- sample(candidates, n_sample)
  
  # use `get_elements()` to retrieve sampled indices
  out <- get_elements(lc, indices = sample_indices, index_colname = index_colname)
  
  return(out)
}
