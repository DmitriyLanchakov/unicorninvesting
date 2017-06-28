source('constant.R')
source('util/utils.R')

source('data/load.R')

cache.histdata <- function (refresh = FALSE) {
  path         <- file.path(path.SCRAPERS, "scrape.py")
  command      <- paste("python", path)

  log.info('cache.R', paste('Executing command', command))

  system(command)

  load.histdata()
}

cache.FOREX    <- function (pairs = NULL, from = '', to = Sys.time()) {
  cache.histdata()
}
