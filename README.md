
<!-- README.md is generated from README.Rmd. Please edit that file -->

# npdsim

<!-- badges: start -->
<!-- badges: end -->

The goal of npdsim is to simulate the demand for ready to launch new
products, and to simulate their attributes. The generated data will help
you test and compare your new product demand forecasting approaches. The
simulation of demand is based on the idea that each product has a demand
level and a demand shape: level is the cumulative demand of the product
over a specific number of time periods (the number of time periods is
set by the user), and shape is the normalized demand over those periods.
The product attributes are assumed to be linked to the shape and the
level of the concerned product. The generated demand and attributes will
help you evaluate the performance of your forecasting approach.

## Installation

You can install the development version of npdsim from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mohammedhichame/npdsim")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(npdsim)
## basic example code
```
