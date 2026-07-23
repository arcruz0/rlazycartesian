#' Lazily get the total number of elements in a Cartesian product  
#'
#' This function lazily retrieves the total number of elements in a Cartesian product
#'
#' @param lc A `lazy_cartesian` object.
#'
#' @return A number.
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
#' lc_without_restrictions <- lazy_cartesian(l)
#' get_size(lc_without_restrictions)
#'
#' lc_with_restrictions <- lazy_cartesian(l, r)
#' get_size(lc_with_restrictions)
#'
#' @export

get_size <- function(lc){
  if (!is.null(lc$restrictions)){
    lc$n_r
  } else {
    lc$n_ur
  }
}