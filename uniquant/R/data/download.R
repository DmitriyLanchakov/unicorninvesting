source('constant.R')
source('util/utils.R')

download.histdata <- function (params = list()) {
  path            <- file.path(path.SCRAPERS, "histdata.py")
  command         <- paste("python", path)

  log.info('download.R', paste('Executing command', command))

  system(command)
}

download.FOREX    <- function (pairs  = NULL, from = '', to = Sys.time()) {
  download.histdata()
}
