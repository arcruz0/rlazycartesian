# `rlazycartesian`

[[**Documentation**]](https://arcruz0.github.io/extra/rlazycartesian/)

An R interface for Lazy Cartesian Products. Provides memory-efficient ways to obtain elements (including random samples) from Cartesian Products. Partial wrapper of the [`lazy-cartesian-product`](https://github.com/tylerburdsall/lazy-cartesian-product) C++ library.

## Installation

``` r
install.packages("remotes") # if not installed
remotes::install_github("arcruz0/rlazycartesian")
```

## Example

In R, `expand.grid()` gives the Cartesian Product of multiple elements:

``` r
l <- list(x = paste0("x", 1:500, sep = ""),
          y = paste0("y", 1:500, sep = ""),
          z = paste0("z", 1:500, sep = ""))
eg <- expand.grid(l)
head(eg)
#>    x  y  z
#> 1 x1 y1 z1
#> 2 x2 y1 z1
#> 3 x3 y1 z1
#> 4 x4 y1 z1
#> 5 x5 y1 z1
#> 6 x6 y1 z1
nrow(eg)
#> [1] 125000000
```

Suppose you need a random sample of 1,000 elements from this Cartesian Product. `rlazycartesian` can do this without generating all elements in advance, which is fast and consumes very little RAM (see [Benchmarks](#benchmarks) below):

``` r
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

## A note on element indices

Element indices from `rlazycartesian` are equivalent to indices from a sorted `expand.grid()`:

``` r
eg <- eg[order(eg$x, eg$y, eg$z),]
rownames(eg) <- NULL
eg[c(12345, 98765),]
#>        x    y    z
#> 12345 x1  y25 z345
#> 98765 x1 y198 z265

rlazycartesian::get_elements(l, c(12345, 98765))
#>   .element  x    y    z
#> 1    12345 x1  y25 z345
#> 2    98765 x1 y198 z265
```

## Benchmarks

For the random sample example above, compare performance (`Elapsed_Time_sec`) and peak RAM usage (`Peak_RAM_Used_MiB`):

```r
peakRAM::peakRAM(
  {
    eg <- expand.grid(l)
    eg[sample(1:nrow(eg), 1000),]
  }, 
  rlazycartesian::get_random_sample(l, 1000)
)
#>                                      Function_Call Elapsed_Time_sec
#> 1 {eg<-expand.grid(l)eg[sample(1:nrow(eg),1000),]}            4.414
#> 2        rlazycartesian::get_random_sample(l,1000)            0.001
#>   Total_RAM_Used_MiB Peak_RAM_Used_MiB
#> 1                0.1            2862.2
#> 2                0.1               0.2
```
