# tests/testthat/test-check_package_v.R

library(testthat)
library(renv)

local_mocked_bindings(
  record = function(records, lockfile){
    return(records)
  }
)

# Check that the function returns the correct message
test_that("check_package_v gives the message expected", {

  package_deets <- list(Package = "dplyr", Version = "1.0.0")

  problem_libs <- data.frame(
    package = "dplyr",
    version = "1.1.0",
    stringsAsFactors = FALSE
  )

  expect_message(check_package_v(package_deets, problem_libs, "renv.lock"),
                 "dplyr version updated to 1.1.0")
})

test_that("check_package_v doesn't update if not required", {
  # Mock package details
  package_deets <- list(Package = "dplyr", Version = "1.1.0")

  # Mock problem packages data frame
  problem_libs <- data.frame(
    package = "dplyr",
    version = "1.1.0",
    stringsAsFactors = FALSE
  )

  # Lockfile path
  lockfile_path <- "renv.lock"

  expect_message(check_package_v(package_deets, problem_libs, "renv.lock"),
                 "dplyr already at correct version")
})

test_that("check_package_v handles unusual numbering of versions", {
  # Mock package details
  package_deets <- list(Package = "ggplot2", Version = "3.3.13")

  # Mock problem packages data frame
  problem_libs <- data.frame(
    package = "ggplot2",
    version = "3.4.1",
    stringsAsFactors = FALSE
  )

  expect_message(check_package_v(package_deets, problem_libs, "renv.lock"),
                 "ggplot2 version updated to 3.4.1")

})

test_that("check_package_v handles unusual numbering of versions", {
  # Mock package details
  package_deets <- list(Package = "Matrix", Version = "14.12-4")

  # Mock problem packages data frame
  problem_libs <- data.frame(
    package = "Matrix",
    version = "15.0-1",
    stringsAsFactors = FALSE
  )

  expect_message(check_package_v(package_deets, problem_libs, "renv.lock"),
                 "Matrix version updated to 15.0-1")
})
