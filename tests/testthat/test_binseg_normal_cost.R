library(testthat)
library(binseg)
context("binseg_normal_cost")

test_that("equal split cost is ok", {
  x <- c(0, 0.1, 1, 1.1, 0, 0.1)
  L <- .C(
    "binseg_normal_cost_interface",
    data.vec=as.double(x),
    size=as.integer(length(x)),
    Kmax=as.integer(length(x)),
    cost=double(length(x)),
    PACKAGE="binseg")
  print(L)
})
