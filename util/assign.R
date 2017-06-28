assign.if.na <- function (a, b) {
  if ( is.na(a) ) {
    return(b)
  }

  return(a)
}
