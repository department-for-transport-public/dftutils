test_that("numbers are rounded as expected", {
  expect_equal(round(2.5), 3)
  expect_equal(round(2.4), 2)
})

test_that("choosing digits works", {
  expect_equal(round(2.54, 1), 2.5)
  expect_equal(round(2.54, 2), 2.54)
})
