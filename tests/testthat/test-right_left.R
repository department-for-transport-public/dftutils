test_that("right and left extract values from the correct side", {
  expect_equal(right("testing"), "g")
  expect_equal(left("testing"), "t")
})

test_that("n argument can be set to any integer", {
  expect_equal(right("testing", 3), "ing")
  expect_equal(left("testing", 4), "test")

  expect_error(right("testing", 0.5))
  expect_error(left("testing", 0.1))
})


test_that("left and right work on vectors", {
  expect_equal(right(c("this", "testing"), 2), c("is", "ng"))
  expect_equal(left(c("this", "testing"), 2), c("th", "te"))

})
