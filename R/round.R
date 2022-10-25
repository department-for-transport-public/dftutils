#' Round numbers according to statistical principles rather than data science ones
#' i.e. numbers ending in a 5 will always be rounded up, regardless of preceeding number
#
#' @param x a numeric value
#' @param digits integer indicating the number of decimal places.
#' Negative values are allowed; Rounding to a negative number of digits means rounding to a power of ten, so for example round(x, digits = -2) rounds to the nearest hundred.
#'
#' @name round
#' @export

round <- function(x, digits = 0){

  posneg = sign(x)
  z = abs(x)*10^digits
  z = z + 0.5 + sqrt(.Machine$double.eps)
  z = trunc(z)
  z = z/10^digits
  z*posneg

}

