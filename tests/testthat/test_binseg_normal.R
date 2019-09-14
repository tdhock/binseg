library(testthat)
library(binseg)
context("binseg_normal")

test_that("error for 0 data", {
  x <- double()
  expect_error({
    .C(
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
  }, "no data")
})

test_that("error for 0 segments", {
  x <- c(4.1, 4, 1.1, 1)
  expect_error({
    .C(
      "binseg_normal_interface",
      data.vec=as.double(x),
      size=as.integer(length(x)),
      Kmax=as.integer(0),
      end.vec=integer(length(x)),
      cost=double(length(x)),
      before.mean=double(length(x)),
      after.mean=double(length(x)),
      before.size=integer(length(x)),
      after.size=integer(length(x)),
      invalidates.index=integer(length(x)),
      invalidates.after=integer(length(x)),
      PACKAGE="binseg")
  }, "no segments")
})

test_that("error for too many segments", {
  x <- c(4.1, 4, 1.1, 1)
  expect_error({
    .C(
      "binseg_normal_interface",
      data.vec=as.double(x),
      size=as.integer(length(x)),
      Kmax=as.integer(5),
      end.vec=integer(length(x)),
      cost=double(length(x)),
      before.mean=double(length(x)),
      after.mean=double(length(x)),
      before.size=integer(length(x)),
      after.size=integer(length(x)),
      invalidates.index=integer(length(x)),
      invalidates.after=integer(length(x)),
      PACKAGE="binseg")
  }, "too many segments")
})

test_that("equal split cost is ok", {
  x <- c(0, 0.1, 1, 1.1, 0, 0.1)
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
  expect_equal(sort(L$end.vec[1:3]), c(1, 3, 5))
  m <- mean(x)
  expect_equal(L$before.mean[1], m)
  const.term <- -sum(x^2)
  ## cost does not include the constant x^2 term.
  expect_equal(L$cost[1], sum(m*(m-2*x)))
  expect_equal(L$cost[6], const.term)
  m <- c(0.05, 0.05, 1.05, 1.05, 0.05, 0.05)
  expect_equal(L$cost[3], sum(m*(m-2*x)))
})

