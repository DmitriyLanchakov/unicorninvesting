source('constant.R')
source('util/utils.R')

mirror      <-  PACKAGE_MIRROR
log.DEBUG   <<- TRUE

log.info('setup', paste('Installing necessary dependencies:', join(REQUIRED_PACKAGES, ', ')))
install.package(REQUIRED_PACKAGES, mirror = mirror, dependencies = TRUE)

# Shit, why? What was I even thinking?
if ( dir.exists(path.CACHE) ) {
  unlink(path.CACHE, recursive = TRUE, force = TRUE)
}

dir.create(path.CACHE)
