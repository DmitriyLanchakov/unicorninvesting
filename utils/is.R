INSTALLED_PACKAGES <- rownames(installed.packages())

#' is.installed
#'
#' A function to check whether a package has been installed.
#' @param package A valid package name
#' @keywords package, installed
#' @examples
#' > is.installed('ggplot2')
#' > [1] FALSE
is.installed = function (package) {
  # TODO: create a ternary operator instead
  if ( package %in% INSTALLED_PACKAGES ) {
    installed <- TRUE
  } else {
    installed <- FALSE
  }
  
  return(installed)
}
