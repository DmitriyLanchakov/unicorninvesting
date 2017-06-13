source('util/is.R')
source('entity/user.R')
source('entity/portfolio.R')
source('entity/holding.R')
source('entity/holding/forex.R')

REQUIRED_PACKAGES <- readLines('assets/dependencies.txt')
DEFAULT_MIRROR    <- 'http://cran.us.r-project.org'

for (i in 1:length(REQUIRED_PACKAGES)) {
  package <- REQUIRED_PACKAGES[i]

  if ( !is.installed(package) ) {
    install.packages(package, repos = DEFAULT_MIRROR)
  }
}

user <- user.register(username = 'achillesrasquinha', firstname = 'Achilles',
                      lastname = 'Rasquinha', email = 'achillesrasquinha@gmail.com',
                      password = '12345', dob = '1995-08-14', gender = 1)

if ( !is.null(user) ) {
  port <- user.register_portfolio(user, name = 'My Portfolio')

  hold <- portfolio.register_holding(port, type = holding.type.FOREX, params = list(
    from = forex.USD,
    to   = forex.CAD
  ))
}
