#' Impose a restriction to a Cartesian product
#' @description An internal function that imposes a restriction to a Cartesian product
#' @param l A named list with the combinations for the Cartesian product.
#' @param restriction A named list that forms a restriction. The name of each
#'   element is a variable. The value of each element is a value or values in the
#'   variable. Multiple elements are joined via `&`.
#' @param v_each A vector with the times each variable's values should be repeated. 
#'   See `rlazycartesian:::restrict_multi()`.
#' @keywords internal

restrict <- function(l, restriction, v_each){
  l_predicates <- vector("list", length(restriction))
  
  for (i in seq_along(restriction)) {
    var_name <- names(restriction)[i]
    var_value <- restriction[[i]]
    var_value_position <- which(l[[var_name]] %in% var_value)
    n_var_values <- length(l[[var_name]])
    l_predicates[[i]] <- rep(
      seq_len(n_var_values), 
      each = v_each[var_name], 
      length.out = rlazycartesian::get_size(l)
    ) %in% var_value_position
  }
  
  return(Reduce(`&`, l_predicates))
  
}

#' Impose multiple restrictions to a Cartesian product
#' @description An internal function that imposes multiple restrictions to a 
#'   Cartesian product. See `rlazycartesian:::restrict()`.
#' @param l A named list with the combinations for the Cartesian product.
#' @param restrictions A named list of restrictions.
#'   See `restrict_multi()`.
#' @keywords internal

restrict_multi <- function(l, restrictions){
  v_each <- cumprod(lengths(rev(l)))
  v_each <- c(1, v_each)
  v_each <- v_each[-length(v_each)]
  v_each <- rev(v_each)
  names(v_each) <- names(l)
  
  return(Reduce(`|`, lapply(restrictions, \(x) restrict(l, x, v_each))))
}