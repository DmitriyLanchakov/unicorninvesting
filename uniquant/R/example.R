source('constant.R')
source('util/utils.R')

source('entity/user.R')
source('entity/portfolio.R')
source('entity/holding.R')

mirror      <-  Sys.getenv('UNIQUANT_PACKAGE_MIRROR', DEFAULT_MIRROR)
log.DEBUG   <<- TRUE

log.info('setup', paste('Installing necessary dependencies:', join(REQUIRED_PACKAGES, ', ')))
install.package(REQUIRED_PACKAGES, mirror = mirror)

username    <- 'achillesrasquinha'
password    <- '12345'
portname    <- 'My Portfolio'

if ( !user.exists(username) ) {
  log.info('setup', paste('Registering a User:', username))

  user      <- user.register(
    username  = username,
    firstname = 'Achilles',
    lastname  = 'Rasquinha',
    email     = 'achillesrasquinha@gmail.com',
    password  = password,
    dob       = '1995-08-14',
    gender    = gender.MALE
  )

  log.success('setup', paste('Successfully registered User:', username))
} else {
  user      <- user.get(username, password)
}

# if ( !is.true(portfolio.exists(user, name = portname)) ) {
#   portfolio <- user.register_portfolio(user, name = portfolio)
# } else {
#   portfolio <- portfolio.get(user, name = portfolio)
# }
#
# holding <- portfolio.add_holding(portfolio, type = holding.type.FOREX, params = list(
#     from   = forex.USD,
#     to     = forex.CAD,
#     amount = 300
# ))
