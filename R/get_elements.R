#' Lazily retrieve elements from a Cartesian product  
#'
#' This function lazily retrieves elements from a Cartesian product, given a vector of indices.
#'
#' @param lc A `lazy_cartesian` object, created with `rlazycartesian::lazy_cartesian()`.
#' @param indices A numeric vector with indices of the elements to retrieve. 
#' @param index_colname A string with the column name for the indices in the output
#'   data frame. By default, ".element".
#'
#' @return A data frame in which each row is an element from the Cartesian product.
#' 
#' @examples
#' l <- list(color  = c("Red", "Blue", "Yellow"),
#'           shape  = c("Square", "Circle"),
#'           number = 1:3)
#'
#' r <- list(
#'   restriction1 = list(color = "Red", shape = "Circle"),
#'   restriction2 = list(shape = "Square", number = c(1, 3))
#' )
#'
#' lc <- lazy_cartesian(l, r)
#' get_elements(lc, c(1, 3))
#'
#' @references 
#' Burdsall, T. (2018). `lazy-cartesian-product`: .hpp library to efficiently
#'   generate combinations using the Lazy Cartesian Product algorithm. <https://github.com/tylerburdsall/lazy-cartesian-product>
#' @export
#' @md

get_elements <- function(lc, indices, index_colname = ".element"){
  
  if (!is.null(lc$restrictions)){
    if (length(intersect(indices, which(!lc$restricted))) == 0){
      stop("Provided restricted indices.")
    }
  }
  
  # combine list of elements into df
  l_str <- lapply(lc$l, as.character)
  
  out <- do.call(rbind, rlazycartesian:::.entry_at(l_str, indices)) |> 
    as.data.frame()
  
  # add colnames to df
  names(out) <- names(l_str)
  
  # add column with indices
  out[[index_colname]] <- indices
  
  # move column with indices to first position
  out <- out |> 
    subset(select = c(index_colname, setdiff(names(out), index_colname)))
  
  return(out)
}
