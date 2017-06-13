source('constant.R')
source('util/utils.R')

source('entity/user.R')

mirror      <- Sys.getenv('UNIQUANT_PACKAGE_MIRROR', DEFAULT_MIRROR)

log.info('setup', paste('Installing necessary dependencies:', join(REQUIRED_PACKAGES, ', ')))
install.packages(REQUIRED_PACKAGES, mirror = mirror)

username    <- 'achillesrasquinha'
log.info('setup', paste('Registering a User:', username))
user        <- user.register(
  username  = username,
  firstname = 'Achilles',
  lastname  = 'Rasquinha',
  email     = 'achillesrasquinha@gmail.com',
  password  = '12345',
  dob       = '1995-08-14',
  gender    = gender.MALE
)

if ( !is.null(user) ) {
  log.success('setup', paste('Successfully registered User:', username))

  
} else {
  log.danger('setup', paste('Error in registering User:', username))
}
