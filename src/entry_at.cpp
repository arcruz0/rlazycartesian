#include <Rcpp.h>
using namespace Rcpp;

#include <string>
#include <vector>
#include "lazy-cartesian-product.hpp"

using lazycp::lazy_cartesian_product;

// [[Rcpp::export(.entry_at)]]
List entry_at (List input_list, std::vector<int> at)
{
  // Convert list to vector<vector<string>> //
  // set n
  R_xlen_t n = input_list.length();
  // initialize empty possibilities vector
  std::vector<vector<string>> possibilities(n);
  // fill vector with values from the list
  for(R_xlen_t i = 0; i < n; ++i) {
    std::vector<string> input_list_i = input_list[i];
    possibilities.at(i) = input_list_i;
  }
  
  // Compute entry_at using `lazy-cartesian-product` //
  // set n
  R_xlen_t n_at = at.size();
  std::vector<vector<string>> results_at(n_at);
  for(R_xlen_t i = 0; i < n_at; ++i) {
    std::vector<string> results_at_i = lazy_cartesian_product::entry_at(possibilities, at[i] - 1);
    results_at.at(i) = results_at_i;
  }
  
  return Rcpp::wrap(results_at);
}
