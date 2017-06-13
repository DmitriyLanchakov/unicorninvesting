source('util/log.R')
source('util/is.R')
source('util/install.R')
source('util/assign.R')

join     <- function (list, seperator) {
  string <- paste(list, collapse = seperator)

  return(string)
}
