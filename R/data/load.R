library(stringr)

source('constant.R')
source('util/utils.R')

load.histdata <- function () {
  dirpath     <- file.path(path.CACHE, 'histdata')
  pattern     <- 'HISTDATA_COM_ASCII_[A-Z]{6}_T.*\\.zip'

  log.info('load.R', paste('Searching for files of type', pattern))

  zips        <- file.path(dirpath, list.files(path = dirpath, pattern = pattern))

  for (i in 1:length(zips)) {
    files     <- unzip(zips[i], list = TRUE)
    csv       <- files$Name[1]

    pair      <- sub('DAT_ASCII_', '', sub('_T_[0-9]{6}.csv', '', csv))
    symbol    <- str_c(str_sub(pair, end = 3), "/", str_sub(pair, start = 4))

    buffer    <- unz(zips[i], csv)
    data      <- read.csv(buffer)
  }
}
