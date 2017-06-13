# uniquant

### Environment Variables
* `UNIQUANT_PACKAGE_MIRROR`: *CRAN mirror to download packages from. (default - http://cran.us.r-project.org)*

#### Database Environment Variables
* `UNIQUANT_DB_NAME`: Database Name (default - `uniquant`)
* `UNIQUANT_DB_HOST`: Host Name for your database (default - `127.0.0.1`)
* `UNIQUANT_DB_PORT`: Port Number for your database (default - `0`)
* `UNIQUANT_DB_USER`: A database username (default - `root`)
* `UNIQUANT_DB_PASS`: Password for the said username (default - `toor`)
* `UNIQUANT_DB_PREFIX`: Prefixes for table names (default - `UNIQUANT_DB_NAME_tablename`)
* `UNIQUANT_PASSWORD_SALT`: A numeric salt value for the **bcrypt** password hashing algorithm. Bigger the number, bigger the complexity for encryption/decryption. (default - `10`)

### Example
Run the `setup.R` script as follows:
```console
$ Rscript setup.R
```

### Logging
`uniquant` has a neat color-coded logging framework. To launch into debug mode, simply:
```r
> log.DEBUG <- TRUE
```

You should then have your terminal outputs as follows:
![](.github/logging.png)

### Documentation

* #### Entities
  * ##### Users
    * `user.register`
      A helper function to register new users. Returns a `data.frame` with a single row containing user details. Passwords are **bcrypt hashed**.
      ```r
      > source('constant.R')    # gender
      > source('entity/user.R')

      > user.register(
      +   username  = 'achillesrasquinha',
      +   firstname = 'Achilles',
      +   lastname  = 'Rasquinha',
      +   email     = 'achillesrasquinha@gmail.com',
      +   password  = '12345',
      +   dob       = '1995-08-14',
      +   gender    = gender.MALE
      + )
      ```
    * `user.get`
      A helper function to retrieve user information. Requires a `username` and `password`.
      ```r
      > source('entity/user.R')
      > user.get('achillesrasquinha', '12345')
      ```
