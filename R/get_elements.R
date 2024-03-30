#' Lazily retrieve elements from a Cartesian product  
#'
#' This function lazily retrieves elements from a Cartesian product, given a vector of indices.
#'
#' @param l A named list with the combinations of the Cartesian product.
#' @param indices A numeric vector with indices of the elements to retrieve. 
#' @param index_colname A string with the column name for the indices in the output
#'   data frame. By default, ".element".
#'
#' @return A data frame in which each row is an element from the Cartesian product.
#' 
#' @examples
#' l <- list(color = c("Red", "Blue", "Yellow"),
#'           shape = c("Square", "Circle"))
#'
#' get_elements(l, c(2, 4))
#'
#' @references 
#' Burdsall, T. (2018). `lazy-cartesian-product`: .hpp library to efficiently
#'   generate combinations using the Lazy Cartesian Product algorithm. <https://github.com/tylerburdsall/lazy-cartesian-product>
#' @export
#' @md

get_elements <- function(l, indices, index_colname = ".element"){
  # combine list of elements into df
  out <- do.call(rbind, .entry_at(l, indices)) |> 
    as.data.frame()
  
  # add colnames to df
  names(out) <- names(l)
  
  # add column with indices
  out[[index_colname]] <- indices
  
  # move column with indices to first position
  out <- out |> 
    subset(select = c(index_colname, setdiff(names(out), index_colname)))
  
  return(out)
}