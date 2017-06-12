DEBUG       <<- TRUE

log.format  <- function (tag, message) {
  statement <- paste(tag, ': ', message)

  return(statement)
}

log.debug   <- function (tag, message) {
  if (DEBUG) {
    format  <- log.format(tag, message)

    print(format)
  }
}
