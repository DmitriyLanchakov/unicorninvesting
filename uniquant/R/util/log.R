log.DEBUG  <<- TRUE
log.INFO    <- 'log.INFO'
log.WARN    <- 'log.WARN'
log.DANGER  <- 'log.DANGER'

#' log.format
#'
#' Generates a format string for a given tag and message.
#' @param string tag
#' @param string message
#' @return string formatted log string
#' @examples
#' log.format('test.R', 'My Message')
log.format  <- function (tag, message, type = NULL) {
  statement <- paste(tag, ': ', message, sep = '')

  return(statement)
}

log.debug   <- function (tag, message) {
  if (log.DEBUG) {
    format  <- log.format(tag, message)

    message(format)
  }
}

log.info    <- function (tag, message) {
  if (log.DEBUG) {
    format  <- log.format(tag, message, type = log.INFO)

    message(format)
  }
}

log.warn    <- function (tag, message) {
  if (log.DEBUG) {
    format  <- log.format(tag, message, type = log.WARN)

    message(format)
  }
}

log.danger  <- function (tag, message) {
  if (log.DEBUG) {
    format  <- log.format(tag, message, type = log.DANGER)

    message(format)
  }
}
