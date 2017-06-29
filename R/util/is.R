INSTALLED_PACKAGES <- rownames(installed.packages())

#' is.installed
#'
#' Checks whether a package has been installed.
#' @param string package name
#' @return logical TRUE if the package has been installed.
#' @examples
#' is.installed('ggplot2')
is.installed  <- function (package) {
  if (package %in% INSTALLED_PACKAGES) {
    installed <- TRUE
  } else {
    installed <- FALSE
  }

  return(installed)
}

is.true       <- function (x) {
  evaluation  <- x == TRUE

  return(evaluation)
}

is.empty      <- function (x) {
  evaluation  <- length(x) == 0

  return(evaluation)
}