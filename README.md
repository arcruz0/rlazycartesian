# `rlazycartesian`

[[**Documentation**]](https://arcruz0.github.io/extra/rlazycartesian/)

An R interface for Lazy Cartesian Products. Provides memory-efficient ways to obtain elements (including random samples) from Cartesian Products. Partial wrapper of the [`lazy-cartesian-product`](https://github.com/tylerburdsall/lazy-cartesian-product) C++ library.

## Installation

``` r
install.packages("remotes") # if not installed
remotes::install_github("arcruz0/rlazycartesian")
```

## Example

Suppose you need a random sample of 1,000 elements from a Cartesian Product of 125M elements. `rlazycartesian` can do this without generating all elements in advance (as `expand.grid()` would do), which is fast and consumes very little RAM---see [Benchmarks](#benchmarks) below.

``` r
l <- list(x = paste0("x", 1:500, sep = ""),
          y = paste0("y", 1:500, sep = ""),
          z = paste0("z", 1:500, sep = ""))

set.seed(1)
head(rlazycartesian::get_random_sample(l, 1000))
#>   .element    x    y    z
#> 1 66608964 x267 y218 z464
#> 2 44492929 x178 y486 z429
#> 3 60941821 x244 y384 z321
#> 4 30845227 x124 y191 z227
#> 5 17633234  x71 y267 z234
#> 6 79310131 x318 y121 z131
```

## A note on element indices and `expand.grid()`

Element indices from `rlazycartesian` are equivalent to indices from a sorted `expand.grid()`:

``` r
rlazycartesian::get_elements(l, c(12345, 98765))
#>   .element  x    y    z
#> 1    12345 x1  y25 z345
#> 2    98765 x1 y198 z265

eg <- expand.grid(l)
eg <- eg[order(eg$x, eg$y, eg$z),]
rownames(eg) <- NULL
eg[c(12345, 98765),]
#>        x    y    z
#> 12345 x1  y25 z345
#> 98765 x1 y198 z265
```

## Benchmarks

For the random sample example above, compare performance (`Elapsed_Time_sec`) and peak RAM usage (`Peak_RAM_Used_MiB`):

``` r
peakRAM::peakRAM(
  rlazycartesian::get_random_sample(l, 1000),
  {eg <- expand.grid(l); eg[sample(1:nrow(eg), 1000),]}
)
#>                                      Function_Call Elapsed_Time_sec
#> 1        rlazycartesian::get_random_sample(l,1000)            0.095
#> 2 {eg<-expand.grid(l)eg[sample(1:nrow(eg),1000),]}            4.538
#>   Total_RAM_Used_MiB Peak_RAM_Used_MiB
#> 1                0.9               6.8
#> 2             1430.6            1907.4
```