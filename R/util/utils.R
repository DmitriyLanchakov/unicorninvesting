source('util/log.R')
source('util/is.R')
source('util/install.R')
source('util/assign.R')

#' join
#'
#' Returns a string seperated by a defined seperator.
#' @param list list of strings
#' @param seperator, defaults to ''
#' @examples
#' join(c('a', 'b'), seperator = ', ')
#' [1] "a, b"
join     <- function (list, seperator = '') {
  string <- paste(list, collapse = seperator)

  return(string)
}

urljoin  <- function (list) {
  string <- join(list, seperator = '/')

  return(string)
}
