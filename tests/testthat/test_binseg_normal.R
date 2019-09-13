library(testthat)
library(binseg)
context("binseg_normal")

test_that("equal split cost is ok", {
  x <- c(0, 0.1, 1, 1.1)
  L <- .C(
    "binseg_normal_interface",
    data.vec=as.double(x),
    size=as.integer(length(x)),
    Kmax=as.integer(length(x)),
    end.vec=integer(length(x)),
    cost=double(length(x)),
    before.mean=double(length(x)),
    after.mean=double(length(x)),
    before.size=integer(length(x)),
    after.size=integer(length(x)),
    invalidates.index=integer(length(x)),
    invalidates.after=integer(length(x)),
    PACKAGE="binseg")
  print(L)
})
