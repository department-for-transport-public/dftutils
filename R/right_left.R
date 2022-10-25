#' Equivalent of right in SQL; takes the specified number of characters from
#' the right hand side of a string.
#' @param x a string or vector of strings
#' @param n integer. Number of characters you want to extract from the string.
#' Defaults to 1.
#'
#' @export
#' @name right

right <- function(x, n = 1){

  ##Check n value is an integer
  if(as.integer(n) != n){
    stop("Value of n is not an integer")
  }

  substr(x,
         nchar(x) - (n - 1),
         nchar(x))

}

#' Equivalent of left in SQL; takes the specified number of characters from
#' the left hand side of a string.
#' @param x a string or vector of strings
#' @param n integer. Number of characters you want to extract from the string.
#'
#' @export
#' @name left

left <- function(x, n = 1) {

  ##Check n value is an integer
  if(as.integer(n) != n){
    stop("Value of n is not an integer")
  }

  substr(x, 1, n)

}

