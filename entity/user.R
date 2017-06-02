source('data/db.R')

user.register <- function (username, firstname, lastname, email, password, dob, gender) {
  values      <- list(
    username  = username,
    firstname = firstname,
    lastname  = lastname,
    email     = email,
    password  = password,
    dob       = dob,
    gender    = gender
  )

  db.insert('uniquant_users', values)
}
