#' Lazily get the total number of elements in a Cartesian product  
#'
#' This function lazily retrieves the total number of elements in a Cartesian product
#'
#' @param l A named list with the combinations of the Cartesian product.
#'
#' @return A number.
#' 
#' @examples
#' l <- list(color = c("Red", "Blue", "Yellow"),
#'           shape = c("Square", "Circle"))
#'
#' get_size(l)
#'
#' @export
#' @md

get_size <- function(l){
  return(prod(lengths(l)))
}