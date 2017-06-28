source('util/is.R')

#' install.packages
#'
#' Installs packages only if the package has not been installed.
#' @param packages vector of package names
#' @param string mirror
#' @examples
#' install.packages(c("ggplot2", "RMySQL"))
install.package <- function (packages, mirror) {
  for (i in 1:length(packages)) {
    package <- packages[i]

    if ( !is.installed(package) ) {
      install.packages(package, repos = mirror)
    }
  }
}
