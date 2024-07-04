#' Create a `lazy_cartesian` object  
#'
#' This function creates a `lazy_cartesian` object, with possible restrictions.
#'
#' @param l A named list with the combinations of the Cartesian product.
#' @param restrictions A list of lists with restrictions. Defaults to NULL. 
#'   See Examples below.
#'
#' @return A `lazy_cartesian` object.
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
#' lc_without_restrictions
#'
#' lc_with_restrictions <- lazy_cartesian(l, r)
#' lc_with_restrictions
#'
#' @references 
#' Burdsall, T. (2018). `lazy-cartesian-product`: .hpp library to efficiently
#'   generate combinations using the Lazy Cartesian Product algorithm. <https://github.com/tylerburdsall/lazy-cartesian-product>
#' @export
#' @md

lazy_cartesian <- function(l, restrictions = NULL){
  out <- list(l = l, restrictions = restrictions, n_r = NULL, restricted = NULL)
  
  out$n_ur <- prod(lengths(l))
  
  if (!is.null(restrictions)){
    out$restricted <- rlazycartesian:::restrict_multi(l, restrictions)
    out$n_r <- sum(!out$restricted)
  }

    class(out) <- "lazy_cartesian"
  return(out)
}

#' @rdname print
#' @export
print.lazy_cartesian <- function(lc){
  
  cat(sprintf("`lazy_cartesian` object with %s elements%s", 
              format(ifelse(!is.null(lc$restrictions), lc$n_r, lc$n_ur), 
                     big.mark = ","),
              ifelse(!is.null(lc$restrictions), " (after restrictions)", "")))
  
  if (!is.null(lc$restrictions)){
    n_excluded <- lc$n_ur - lc$n_r
    
    cat(sprintf(paste("\n  => %s restriction%s excluded %s%% of the Cartesian Product",
                      "\n     (which originally had %s elements)"), 
                length(lc$restrictions),
                ifelse(length(lc$restrictions) > 1, "s", ""),
                round(100 * n_excluded / lc$n_ur, digits = 2),
                format(lc$n_ur, big.mark = ",")
    ))
  }
  
  invisible(lc)
}
